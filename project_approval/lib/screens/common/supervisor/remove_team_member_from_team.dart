import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/bloc/student_bloc.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/db_services/student_service.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';
import 'package:project_approval/utils/style.dart';

class RemoveTeamMemberFromATeam extends StatefulWidget {
  final Team team;
  final Student selectedStudent;

  RemoveTeamMemberFromATeam({
    this.team,
    this.selectedStudent,
  });

  @override
  _RemoveTeamMemberFromATeamState createState() =>
      _RemoveTeamMemberFromATeamState();
}

class _RemoveTeamMemberFromATeamState extends State<RemoveTeamMemberFromATeam> {
  String error = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomLoginScreenBottomClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
              child: Card(
                elevation: 2,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 300,
                  ),
                  color: Colors.cyanAccent.withOpacity(.4),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black87, width: 2),
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${widget.selectedStudent.name}',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: appBarTitleStyle.copyWith(
                            color: Colors.blue,
                            fontSize: 22,
                            fontFamily: "RussoOne Regular",),
                      ),
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
                              Text(
                                removeMemberFromTeamWarningMessage,
                                style: appBarTitleStyle.copyWith(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                    fontFamily: "Open Sans Bold"),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Are You Sure?',
                                style: appBarTitleStyle.copyWith(
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontFamily: "Open Sans Bold"),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'CANCEL',
                                      style: appBarTitleStyle.copyWith(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  RaisedButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      removeFromTeam(context);
                                    },
                                    child: Text(
                                      'CONFIRM',
                                      style: appBarTitleStyle.copyWith(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '$error',
                                style: appBarTitleStyle.copyWith(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontFamily: "Open Sans Bold"),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void removeFromTeam(BuildContext context) async{
  print("student id: " + widget.selectedStudent.id);
    dynamic result = await new StudentService(studentId: widget.selectedStudent.id).removeStudentFromTeam();
    if(result == null) {
      Navigator.of(context).pop();
    }
    else {
      setState(() {
        error = result.toString();
      });
    }

  }
}
