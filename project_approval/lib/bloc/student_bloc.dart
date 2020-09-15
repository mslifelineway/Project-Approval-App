import 'dart:async';
import 'package:project_approval/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class StudentBloc extends Object with StudentValidators implements BaseBloc {

  ///setting up initial data to stream controller to update by new data
  final String initialNameText;
  final String initialHallTicketNumber;
  StudentBloc({this.initialNameText, this.initialHallTicketNumber}){
   _nameController.add(initialNameText ?? '');
   _hallTicketNumberController.add(initialHallTicketNumber ?? '');
  }

  Function(String) get push => _nameController.sink.add;
  ///updation data end  here...


  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _hallTicketNumberController = BehaviorSubject<String>();

  Stream<String> get name => _nameController.stream.transform(nameValidator);
  Stream<String> get email => _emailController.stream.transform(emailValidator);

  Stream<String> get hallTicketNumber =>
      _hallTicketNumberController.stream.transform(hallTicketNumberValidator);

   Stream<bool> get submitCheck =>
      CombineLatestStream.combine3(name, email, hallTicketNumber, (n, e, h) => true);

  Stream<bool> get updateCheck =>
      CombineLatestStream.combine2(name, hallTicketNumber, (n, h) => true);

  //for inputting
  Function(String) get nameChanged => _nameController.sink.add;
  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get hallTicketChanged => _hallTicketNumberController.sink.add;

  @override
  void dispose() {
    _nameController?.close();
    _emailController?.close();
    _hallTicketNumberController?.close();
  }

}

abstract class BaseBloc {
  void dispose();

}

mixin StudentValidators {

  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      print("name in validator: " + name);
      if(name.trim().isEmpty) {
        sink.addError("Please provide the student's name.");
      } else if(name.trim().length < 2){
        sink.addError("Student name must contain minimum 3 chars.");
      } else if(name.trim().length > 30){
        sink.addError("Name length should be less than  30 chars.");
      } else {
        sink.add(name);
      }
    });
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

  var hallTicketNumberValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (htNo, sink) {
        if(htNo.trim().isEmpty) {
          sink.addError("Please provide the Hall ticket number.");
        } if(htNo.trim().contains(" ")) {
          sink.addError("Spaces are not allowed.");
        } else if(htNo.trim().length < 2){
          sink.addError("Hall ticket number must contain minimum 3 chars.");
        } else {
          sink.add(htNo);
        }
      });
}