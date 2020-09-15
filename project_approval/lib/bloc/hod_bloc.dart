import 'dart:async';

import 'package:rxdart/rxdart.dart';

class HodBloc extends Object with HodValidators implements BaseBloc {
  final _nameController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _branchController = BehaviorSubject<int>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _designationController = BehaviorSubject<String>();

  Stream<String> get name => _nameController.stream.transform(nameValidator);

  Stream<String> get phone => _phoneController.stream.transform(phoneValidator);

  ///branch stream has not used for popup menu button for selection in add hod process
  Stream<int> get branch => _branchController.stream.transform(branchValidator);

  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<String> get designation =>
      _designationController.stream.transform(designationValidator);

  ///submits stream
  Stream<bool> get addHodSubmitCheck =>
      CombineLatestStream.combine3(name, email, branch, (n, e, b) => true);

  Stream<bool> get updateHodSubmitCheck =>
      CombineLatestStream.combine4(name, phone, designation, branch, (n, p, d, b) => true);

  ///for inputting (getting data from text fields to this class
  Function(String) get nameChanged => _nameController.sink.add;

  Function(String) get phoneChanged => _phoneController.sink.add;

  Function(int) get branchChanged => _branchController.sink.add;

  Function(String) get emailChanged => _emailController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  Function(String) get designationChanged => _designationController.sink.add;

  @override
  void dispose() {
    _nameController?.close();
    _branchController?.close();
    _emailController?.close();
    _passwordController?.close();
    _designationController?.close();
    _phoneController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}

mixin HodValidators {
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
    if (name.trim().isEmpty) {
      sink.addError("Please provide a good name.");
    } else if (name.trim().length < 2 ) {
      sink.addError("password must contain minimum 2 chars.");
    } else {
      sink.add(name.trim());
    }
  });

  var branchValidator =
      StreamTransformer<int, int>.fromHandlers(handleData: (branchIndex, sink) {
    sink.add(branchIndex);
  });

  var designationValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (designation, sink) {
    if (designation.trim().isEmpty) {
      sink.addError("Please provide a designation for hod.");
    } else if (designation.trim().length < 3) {
      sink.addError("Designation must contain minimum 3 chars.");
    } else {
      sink.add(designation.trim());
    }
  });

  var phoneValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    ///logic to identify only integer data not even double data.
    if (phone.trim().isEmpty)
      sink.addError("Please enter phone number. ex: 7015720216");
    else if (phone.trim().length != 10)
      sink.addError("Phone number must have 10 digits");
    else
      sink.add(phone);
  });
}
