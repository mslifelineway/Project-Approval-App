import 'package:flutter/material.dart';
import 'package:project_approval/utils/style.dart';

class UpdateStudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            iconTheme: new IconThemeData(
              color: Colors.black87,
            ),
            backgroundColor: Colors.cyanAccent,
            title: Text(
              'Update Student',
              style: appBarTitleStyle.copyWith(fontFamily: "RedRose Bold"),
            ),
            centerTitle: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: UpdateStudentBody()),
    );
  }
}

class UpdateStudentBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text("Update Student Screen"),
    ));
  }
}
