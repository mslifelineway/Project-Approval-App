import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/screens/common/widgets.dart';

import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/auth_service.dart';
import 'package:project_approval/utils/style.dart';
import 'dart:math' as math;

class LogoutScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  LogoutScreen({
    this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: drawerScreenAppBar("Logout", context),
        body: LogoutScreenBody(),
      ),
    );
  }
}

class LogoutScreenBody extends StatelessWidget {
  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomLoginScreenBottomClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height-56,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        color: Colors.cyanAccent.withOpacity(.4),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20.0),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  "Are You Sure ? \n ",
                                  style: appBarTitleStyle.copyWith(
                                      fontSize: 30, color: Colors.teal),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _authService.signOut();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: gradientCancelFacultyButton),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 8),
                                  child: Text(
                                    "Logout",
                                    style: defaultTextStyle.copyWith(
                                      color: Colors.white,
                                      fontFamily: "RussoOne Regular",
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
