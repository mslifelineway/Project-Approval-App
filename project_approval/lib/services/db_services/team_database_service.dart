import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';

class TeamDatabaseService {
  final String uid;

  TeamDatabaseService({this.uid});

  ///update the team data, if not exists the create new one
  Future updateTeamData(Team t) async {
    try {
      return await teamReference.document(uid).setData({
        "Id": t.id,
        "Name": t.name,
        "Capacity": t.capacity,
        "MemberRequired": t.memberRequired,
        "DateTime": t.dateTime,
        "SupervisorId": t.supervisorId,
      });
    } catch (e) {
      return Helper().identifyErrorInException(e);
    }
  }

  Team teamFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot == null
        ? new Team()
        : Helper().teamDataFromSnapshot(snapshot.documents[0]);
  }

  ///get team Stream by id
  Stream<Team> getTeamStreamById(String teamId) {
    return teamReference
        .where("Id", isEqualTo: teamId)
//        .orderBy('DateTime', descending: true)
        .snapshots()
        .map(teamFromQuerySnapshot);
  }

  ///get list of team by supervisor id
  List<Team> teamListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print("generating team data...");
      return Helper().teamDataFromSnapshot(doc);
    }).toList();
  }

  ///get teams by supervisor id
  Stream<List<Team>> get getTeams {
    return teamReference
        .where("SupervisorId", isEqualTo: uid)
        .snapshots()
        .map(teamListFromSnapshot);
  }

  ///get all teams and then collect only those teams whose supervisors's branch is same as current user branch
  Stream<List<Team>> getTeamsBySupervisorIds(List<String> ids) {
    if (ids.length == 0) return null;
    return teamReference
        .where("SupervisorId", whereIn: ids)
        .snapshots()
        .map(teamListFromSnapshot);
  }

//  Stream<List<Team>> getTeamsWithSupervisorDetails(List<String> supervisors) {
//    if (supervisors.length == 0)
//      return null;
//    return teamReference.where("SupervisorId", whereIn: ids).snapshots().map(
//        teamListFromSnapshot
//    );
//  }

  Stream<List<Team>> getTeamsBySupervisorIdAndOrderByDate(String supId) {
    return teamReference
        .where("SupervisorId", isEqualTo: supId)
        .orderBy('DateTime', descending: true)
        .snapshots()
        .map(teamListFromSnapshot);
  }

//  Stream<List<Team>> getTeamsByBranch(String branch) {
//    return teamReference
//        .where("Branch", isEqualTo: branch)
//        .snapshots()
//        .map(teamListFromSnapshot);
//  }

//  Stream<List<Team>> getTeamsBySupervisorIds(String branch) {
//    return teamReference
//        .where("Branch", isEqualTo: branch)
//        .snapshots()
//        .map(teamListFromSnapshot);
//  }
}
