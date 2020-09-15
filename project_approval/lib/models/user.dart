
///user can be either student or hod, just we need this for id and email and password
///to store from firebase user to set to either student or hod model

class User {

  final String id;
  final String email;
  final String password;

  User({this.id, this.email, this.password});

  @override
  String toString() {
    return 'User{id: $id, email: $email, password: $password}';
  }
}