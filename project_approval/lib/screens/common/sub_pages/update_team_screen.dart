import 'package:flutter/material.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/utils/style.dart';
import 'package:provider/provider.dart';

class UpdateTeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teams = Provider.of<List<Team>>(context) ?? [];
    for(var team in teams) {
      print("team Name" + team.name);
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            iconTheme: new IconThemeData(
              color: Colors.black87,
            ),
            backgroundColor: Colors.cyanAccent,
            title: Text(
              'Update Team',
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
          body: UpdateTeamBody()),
    );
  }
}

class UpdateTeamBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text("Update Team Screen"),
    ));
  }
}
