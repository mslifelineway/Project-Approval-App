import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';
import 'package:project_approval/utils/style.dart';

///more options like delete update
class TeamMembersMoreOption extends StatelessWidget {
  final Student selectedStudent;
  final Team team;
  TeamMembersMoreOption({
    this.selectedStudent,
    this.team,
  });

  final List<PopupMenuItem> items = [
    PopupMenuItem(
      value: 1,
      child: Text(
        'Update',
        style: appBarTitleStyle.copyWith(
          fontSize: 16,
          fontFamily: "Open Sans Bold",
          color: Colors.black54,
        ),
      ),
    ),
    PopupMenuItem(
      value: 2,
      child: Text(
        'Remove',
        style: appBarTitleStyle.copyWith(
          fontSize: 16,
          fontFamily: "Open Sans Bold",
          color: Colors.black54,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => items,
      onSelected: (index) {
        if (index == 1) {
          new Helper().updateOrRemoveTeamMemberDialog(
            context,
            team,
            selectedStudent,
            1,//1 for update
          );
        } else if (index == 2) {
          new Helper().updateOrRemoveTeamMemberDialog(
            context,
            team,
            selectedStudent,
            2, //2 for remove (just set team Id as null)
          );
        }
      },
    );
  }
}
