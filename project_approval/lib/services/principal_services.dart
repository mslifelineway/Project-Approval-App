import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_approval/models/hod.dart';
import 'package:project_approval/models/principal.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/user.dart';
import 'package:project_approval/services/auth_service.dart';
import 'package:project_approval/services/auth_services/hod_auth_service.dart';
import 'package:project_approval/services/auth_services/supervisor_auth_service.dart';
import 'package:project_approval/services/db_services/database_service.dart';
import 'package:project_approval/utils/helper.dart';

class PrincipalService {
  /**
   * SERVICE FOR HOD DONE ONLY BY THE PRINCIPAL
   */

  ///this method can be listen only by the principal
  ///adding Hod data as signIn to the database, just an email adding by the principal
  Future addHod(Hod hod, DocumentSnapshot snapshot) async {
    ///since principal is going to sign new account for the faculty so, auth will be
    ///changed and hod will be logged in automatically so,
    ///to prevent this we will store all the data of the principal currently logged in
    ///after registering hod, we will login principal by principal's credentials
    /// remember principal will not know that he was logged out,
    ///principal data is in the snapshot
    ///storing the principal data before registering hod

    try {
      ///first register with auth
      AuthResult _authResult = await new AuthService()
          .signUpWithEmailAndPassword(hod.email, hod.password);
      await new DatabaseService(uid: _authResult.user.uid).updateHodData(hod);
      await new AuthService().signInWithEmailAndPassword(snapshot.data["Email"], snapshot.data["Password"]);
      return null;
    } catch (e) {
      print("error occur: " + e.toString());
      return Helper().identifyErrorInException(e.toString());
    }
  }

  /**
   * SERVICE FOR SUPERVISOR DONE ONLY BY THE PRINCIPAL
   */

  ///this method can be listen only by the principal
  ///adding supervisor data as signIn to the database, just an email adding by the principal
  Future addSupervisor(Supervisor s, DocumentSnapshot snapshot) async {
    ///since principal is going to sign new account for the faculty so, auth will be
    ///changed and hod will be logged in automatically so,
    ///to prevent this we will store all the data of the principal currently logged in
    ///after registering hod, we will login principal by principal's credentials
    /// remember principal will not know that he was logged out,
    ///principal data is in the snapshot
    ///storing the principal data before registering supervisor
    try {
      ///first register with auth
      AuthResult _authResult = await new AuthService()
          .signUpWithEmailAndPassword(s.email, s.password);
      await new DatabaseService(uid: _authResult.user.uid).updateSupervisorData(s);
      await new AuthService().signInWithEmailAndPassword(snapshot.data["Email"], snapshot.data["Password"]);
      return null;
    } catch (e) {
      print("error occur: " + e.toString());
      return Helper().identifyErrorInException(e.toString());
    }
  }
}
