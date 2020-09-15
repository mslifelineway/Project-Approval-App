import 'dart:async';

mixin AuthValidator {
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


}
