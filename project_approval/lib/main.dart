import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/screens/wrapper.dart';
import 'package:project_approval/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthService().getUser,
        builder: (context, snapshot) {
          return Wrapper();
        });
  }
}
