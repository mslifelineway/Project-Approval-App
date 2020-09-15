import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/services/auth_service.dart';
import 'package:project_approval/services/db_services/database_service.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';

class StudentService {
  final String studentId;

  StudentService({this.studentId});

  ///students from query snapshot
  List<Student> studentsFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((studentDoc) {
      return Helper().generateStudentData(studentDoc);
    }).toList();
  }

  ///single student from query snapshot
  List<Student> studentFromQuerySnapshot(QuerySnapshot snapshot) {
   return snapshot.documents.map((studentDoc) {
      return Helper().generateStudentData(studentDoc);
    }).toList();
  }

  ///get student stream data by id
  Stream<List<Student>> getStudentsStreamByTeamId(String teamId) {
    return userReference
        .where("TeamId", isEqualTo: teamId)
        .snapshots()
        .map(studentsFromQuerySnapshot);
  }

  ///register student and also add to a team
  Future registerStudent(Student s, DocumentSnapshot snapshot) async {
    Supervisor _supervisor = Helper().generateSupervisorData(snapshot);
    try {
      ///first register with auth
      AuthResult _authResult = await new AuthService()
          .signUpWithEmailAndPassword(s.email, s.password);
      await new DatabaseService(uid: _authResult.user.uid).registerStudentData(s);
      await new AuthService().signInWithEmailAndPassword(
          _supervisor.email, _supervisor.password);
      return null;
    } catch (e) {
      print("error occur: " + e.toString());
      return Helper().identifyErrorInException(e.toString());
    }
  }

  ///update student data - action done by supervisor only
  Future updateStudentBySupervisor(Student s) async {
    try {
      await new DatabaseService().updateStudentBasicData(s);
      return null;
    } catch (e) {
      print("error occur: " + e.toString());
      return Helper().identifyErrorInException(e.toString());
    }
  }


  ///get students by teamId and role -> since this collection may have only single data
  ///becoz each team has only one team leader
  Stream<List<Student>> getStudentsByTeamIdAndRole(String teamId,
      String teamRole) {
    return userReference
        .where("TeamId", isEqualTo: teamId)
        .where("Role", isEqualTo: teamRole)
        .snapshots().map(studentsFromQuerySnapshot);
  }

  ///get student data by team id and role ( either team leader data or team member data)
  Stream<List<Student>> getStudentDataByTeamIdAndTeamRole(String teamId, String role) {
    return userReference.where("USER_TYPE", isEqualTo: studentType).where(
        "TeamId", isEqualTo: teamId).where("Role", isEqualTo: role).snapshots().map(studentFromQuerySnapshot);
  }

  ///remove student from team
  Future removeStudentFromTeam() async{
    return userReference.document(studentId).updateData({
      "TeamId": null,
    });
  }
}
