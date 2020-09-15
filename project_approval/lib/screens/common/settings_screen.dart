import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/screens/common/widgets.dart';

class SettingsScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  SettingsScreen({
    this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: drawerScreenAppBar("Settings", context),
      ),
    );
  }
}

