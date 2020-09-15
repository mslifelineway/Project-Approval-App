import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_math/extended_math.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/models/hod.dart';
import 'package:project_approval/models/principal.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/common/supervisor/add_student_to_a_team.dart';
import 'package:project_approval/screens/common/supervisor/remove_team_member_from_team.dart';
import 'package:project_approval/screens/common/supervisor/update_team_member.dart';
import 'package:project_approval/utils/constants.dart';

class Helper {
  Principal generatePrincipalData(DocumentSnapshot s) {
    return Principal(
      id: s.data["Id"] ?? null,
      name: s.data["Name"] ?? '',
      email: s.data["Email"] ?? '',
      password: s.data["Password"] ?? '',
      phone: s.data["Phone"] ?? '',
      profileImage: s.data["ProfileImageUrl"] ?? defaultProfileImageUrl,
      designation: s.data["Designation"] ?? '',
      userType: s.data["USER_TYPE"] ?? '',
    );
  }

  Supervisor generateSupervisorData(DocumentSnapshot s) {
    return Supervisor(
      id: s.data["Id"] ?? null,
      name: s.data["Name"] ?? '',
      email: s.data["Email"] ?? '',
      password: s.data["Password"] ?? '',
      phone: s.data["Phone"] ?? '',
      profileImageUrl: s.data["ProfileImageUrl"] ?? defaultProfileImageUrl,
      designation: s.data["Designation"] ?? '',
      userType: s.data["USER_TYPE"] ?? '',
      branch: s.data["Branch"] ?? '',
    );
  }

  Hod generateHodData(DocumentSnapshot h) {
    return Hod(
      id: h.data["Id"] ?? null,
      name: h.data["Name"] ?? '',
      email: h.data["Email"] ?? '',
      password: h.data["Password"] ?? '',
      phone: h.data["Phone"] ?? '',
      profileImageUrl: h.data["ProfileImageUrl"] ?? defaultProfileImageUrl,
      designation: h.data["Designation"] ?? '',
      userType: h.data["USER_TYPE"] ?? '',
      branch: h.data["Branch"] ?? '',
    );
  }

  Student generateStudentData(DocumentSnapshot s) {
    return Student(
      id: s.data["Id"] ?? null,
      name: s.data["Name"] ?? '',
      email: s.data["Email"] ?? '',
      password: s.data["Password"] ?? '',
      phone: s.data["Phone"] ?? '',
      profileImageUrl: s.data["ProfileImageUrl"] ?? defaultProfileImageUrl,
      userType: s.data["USER_TYPE"] ?? '',
      branch: s.data["Branch"] ?? '',
      gender: s.data["Student"] ?? '',
      role: s.data["Role"] ?? '',
      teamId: s.data["TeamId"] ?? null,
      hallTicketNumber: s.data["HallTicketNumber"] ?? '',
    );
  }

  ///generate team data by dynamic doc
  Team generateTeamData(var t) {
    return Team(
      id: t.data["Id"] ?? null,
      name: t.data["Name"] ?? '',
      capacity: t.data["Capacity"] ?? '',
      dateTime: t.data["DateTime"].toDate() ?? '',
      supervisorId: t.data["SupervisorId"] ?? '',
      memberRequired: t.data["MemberRequired"] ?? '',
    );
  }

  ///generate team data from DocumentSnapshot
  Team teamDataFromSnapshot(DocumentSnapshot t) {
    return Team(
      id: t.data["Id"] ?? null,
      name: t.data["Name"] ?? '',
      capacity: t.data["Capacity"] ?? '',
      dateTime: t.data["DateTime"].toDate()  ?? null,
      supervisorId: t.data["SupervisorId"] ?? null,
      memberRequired: t.data["MemberRequired"] ?? '',
    );
  }

  ///random string generator
  String getRandomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  ///identifying errors in a given exception as string
  String identifyErrorInException(String e) {
    print("error in identify exception : " + e);
    String errorCode = e.substring(18, e.toString().indexOf(","));
    if (errorCode.compareTo(weakPassword) == 0) {
      return weakPasswordMessage;
    } else if (errorCode.compareTo(emailAlreadyInUse) == 0) {
      return emailAlreadyInUseMessage;
    } else if (errorCode.compareTo(badFormattedEmail) == 0) {
      return badFormattedEmailMessage;
    } else if (errorCode.compareTo(userNotFound) == 0) {
      return userNotFoundMessage;
    } else if (errorCode.compareTo(wrongPassword) == 0) {
      return wrongPasswordMessage;
    }
    return e;
  }

  static handleException(e) {
    print(e.code);
    String status;
    switch (e.code) {
//  case "ERROR_INVALID_EMAIL":
//  status = ;
//  break;
      case "ERROR_WRONG_PASSWORD":
        status = wrongPasswordMessage;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = userNotFoundMessage;
        break;
//  case "ERROR_USER_DISABLED":
//  status = ;
//  break;
//  case "ERROR_TOO_MANY_REQUESTS":
//  status = AuthResultStatus.tooManyRequests;
//  break;
//  case "ERROR_OPERATION_NOT_ALLOWED":
//  status = AuthResultStatus.operationNotAllowed;
//  break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = emailAlreadyInUseMessage;
        break;
      default:
        status = "Something went wrong";
    }
    return status;
  }

  ///show dialog box to add or update student in a team
  void registerTeamMemberDialog(BuildContext context,
      Team team,
      Supervisor supervisor,
      List<Student> students,
      DocumentSnapshot snapshot) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: AlertDialog(
                elevation: .5,
                insetPadding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                contentPadding: EdgeInsets.all(0),
                backgroundColor: Colors.cyanAccent,
                content: AddStudentToATeamSection(
                  team: team,
                  supervisor: supervisor,
                  students: students,
                  snapshot: snapshot,
                ),
              ),
            ),
          ),
    );
  }

///show dialog box to add or update or remove student in a team
void updateOrRemoveTeamMemberDialog(BuildContext context,
    Team team,
      Student selectedStudent,
    int action,
    ) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: AlertDialog(
              elevation: .5,
              insetPadding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              contentPadding: EdgeInsets.all(0),
              backgroundColor: Colors.cyanAccent,
              content: action ==1 ? UpdateTeamMember(
                team: team,
                selectedStudent: selectedStudent,
              ) : (action == 2 ?
              RemoveTeamMemberFromATeam(
                team: team,
                selectedStudent: selectedStudent,
              )
                  : Container()),
            ),
          ),
        ),
  );
}


///end of helper class
}