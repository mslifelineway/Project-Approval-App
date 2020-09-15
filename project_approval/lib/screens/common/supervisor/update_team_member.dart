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

class UpdateTeamMember extends StatefulWidget {
  final Team team;
  final Student selectedStudent;

  UpdateTeamMember({
    this.team,
    this.selectedStudent,
  });

  @override
  _UpdateTeamMemberState createState() => _UpdateTeamMemberState();
}

class _UpdateTeamMemberState extends State<UpdateTeamMember> {
  int groupValueForGender = 1;

  //male is selected by default here since value of male gender radio is 1

  int groupValueForTeamRole = 2;

  // team member is selected by default since value of team leader radio is 2

  String error = "";
  Color errorColor = Colors.green;
  String name = "";
  String hallTicketNumber = "";
  StudentBloc studentBloc;

  bool isLoading = false;

  ///text editing controller is used to show value of stream controller to textField
  TextEditingController _nameTextEditingController =
      new TextEditingController();
  TextEditingController _hallTicketNumberTextEditingController =
      new TextEditingController();

  void setNameToTextEditingController(String nameText) {
    ///don't use setState((){}) method
    _nameTextEditingController =
        TextEditingController(text: nameText.toString());
    if (nameText != null) {
      _nameTextEditingController.selection = TextSelection.collapsed(
          offset: _nameTextEditingController.text.length);
    } else {
      _nameTextEditingController.selection = TextSelection.collapsed(offset: 0);
    }
  }

  void setHallTicketNumberToTextEditingController(String hallTicketNumberText) {
    ///don't use setState((){}) method
    _hallTicketNumberTextEditingController =
        TextEditingController(text: hallTicketNumberText.toString());
    if (hallTicketNumberText != null) {
      _hallTicketNumberTextEditingController.selection = TextSelection.collapsed(
          offset: _hallTicketNumberTextEditingController.text.length);
    } else {
      _hallTicketNumberTextEditingController.selection = TextSelection.collapsed(offset: 0);
    }
  }

  @override
  void initState() {
    ///setting selected student's name to the stream controller to update
    studentBloc = new StudentBloc(
      initialNameText: widget.selectedStudent.name ?? '',
      initialHallTicketNumber: widget.selectedStudent.hallTicketNumber ?? '',
    );

    ///setting selected student's name to the name
    name = widget.selectedStudent.name;

    ///setting selected student's name to the name
    hallTicketNumber = widget.selectedStudent.hallTicketNumber;

    ///listening data from bloc
    studentBloc.name.listen((event) {
      name = event;
    });
    studentBloc.hallTicketNumber.listen((event) {
      hallTicketNumber = event;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isTeamHasALeader = false;
    bool isCurrentStudentATeamLeader = false;
    return StreamBuilder<List<Student>>(
        stream: StudentService()
            .getStudentsByTeamIdAndRole(widget.team.id, teamLeaderRole),
        builder: (context, leaderSnapshot) {
          if (!leaderSnapshot.hasData) return LoadingScreen();
          if (leaderSnapshot.data.length != 0) {
            isTeamHasALeader = true;
            if (leaderSnapshot.data[0].id == widget.selectedStudent.id) {
              isCurrentStudentATeamLeader = true;
            }
          }
          return StreamBuilder<List<Student>>(
              stream: new StudentService()
                  .getStudentsStreamByTeamId(widget.team.id),
              builder: (context, studentsSnapshot) {
                if (!studentsSnapshot.hasData) return LoadingScreen();
                print(studentsSnapshot.data.length);
                return Container(
                    padding: EdgeInsets.only(top: 5),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: SingleChildScrollView(
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
                                    minHeight:
                                        MediaQuery.of(context).size.height -
                                            300,
                                  ),
                                  color: Colors.cyanAccent.withOpacity(.4),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 70,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 2),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black87,
                                                width: 2),
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
                                        isTeamHasALeader
                                            ? (isCurrentStudentATeamLeader ? youAreATeamLeader : teamHasAlreadyAnLeader)
                                            : teamHasNotAnLeader,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.deepOrangeAccent,
                                            fontSize: 12,
                                            fontFamily: "Open Sans Bold",
                                            fontWeight: FontWeight.w500),
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
                                              Container(
                                                child: StreamBuilder<String>(
                                                    stream: studentBloc.name
                                                        .map((event) => name),
                                                    builder:
                                                        (context, snapshot) {
                                                      setNameToTextEditingController(
                                                          snapshot.data ?? '');
                                                      return TextField(
                                                        onChanged: studentBloc
                                                            .nameChanged,
                                                        controller:
                                                            _nameTextEditingController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        maxLines: 1,
                                                        style: appBarTitleStyle
                                                            .copyWith(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black87,
                                                                fontFamily:
                                                                    "Open Sans Bold"),
                                                        decoration:
                                                            InputDecoration(
                                                          errorText:
                                                              snapshot.error,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          -5),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.0),
                                                          ),
                                                          hintText:
                                                              "Enter Student's Name",
                                                          hintStyle: TextStyle(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontFamily:
                                                                  "Raleway Bold"),
                                                          labelText:
                                                              "Enter Student's Name",
                                                          labelStyle: TextStyle(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontFamily:
                                                                  "Raleway Bold"),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              StreamBuilder<String>(
                                                  stream: studentBloc
                                                      .hallTicketNumber
                                                      .map((event) =>
                                                          hallTicketNumber),
                                                  builder: (context, snapshot) {
                                                    setHallTicketNumberToTextEditingController(
                                                        snapshot.data ?? '');
                                                    return Container(
                                                      child: TextField(
                                                        onChanged: studentBloc
                                                            .hallTicketChanged,
                                                        controller:
                                                            _hallTicketNumberTextEditingController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        maxLines: 1,
                                                        style: appBarTitleStyle
                                                            .copyWith(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black87,
                                                                fontFamily:
                                                                    "Open Sans Bold"),
                                                        decoration:
                                                            InputDecoration(
                                                          errorText:
                                                              snapshot.error,
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          -5),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.0),
                                                          ),
                                                          hintText:
                                                              "Enter Hall Ticket Number",
                                                          hintStyle: TextStyle(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontFamily:
                                                                  "Raleway Bold"),
                                                          labelText:
                                                              "Enter Hall Ticket Number",
                                                          labelStyle: TextStyle(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontFamily:
                                                                  "Raleway Bold"),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Gender",
                                                    textAlign: TextAlign.start,
                                                    style: defaultTextStyle,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration:
                                                    greyOutlineBorderAll,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Radio(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              groupValueForGender =
                                                                  value;
                                                            });
                                                          },
                                                          groupValue:
                                                              groupValueForGender,
                                                          value: male,
                                                          activeColor:
                                                              Colors.teal,
                                                        ),
                                                        Text(
                                                          "Male",
                                                          style:
                                                              defaultTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Radio(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              groupValueForGender =
                                                                  value;
                                                            });
                                                          },
                                                          groupValue:
                                                              groupValueForGender,
                                                          value: female,
                                                          activeColor:
                                                              Colors.teal,
                                                        ),
                                                        Text(
                                                          "Female",
                                                          style:
                                                              defaultTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Team Role",
                                                    textAlign: TextAlign.start,
                                                    style: defaultTextStyle,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration:
                                                    greyOutlineBorderAll,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Radio(
                                                          onChanged:
                                                              (isCurrentStudentATeamLeader ||
                                                                      !isTeamHasALeader)
                                                                  ? (value) {
                                                                      setState(
                                                                          () {
                                                                        groupValueForTeamRole =
                                                                            value;
                                                                      });
                                                                    }
                                                                  : null,
                                                          groupValue:
                                                              groupValueForTeamRole,
                                                          value: teamLeader,
                                                          activeColor:
                                                              Colors.teal,
                                                        ),
                                                        Text(
                                                          "Leader",
                                                          style:
                                                              defaultTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Radio(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              groupValueForTeamRole =
                                                                  value;
                                                            });
                                                          },
                                                          groupValue:
                                                              groupValueForTeamRole,
                                                          value: teamMember,
                                                          activeColor:
                                                              Colors.teal,
                                                        ),
                                                        Text(
                                                          "Member",
                                                          style:
                                                              defaultTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              error != null
                                                  ? SizedBox(
                                                      height: 20,
                                                    )
                                                  : Container(),
                                              error != null
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            error,
                                                            style:
                                                                appBarTitleStyle
                                                                    .copyWith(
                                                              color: errorColor,
                                                              fontSize: 16,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              isLoading
                                                  ? TransparentLoadingScreen()
                                                  : StreamBuilder<bool>(
                                                      stream: studentBloc
                                                          .updateCheck,
                                                      builder:
                                                          (context, snapshot) {
                                                        return Container(
                                                          height: 40,
                                                          decoration: (snapshot
                                                                      .hasData &&
                                                                  name
                                                                      .isNotEmpty &&
                                                                  hallTicketNumber
                                                                      .isNotEmpty)
                                                              ? BoxDecoration(
                                                                  gradient:
                                                                      gradientAddFacultyButton,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.0),
                                                                )
                                                              : BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3.0)),
                                                          child: FlatButton(
                                                            onPressed: (snapshot
                                                                        .hasData &&
                                                                    name
                                                                        .isNotEmpty &&
                                                                    hallTicketNumber
                                                                        .isNotEmpty)
                                                                ? () {
                                                                    updateStudent();
                                                                  }
                                                                : null,
                                                            child: Text(
                                                              'Update',
                                                              style:
                                                                  defaultTextStyle
                                                                      .copyWith(
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                              SizedBox(
                                                height: 15,
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
                          Positioned(
                            top: 5,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        });
  }

  void updateStudent() async {
    if (name.isNotEmpty && hallTicketNumber.isNotEmpty) {
      setState(() => isLoading = true);
      Student s = new Student(
        id: widget.selectedStudent.id,
        name: name,
        hallTicketNumber: hallTicketNumber,
        role: groupValueForTeamRole == 1 ? teamLeaderRole : teamMemberRole,
        gender: groupValueForGender == 1 ? maleGender : femaleGender,
      );

      dynamic result = await new StudentService().updateStudentBySupervisor(s);
      setState(() => isLoading = false);

      if (result == null) {
        error = "Updated Successfully!";
        errorColor = Colors.green;
      } else {
        setState(() {
          error = result.toString();
          errorColor = Colors.red;
        });
      }
    }
  }
}
