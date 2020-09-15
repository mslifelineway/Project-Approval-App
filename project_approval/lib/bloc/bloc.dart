import 'dart:async';
import 'package:project_approval/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends Object with AuthValidator implements BaseBloc {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get submitCheck =>
      CombineLatestStream.combine2(email, password, (e, p) => true);

  Stream<bool> get submitCheckOnlyForEmail => email.map((email) => true);
  //for inputting
  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}

abstract class BaseBloc {
  void dispose();

}