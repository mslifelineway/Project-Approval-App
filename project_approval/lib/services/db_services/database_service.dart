import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_approval/models/hod.dart';
import 'package:project_approval/models/principal.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference _userReference =
      Firestore.instance.collection("USERS");

  ///updating user password in database when user is logged in
  Future updateUserPasswordWhenLoggedIn(String password) async {
    return _userReference.document(uid).updateData({
      "Password": password,
    });
//    String uid = _authCredentials.providerId;

  }

  //update principal data if principal does not exists create new one
  Future updatePrincipalData(Principal p) async {
    try {
      return await _userReference.document(uid).setData({
        "Id": p.id,
        "USER_TYPE": principalType,
        //userType will be the same for different users like principal, supervisor, hod and students
        "Name": p.name,
        "Email": p.email,
        "Password": p.password,
        "Phone": p.phone,
        "Designation": p.designation,
        "ProfileImageUrl": p.profileImage,
      });
    } catch (e) {
      return Helper().identifyErrorInException(e);
    }
  }

  //update hod data if hod does not exists create new one
  Future updateHodData(Hod hod) async {
    try {
      await _userReference.document(uid).setData({
        "Id": uid,
        "USER_TYPE": hodType,
        "Name": hod.name,
        "Password": hod.password,
        "Email": hod.email,
        "Branch": hod.branch,
        "Phone": hod.phone,
        "Designation": hod.designation,
        "ProfileImageUrl": hod.profileImageUrl,
      });

      ///after updating successfully, simply we will return null or nothing
    } catch (e) {
      return Helper().identifyErrorInException(e.toString());
    }
  }

  //update student data if student does not exists create new one
  Future updateSupervisorData(Supervisor s) async {
    return await _userReference.document(uid).setData({
      "Id": uid,
      "USER_TYPE": s.userType,
      "Name": s.name,
      "Email": s.email,
      "Password": s.password,
      "Branch": s.branch,
      "Phone": s.phone,
      "Designation": s.designation,
      "ProfileImageUrl": s.profileImageUrl,
    });
  }

  //register student data
  Future registerStudentData(Student s) async {
    return await _userReference.document(uid).setData({
      "Id": uid,
      "USER_TYPE": s.userType,
      "Name": s.name,
      "Email": s.email,
      "Password": s.password,
      "Branch": s.branch,
      "Phone": s.phone,
      "HallTicketNumber": s.hallTicketNumber,
      "Gender": s.gender,
      "Role": s.role,
      "TeamId": s.teamId,
      "SupervisorId": s.supervisorId,
      "ProfileImageUrl": s.profileImageUrl,
    });
  }

  Future updateStudentBasicData(Student s) async {
    return await _userReference.document(s.id).updateData({
      "Name": s.name,
      "HallTicketNumber": s.hallTicketNumber,
      "Gender": s.gender,
      "Role": s.role,
    });
  }

  ///get user data by user id as stream
  Stream<DocumentSnapshot> get userData {
    return _userReference.document(uid).snapshots();
  }

  ///get user data by user id  (NOT USED YET)
  Future getUserData(String uid) async {
    return await _userReference.where("Id", isEqualTo: uid).getDocuments();
  }


}
