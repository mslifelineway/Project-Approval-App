import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/common/team_member_card.dart';
import 'package:provider/provider.dart';

class ShowTeamMembers extends StatelessWidget {
  final List<Student> students;
  final DocumentSnapshot snapshot;
  final Team team;
  final Supervisor supervisor;

  ShowTeamMembers({this.students, this.snapshot, this.team, this.supervisor});

  @override
  Widget build(BuildContext context) {

    ///leaderStudents stream is list of leaders since one team has only one leader
    ///so this list may contain either 0 leader or only one leader data
    final List<Student> leaderStudents = Provider.of<List<Student>>(context) ?? [];
    Student teamLeaderStudentData;
    if(leaderStudents.length != 0)
        for(Student st in leaderStudents)
          teamLeaderStudentData = st;

    final List<TeamMemberCard> teamMemberCards = [];
    if (teamLeaderStudentData != null) {
      teamMemberCards.add(
        new TeamMemberCard(
          student: teamLeaderStudentData,
          students: students,
          snapshot: snapshot,
          team: team,
          supervisor: supervisor,
        ),
      );
    }
    if (students.length == 0) {
      teamMemberCards.add(new TeamMemberCard());
    } else {
      for (Student student in students) {
        if (teamLeaderStudentData != null) {
          if (teamLeaderStudentData.id != student.id) {
            teamMemberCards.add(new TeamMemberCard(
              student: student,
              students: students,
              snapshot: snapshot,
              team: team,
              supervisor: supervisor,
            ));
          }
        } else
          teamMemberCards.add(new TeamMemberCard(
            student: student,
            students: students,
            snapshot: snapshot,
            team: team,
            supervisor: supervisor,
          ));
      }
    }

//    return Container();
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: teamMemberCards,
    );
  }
}
