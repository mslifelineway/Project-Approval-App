import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_approval/dto/team_details.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/common/sub_pages/view_team_details.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/services/db_services/student_service.dart';
import 'package:project_approval/services/db_services/supervisor_services.dart';
import 'package:project_approval/services/db_services/team_database_service.dart';
import 'package:project_approval/utils/style.dart';
import 'package:provider/provider.dart';

class BodyDataTable extends StatelessWidget {
  final List<TeamDetails> teamList;
  final DocumentSnapshot snapshot;

  BodyDataTable({this.teamList, this.snapshot});

  @override
  Widget build(BuildContext context) {
    return teamList.length != 0
        ? DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  "Id",
                  style: dataTableHeaderTextStyle,
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Team Id",
              ),
              DataColumn(
                label: Text(
                  "Name",
                  style: dataTableHeaderTextStyle,
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Team Name",
              ),
              DataColumn(
                label: Text(
                  "Sup-Id",
                  style: dataTableHeaderTextStyle,
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Supervisor Id",
              ),
              DataColumn(
                label: Text(
                  "Sup-Name",
                  style: dataTableHeaderTextStyle,
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Supervisor Name",
              ),
              DataColumn(
                label: Text(
                  "Mobile",
                  style: dataTableHeaderTextStyle,
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Supervisor's Mobile Number",
              ),
              DataColumn(
                label: Text(
                  "Date",
                  style: dataTableHeaderTextStyle,
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Date Time Of Team",
              ),
            ],
            rows: teamList.map(
              (teamDetails) {
                return DataRow(cells: <DataCell>[
                  DataCell(
                    Row(
                      children: [
                        Text('${teamDetails.team.id}'),
                      ],
                    ),
                    onTap: () {
                      viewTeamDetails(teamDetails, context, snapshot);
                    },
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text('${teamDetails.team.name}'),
                      ],
                    ),
                    onTap: () {
                      viewTeamDetails(teamDetails, context, snapshot);
                    },
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text('${teamDetails.supervisor.id}'),
                      ],
                    ),
                    onTap: () {
                      viewTeamDetails(teamDetails, context, snapshot);
                    },
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text('${teamDetails.supervisor.name}'),
                      ],
                    ),
                    onTap: () {
                      viewTeamDetails(teamDetails, context, snapshot);
                    },
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text('${teamDetails.supervisor.phone}'),
                      ],
                    ),
                    onTap: () {
                      viewTeamDetails(teamDetails, context, snapshot);
                    },
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Row(
                      children: [
                        Text('${teamDetails.team.dateTime}'),
                      ],
                    ),
                    onTap: () {
                      viewTeamDetails(teamDetails, context, snapshot);
                    },
                    showEditIcon: false,
                    placeholder: false,
                  ),
                ]);
              },
            ).toList(),
          )
        : Center(
            child: Container(
              child: Text("No teams found!"),
            ),
          );
  }

  void viewTeamDetails(
      TeamDetails td, BuildContext context, DocumentSnapshot snapshot) {
    ///
    ///there are following streams gonna used here...
    ///first stream for team only (without supervisor details)
    ///second stream for supervisor details (find supervisor by id )
    ///third stream for getting all the students or members details
    ///find students by team id (team id will taken from first stream
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StreamProvider<Team>.value(
            value: new TeamDatabaseService().getTeamStreamById(td.team.id),
            builder: (context, teamSnapshot) {
              Team team = Provider.of<Team>(context);
              if (team == null) return LoadingScreen();
              return StreamProvider<Supervisor>.value(
                  value: new SupervisorService()
                      .getSupervisorDataById(team.supervisorId),
                  builder: (context, supervisorSnapshot) {
                    return StreamProvider<List<Student>>.value(
                        value: new StudentService()
                            .getStudentsStreamByTeamId(team.id),
                        builder: (context, studentSnapshot) {
                          return ViewTeamDetailsScreen(
                            snapshot: snapshot,
                          );
                        });
                  });
            }),
      ),
    );
  }
}
