import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_approval/bloc/team_bloc.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/dto/team_details.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/common/dashboard_bottom_navigationbar.dart';
import 'package:project_approval/screens/common/dashboard_drawer.dart';
import 'package:project_approval/screens/common/widgets/body_data_table.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/db_services/supervisor_services.dart';
import 'package:project_approval/services/db_services/team_database_service.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';
import 'package:project_approval/utils/style.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;

  TeamScreen({
    this.snapshot,
  });

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  bool isLoading = true;
  List<TeamDetails> teamList = [];

  @override
  void initState() {
    ///get team details
    getTeamList(widget.snapshot);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String userType = widget.snapshot.data["USER_TYPE"];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: DashboardDrawer(
          snapshot: widget.snapshot,
        ),
        appBar: dashboardAppBar,
        body: isLoading
            ? LoadingScreen()
            : TeamScreenBody(
                snapshot: widget.snapshot,
                teamList: teamList,
                userType: userType,
                reloadFunction: getTeamList,
              ),
        bottomNavigationBar: DashboardBottomNavigationBar(
          snapshot: widget.snapshot,
          selectedNavIndex: teamIndex,
        ),
      ),
    );
  }

  void getTeamList(DocumentSnapshot userDocSnapshot) async {
    LoadingScreen();
    await teamReference
        .orderBy('DateTime', descending: true)
        .getDocuments()
        .then((querySnapshot) async {
      teamList.clear();

      ///querySnapshot -> Instance of 'QuerySnapshot'
      if (querySnapshot != null) {
        for (var doc in querySnapshot.documents) {
          Team team = Helper().generateTeamData(doc);
          String supervisorId = doc.data["SupervisorId"];
          SupervisorService service = new SupervisorService();

          await userReference
              .where("Id", isEqualTo: supervisorId)
              .getDocuments()
              .then((sData) {
            if (sData.documents.length != 0) {
              Supervisor s =
                  service.supervisorFromDynamicMap(sData.documents[0].data);
              TeamDetails td;
              if (s.branch == userDocSnapshot.data["Branch"]) {
                td = new TeamDetails(team: team ?? new Team(), supervisor: s);
              }
              if (td != null) {
                teamList.add(td);
              }
            }
          });
        }
      }
    });
    setState(() {
      isLoading = false;
    });
  }
}

class TeamScreenBody extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final List<TeamDetails> teamList;
  final String userType;
  final Stream teamDataList;
  final Function reloadFunction;

  TeamScreenBody(
      {this.snapshot,
      this.teamList,
      this.userType,
      this.teamDataList,
      this.reloadFunction});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomLoginScreenBottomClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 140,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        color: Colors.cyanAccent.withOpacity(.4),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50.0),
                        child: Column(
                          children: [
                            userType == supervisorType
                                ? CreateTeamSection(
                                    snapshot: snapshot,
                                    reloadFunction: reloadFunction,
                                  )
                                : Container(),
                            userType == supervisorType
                                ? SizedBox(
                                    height: 20,
                                  )
                                : Container(),
                            SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: StreamBuilder(
                                  stream: teamDataList,
                                  builder: (context, streamSnapshot) {
                                    return BodyDataTable(
                                      teamList: teamList,
                                      snapshot: snapshot,
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///create team body
class CreateTeamSection extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final Function reloadFunction;

  CreateTeamSection({this.snapshot, this.reloadFunction});

  @override
  _CreateTeamSectionState createState() => _CreateTeamSectionState();
}

class _CreateTeamSectionState extends State<CreateTeamSection> {
  bool createTeamButtonToggler = true;
  bool isLoading = false;
  String error = "";
  Color errorColor = Colors.redAccent;
  String teamName = "";
  int teamCapacity = 0;
  final teamBloc = new TeamBloc();
  TextEditingController textEditingController;

  void setCapacityToTeamCapacity(int capacity) {
    ///don't use setState((){}) method
    textEditingController = TextEditingController(text: capacity.toString());
    if (capacity.toString() != null) {
      textEditingController.selection =
          TextSelection.collapsed(offset: textEditingController.text.length);
    } else {
      textEditingController.selection = TextSelection.collapsed(offset: 0);
    }
  }

  @override
  void initState() {
    super.initState();
    setCapacityToTeamCapacity(teamCapacity);

    teamBloc.name.listen((event) {
      teamName = event;
    });

    teamBloc.teamCapacity.listen((event) {
      teamCapacity = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        createTeamButtonToggler
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      resetForm();
                      setState(() {
                        error = "";
                        createTeamButtonToggler = !createTeamButtonToggler;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(gradient: gradientAddButton),
                      child: Text(
                        'Create Team',
                        style: appBarTitleStyle.copyWith(
                            fontFamily: "Roboto Bold",
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    ),
                  )
                ],
              )
            : Container(),
        !createTeamButtonToggler
            ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 3,
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            child: StreamBuilder<String>(
                                stream: teamBloc.name.map((event) {
                              return teamName;
                            }), builder: (context, snapshot) {
                              return TextField(
                                onChanged: teamBloc.nameChanged,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                style: appBarTitleStyle.copyWith(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontFamily: "Open Sans Bold"),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: -5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  hintText: "Enter Team Name",
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontFamily: "Raleway Bold"),
                                  labelText: "Enter Team Name",
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      fontFamily: "Raleway Bold"),
                                  errorText: snapshot.error,
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: StreamBuilder<int>(
                                stream: teamBloc.teamCapacity.map((event) {
                              setCapacityToTeamCapacity(event);
                              return teamCapacity;
                            }), builder: (context, snapshot) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: TextField(
                                      controller: textEditingController,
                                      textDirection: TextDirection.ltr,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly,
                                      ],
                                      onChanged: (capacity) {
                                        if (capacity.trim().length < 1) {
                                          return teamBloc
                                              .teamCapacityChanged(0);
                                        }
                                        return teamBloc.teamCapacityChanged(
                                            (int.parse(capacity)));
                                      },
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      style: appBarTitleStyle.copyWith(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontFamily: "Open Sans Bold"),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: -5),
                                        hintText: "Team Capacity [1-60]",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            decoration: TextDecoration.none,
                                            fontFamily: "Raleway Bold"),
                                        labelText: "Team Capacity",
                                        labelStyle: TextStyle(
                                            fontSize: 12,
                                            decoration: TextDecoration.none,
                                            fontFamily: "Raleway Bold"),
                                        errorText: snapshot.error,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (teamCapacity < 60) {
                                              setCapacityToTeamCapacity(
                                                  ++teamCapacity);
                                              teamBloc.teamCapacityChanged(
                                                  teamCapacity);
                                            }
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_up,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (teamCapacity > 0) {
                                              setCapacityToTeamCapacity(
                                                  --teamCapacity);
                                              teamBloc.teamCapacityChanged(
                                                  teamCapacity);
                                            }
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          error != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        error,
                                        style: appBarTitleStyle.copyWith(
                                          color: errorColor,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          isLoading
                              ? Container(
                                  constraints: BoxConstraints(
                                    minHeight: 80,
                                  ),
                                  child:
                                      Center(child: TransparentLoadingScreen()))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: gradientCancelFacultyButton,
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          resetForm();
                                          setState(() {
                                            error = "";
                                            createTeamButtonToggler =
                                                !createTeamButtonToggler;
                                          });
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: defaultTextStyle.copyWith(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    StreamBuilder<bool>(
                                        stream: teamBloc.submitCheck,
                                        builder: (context, submitSnapshot) {
                                          return Container(
                                            height: 40,
                                            decoration: (submitSnapshot
                                                        .hasData &&
                                                    teamName.isNotEmpty &&
                                                    teamCapacity != 0)
                                                ? BoxDecoration(
                                                    gradient:
                                                        gradientAddFacultyButton,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                  )
                                                : BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                  ),
                                            child: FlatButton(
                                              onPressed:
                                                  (submitSnapshot.hasData &&
                                                          teamName.isNotEmpty &&
                                                          teamCapacity != 0)
                                                      ? () async {
                                                          setState(() =>
                                                              isLoading = true);
                                                          createNewTeam();
                                                        }
                                                      : null,
                                              child: Text(
                                                'Create Team',
                                                style:
                                                    defaultTextStyle.copyWith(
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  void resetForm() {
    setState(() {
      textEditingController.text = "0";
      teamCapacity = 0;
      teamName = "";
    });
  }

  ///let's create the new team
  void createNewTeam() async {
    DocumentSnapshot snapshot = widget.snapshot;
    if (snapshot == null) {
      ///navigate to login screen
      print("snapshot in createNewTeam() is null!");
    } else {
      String hodBranch = snapshot.data["Branch"] ?? "TEAM";
      String teamId = hodBranch + "-" + Helper().getRandomString(4);
      final TeamDatabaseService _teamDatabaseService =
          new TeamDatabaseService(uid: teamId);
      Team team = new Team(
        id: teamId,
        name: teamName,
        capacity: teamCapacity,
        dateTime: new DateTime.now(),
        memberRequired: teamCapacity,
        supervisorId: widget.snapshot.data["Id"],
      );

      dynamic result = await _teamDatabaseService.updateTeamData(team);
      setState(() {
        isLoading = false;
      });

      if (result == null) {
        ///means success
        error = "Team created successfully!";
        errorColor = Colors.green;
        resetForm();
        widget.reloadFunction(snapshot);
      } else {
        error = result.toString();
        errorColor = Colors.redAccent;
      }
    }
  }
}
