import 'package:flutter/material.dart';
import 'package:project_approval/models/user.dart';
import 'package:project_approval/screens/common/dashboard.dart';
import 'package:project_approval/screens/login_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    return currentUser == null ? LoginScreen() : DashboardScreen();
  }
}
