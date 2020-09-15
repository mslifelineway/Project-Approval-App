import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_approval/models/principal.dart';
import 'package:project_approval/models/user.dart';
import 'package:project_approval/services/db_services/database_service.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseService databaseService = new DatabaseService();

  User userFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(id: firebaseUser.uid) : null;
  }

  Stream<User> get getUser {
    return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  //signIn with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  ///sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  ///getting user details by id
  Future getUserDetailsById(String userId) async {
    return User();
  }

  ///sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      new Helper().identifyErrorInException(e.toString());
    }
  }

  ///forget password or reset password link (sending a reset password link through mail)
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return Helper().identifyErrorInException(e.toString());
    }
  }
}
