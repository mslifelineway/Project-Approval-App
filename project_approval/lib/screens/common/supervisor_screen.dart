import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/bloc/supervisor_bloc.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/screens/common/widgets.dart';
import 'package:project_approval/screens/common/widgets/supervisor_list_table.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/principal_services.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';
import 'package:project_approval/utils/style.dart';

class SupervisorScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;

  SupervisorScreen({this.snapshot});

  @override
  _SupervisorScreenState createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  bool isLoading = true;
  List<Supervisor> supervisorList = [];

  @override
  void initState() {
    ///get all supervisor details
    getSupervisorList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            iconTheme: new IconThemeData(
              color: Colors.black87,
            ),
            backgroundColor: Colors.cyanAccent,
            title: Text(
              'Supervisors',
              style: appBarTitleStyle.copyWith(fontFamily: "RedRose Bold"),
            ),
            centerTitle: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: isLoading
              ? LoadingScreen()
              : SupervisorScreenBody(
                  snapshot: widget.snapshot,
                  supervisorList: supervisorList,
                )),
    );
  }

  void getSupervisorList() async {
    await userReference
        .where("USER_TYPE", isEqualTo: supervisorType)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot != null) {
        for (var doc in querySnapshot.documents) {
          supervisorList.add(Helper().generateSupervisorData(doc));
        }
        if (supervisorList.length == 0)
          setState(() {
            isLoading = false;
          });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    setState(() {
      isLoading = false;
    });
  }
}

class SupervisorScreenBody extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final List<Supervisor> supervisorList;

  SupervisorScreenBody({
    this.snapshot,
    this.supervisorList,
  });

  @override
  Widget build(BuildContext context) {
    final String userType = snapshot.data["USER_TYPE"];
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
                      minHeight: MediaQuery.of(context).size.height - 56,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        color: Colors.cyanAccent.withOpacity(.4),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            userType == principalType
                                ? AddSupervisorSection(snapshot: snapshot)
                                : Container(),
                            SizedBox(
                              height: 50,
                            ),
                            SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: SupervisorListTable(
                                  supervisorList: supervisorList),
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

class AddSupervisorSection extends StatefulWidget {
  final DocumentSnapshot snapshot;

  AddSupervisorSection({this.snapshot});

  @override
  _AddSupervisorSectionState createState() => _AddSupervisorSectionState();
}

class _AddSupervisorSectionState extends State<AddSupervisorSection> {
  bool addHodButtonToggler = true;
  final PrincipalService _principalService = new PrincipalService();
  bool isLoading = false;
  String error = "";
  Color errorColor = Colors.redAccent;
  int selectedBranchIndex = 0;
  bool isBranchSelected = true;
  String emailText = "";
  String nameText = "";
  final supervisorBloc = new SupervisorBloc();

  ///isBranchSelected - just to show red border if not selected but initially it will be true because we don't want to show red border initially
  @override
  void initState() {
    super.initState();
    supervisorBloc.email.listen((event) {
      emailText = event;
    });

    supervisorBloc.name.listen((event) {
      nameText = event;
    });
    supervisorBloc.branch.listen((event) {
      selectedBranchIndex = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addHodButtonToggler
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      resetForm();
                      setState(() {
                        error = "";
                        addHodButtonToggler = !addHodButtonToggler;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(gradient: gradientAddButton),
                      child: Text(
                        'Add Supervisor',
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
        !addHodButtonToggler
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
                                stream: supervisorBloc.name.map((event) {
                              return nameText;
                            }), builder: (context, snapshot) {
                              return TextField(
                                onChanged: supervisorBloc.nameChanged,
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
                                  hintText: "Enter Name",
                                  hintStyle: TextStyle(
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
                            child: StreamBuilder<String>(
                                stream: supervisorBloc.email.map((event) {
                              return emailText;
                            }), builder: (context, snapshot) {
                              return TextField(
                                onChanged: supervisorBloc.emailChanged,
                                keyboardType: TextInputType.emailAddress,
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
                                  hintText: "Enter Email ID",
                                  hintStyle: TextStyle(
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
                          StreamBuilder<int>(
                              stream: supervisorBloc.branch.map((event) {
                            if (event != 0)
                              isBranchSelected = true;
                            else
                              isBranchSelected = false;
                            return selectedBranchIndex;
                          }), builder: (context, snapshot) {
                            return Container(
                              height: 45,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: isBranchSelected
                                      ? Colors.grey
                                      : Colors.redAccent,
                                ),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: PopupMenuButton(
                                onSelected: supervisorBloc.branchChanged,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${branches[selectedBranchIndex]}',
                                      style: appBarTitleStyle.copyWith(
                                          fontSize: 12,
                                          decoration: TextDecoration.none,
                                          fontFamily: "Raleway Bold",
                                          color: Colors.black87),
                                    ),
                                    Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                                itemBuilder: (BuildContext context) {
                                  return branchPopupMenuItems;
                                },
                              ),
                            );
                          }),
                          error != null
                              ? SizedBox(
                                  height: 20,
                                )
                              : Container(),
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
                                            addHodButtonToggler =
                                                !addHodButtonToggler;
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
                                        stream: supervisorBloc
                                            .addSupervisorSubmitCheck,
                                        builder: (context, submitSnapshot) {
                                          return Container(
                                            height: 40,
                                            decoration: (submitSnapshot
                                                        .hasData &&
                                                    nameText.isNotEmpty &&
                                                    emailText.isNotEmpty &&
                                                    selectedBranchIndex != 0)
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
                                              onPressed: (submitSnapshot
                                                          .hasData &&
                                                      nameText.isNotEmpty &&
                                                      emailText.isNotEmpty &&
                                                      selectedBranchIndex != 0)
                                                  ? () {
                                                      addSupervisor();
                                                    }
                                                  : null,
                                              child: Text(
                                                'ADD',
                                                style:
                                                    defaultTextStyle.copyWith(
                                                  color: submitSnapshot.hasData
                                                      ? Colors.black87
                                                      : Colors.grey[500],
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

  ///finally add the supervisor
  void addSupervisor() async {
    setState(() => isLoading = true);
    Supervisor supervisor = new Supervisor(
      name: nameText,
      email: emailText,
      branch: branches[selectedBranchIndex],
      password: Helper().getRandomString(10),
      profileImageUrl: defaultProfileImageUrl,
      phone: null,
      designation: supervisorType,
      userType: supervisorType,
    );
    dynamic result =
        await _principalService.addSupervisor(supervisor, widget.snapshot);

    if (result == null) {
      setState(() {
        isLoading = false;
        errorColor = Colors.green;
        error = "Account Registered! \n Please reset your password for login.";
      });
    } else {
      setState(() {
        isLoading = false;
        errorColor = Colors.redAccent;
        error = result.toString();
      });
    }
  }

  void resetForm() {
    setState(() {
      selectedBranchIndex = 0;
      nameText = "";
      emailText = "";
    });
  }
}
