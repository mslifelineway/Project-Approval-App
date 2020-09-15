import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_approval/services/auth_service.dart';
import 'package:project_approval/services/db_services/database_service.dart';
import 'package:project_approval/utils/helper.dart';

class UserService {
  Future signInUser(String email, String password) async {
    AuthService _authService = new AuthService();
    try {
      AuthResult _authResult =
          await _authService.signInWithEmailAndPassword(email, password);

      ///users can reset their password by reset password link (sent through mail)
      ///so whenever user logged in update his database password field by auth password
      final FirebaseUser user = _authResult.user;
      return await new DatabaseService(uid: user.uid)
          .updateUserPasswordWhenLoggedIn(password);
    } catch (e) {
      return Helper().identifyErrorInException(e.toString());
    }
  }

  Future signUpUser(String email, String password) async {
    try {
      return await new AuthService().signUpWithEmailAndPassword(email, password);
    } catch(e) {
      return Helper().identifyErrorInException(e.toString());
    }
  }
}
