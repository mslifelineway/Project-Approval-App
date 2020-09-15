import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/common/widgets/student_profile_image_rounded.dart';
import 'package:project_approval/screens/common/widgets/team_members_more_options.dart';
import 'package:project_approval/utils/colors.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/style.dart';
class TeamMemberCard extends StatelessWidget {
  final Student student;
  final List<Student> students;
  final DocumentSnapshot snapshot;
  final Team team;
  final Supervisor supervisor;

  TeamMemberCard(
      {this.student, this.students, this.snapshot, this.team, this.supervisor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        child: student == null
            ? Container(
          child: Text(teamIsEmptyMessage),
        )
            : Stack(
          children: [
            Positioned(
              right: -10,
              top: 5,
              child: TeamMembersMoreOption(
                selectedStudent: student,
                team: team,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: student.role == teamLeaderRole
                              ? SvgPicture.asset(
                            "assets/logo/dotted_background.svg",
                            width: 140,
                          )
                              : Container(),
                        ),
                        Container(
                          padding: student.role == teamLeaderRole
                              ? EdgeInsets.fromLTRB(20, 25, 15, 15)
                              : EdgeInsets.all(10),
                          width: 140,
                          height: 140,
                          child: Center(
                            child: StudentProfileImageRounded(
                              profileImageUrl: student.profileImageUrl,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          //TODO: navigate to user profile when clicked on name
                        },
                        child: Text(
                          "${student.name}",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: appBarTitleStyle.copyWith(
                              color: Colors.blue,
                              fontSize: 20,
                              fontFamily: "RussoOne Regular",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "(${student.role})",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: appBarTitleStyle.copyWith(
                            color: Colors.deepOrangeAccent,
                            fontSize: 15,
                            fontFamily: "Raleway Bold",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Branch',
                        textAlign: TextAlign.end,
                        softWrap: true,
                        style: appBarTitleStyle.copyWith(
                            color: Colors.black,
                            fontFamily: "Open Sans Bold",
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${student.branch}',
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: appBarTitleStyle.copyWith(
                            color: teamAvailableColor,
                            fontSize: 18,
                            fontFamily: "Open Sans Bold",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Hall Ticket Number',
                        textAlign: TextAlign.end,
                        softWrap: true,
                        style: appBarTitleStyle.copyWith(
                            color: Colors.black,
                            fontFamily: "Open Sans Bold",
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "${student.hallTicketNumber}",
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: appBarTitleStyle.copyWith(
                            color: teamAvailableColor,
                            fontSize: 18,
                            fontFamily: "Open Sans Bold",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
