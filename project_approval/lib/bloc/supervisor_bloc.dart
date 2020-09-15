import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SupervisorBloc extends Object with SupervisorValidators implements BaseBloc {
  final _nameController = BehaviorSubject<String>();
  final _branchController = BehaviorSubject<int>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get name => _nameController.stream.transform(nameValidator);

  ///branch stream has not been used for popup menu button for selection in add supervisor process
  Stream<int> get branch =>
      _branchController.stream.transform(branchValidator);

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get addSupervisorSubmitCheck =>
      CombineLatestStream.combine3(name, email, branch, (n, e, b) => true);

  ///for inputting (getting data from text fields to this class
  Function(String) get nameChanged => _nameController.sink.add;

  Function(int) get branchChanged => _branchController.sink.add;

  Function(String) get emailChanged => _emailController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  @override
  void dispose() {
    _nameController?.close();
    _branchController?.close();
    _emailController?.close();
    _passwordController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}

mixin SupervisorValidators {
  var emailValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.trim().contains("@") && !email.trim().contains(" ")) {
      sink.add(email.trim());
    } else if (email.trim().contains(" ")) {
      sink.addError("Spaces are not allowed in the email.");
    } else {
      sink.addError("Please provide valid email.");
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.trim().length > 5) {
          sink.add(password.trim());
        } else {
          sink.addError("password must contain minimum 6 chars.");
        }
      });

  var nameValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.trim().isNotEmpty) {
      sink.add(name.trim());
    } else {
      sink.addError("Please provide a good name.");
    }
  });

  var branchValidator =
  StreamTransformer<int, int>.fromHandlers(handleData: (branchIndex, sink) {
    sink.add(branchIndex);
  });
}