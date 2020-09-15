import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/common/error_screen.dart';
import 'package:project_approval/screens/common/team_screen.dart';
import 'package:project_approval/screens/common/widgets/show_team_members.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/services/db_services/student_service.dart';
import 'package:project_approval/utils/colors.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';
import 'package:project_approval/utils/style.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class ViewTeamDetailsScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;

  ViewTeamDetailsScreen({this.snapshot});

  @override
  _ViewTeamDetailsScreenState createState() => _ViewTeamDetailsScreenState();
}

class _ViewTeamDetailsScreenState extends State<ViewTeamDetailsScreen> {
  bool isLoading = false;
  bool bottomSheetToggler = false;

  @override
  Widget build(BuildContext context) {
    Team team = Provider.of<Team>(context) ?? null;
    Supervisor supervisor = Provider.of<Supervisor>(context) ?? null;

    if (team == null || supervisor == null) {
//      return ErrorScreen(
//        error: teamAndSupervisorNotExists,
//      );
      return LoadingScreen();
    }
    List<Student> students = Provider.of<List<Student>>(context) ?? [];
    final String userType = widget.snapshot.data["USER_TYPE"];

    return WillPopScope(
      onWillPop: _requestPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            iconTheme: new IconThemeData(
              color: Colors.black87,
            ),
            backgroundColor: Colors.cyanAccent,
            title: Text(
              '${team.id} Details',
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
                print("snapshot in view team details : " +
                    widget.snapshot.toString());
                Navigator.of(context).pop();
//              Navigator.of(context).pushReplacement(MaterialPageRoute(
//                builder: (context) => TeamScreen(
//                  snapshot: widget.snapshot,
//                ),
//              ));
              },
            ),
          ),
          body: isLoading
              ? LoadingScreen()
              : ViewTeamDetailsScreenBody(
                  snapshot: widget.snapshot,
                  userType: userType,
                  team: team,
                  supervisor: supervisor,
                  students: students,
                ),
          floatingActionButton: userType == supervisorType &&
                  team.capacity > students.length
              ? FloatingActionButton(
                  onPressed: () {
                    new Helper().registerTeamMemberDialog(
                        context, team, supervisor, students, widget.snapshot);
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  elevation: 20,
                  backgroundColor: Colors.cyanAccent,
                )
              : null,
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    print("back pressed....");
    Navigator.of(context).pop();
    return new Future.value(true);
  }
}

class ViewTeamDetailsScreenBody extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String userType;
  final Team team;
  final Supervisor supervisor;
  final List<Student> students;

  ViewTeamDetailsScreenBody({
    this.snapshot,
    this.userType,
    this.team,
    this.supervisor,
    this.students,
  });

  @override
  _ViewTeamDetailsScreenBodyState createState() =>
      _ViewTeamDetailsScreenBodyState();
}

class _ViewTeamDetailsScreenBodyState extends State<ViewTeamDetailsScreenBody> {
  ///vars to get height of top clipping container to set position of "Members" text at the
  ///center of both the clipping containers
  final GlobalKey _topClippingContainerKey = GlobalKey();
  Size containerSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => getSizedAndPosition());
  }

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
                Column(
                  children: [
                    ClipPath(
                      clipper: CustomLoginScreenClipper(),
                      child: Container(
                        key: _topClippingContainerKey,
                        constraints: BoxConstraints(
                          minHeight: 220,
                        ),
                        padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.cyanAccent.withOpacity(.4),
                            padding: EdgeInsets.fromLTRB(15, 30, 15, 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 2),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black87, width: 2),
                                        ),
                                      ),
                                      child: Text(
                                        '${widget.team.name}',
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Bold",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Members - ',
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black,
                                                fontFamily: "Open Sans Bold",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.students.length}',
                                              textAlign: TextAlign.start,
                                              softWrap: true,
                                              style: appBarTitleStyle.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "Open Sans Bold",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Required - ',
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black,
                                                fontFamily: "Open Sans Bold",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '${widget.team.capacity - widget.students.length}',
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: "Open Sans Bold",
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Supervisor - ',
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Bold",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Text(
                                          '${widget.supervisor.name}',
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: appBarTitleStyle.copyWith(
                                              color: Colors.orange,
                                              fontSize: 16,
                                              fontFamily: "Open Sans Bold",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Created On - ',
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Bold",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${widget.team.dateTime}',
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Open Sans Bold",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Team Status - ',
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Bold",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        widget.team.capacity >
                                                widget.students.length
                                            ? teamStatusAvailable
                                            : teamStatusFull,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: appBarTitleStyle.copyWith(
                                            color: widget.team.capacity >
                                                    widget.students.length
                                                ? teamAvailableColor
                                                : teamFullColor,
                                            fontSize: 18,
                                            fontFamily: "Open Sans Bold",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: CustomLoginScreenBottomClipper(),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 300,
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: Colors.cyanAccent.withOpacity(.4),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: 250,
                                    maxHeight: 380,
                                  ),
                                  child: StreamProvider<List<Student>>.value(
                                      value: new StudentService()
                                          .getStudentDataByTeamIdAndTeamRole(
                                              widget.team.id, teamLeaderRole),
                                      builder: (context, studentSnapshot) {
                                        if (studentSnapshot == null) {
                                          LoadingScreen();
                                        }
                                        return ShowTeamMembers(
                                          students: widget.students,
                                          snapshot: widget.snapshot,
                                          team: widget.team,
                                          supervisor: widget.supervisor,
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: containerSize != null ? containerSize.height - 10 : 200,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.black87, width: 2),
                            ),
                          ),
                          child: Text(
                            'MEMBERS',
                            textAlign: TextAlign.center,
                            style: appBarTitleStyle.copyWith(
                                color: Colors.black87,
                                fontFamily: "Raleway Bold",
                                fontWeight: FontWeight.w500,
                                fontSize: 25),
                          ),
                        ),
                      ],
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

  ///method to get top clipping container size and position
  getSizedAndPosition() {
    RenderBox _containerBox =
        _topClippingContainerKey.currentContext.findRenderObject();
    print("size: ------------ " + _containerBox.size.toString());
    setState(() {
      containerSize = _containerBox.size;
    });
  }
}
