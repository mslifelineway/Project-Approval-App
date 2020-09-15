import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';

class SupervisorService {
  final String sid;

  SupervisorService({this.sid});

  ///return supervisor from supervisorFromDynamicMap -> Map<String, dynamic>
  Supervisor supervisorFromDynamicMap(data) {
    return data != null
        ? Supervisor(
            id: data["Id"],
            name: data["Name"],
            branch: data["Branch"],
            designation: data["Designation"],
            phone: data["Phone"],
          )
        : null;
  }

  List<Supervisor> supervisorListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((s) => Helper().generateSupervisorData(s)).toList();
  }

  ///creating stream to get all the supervisors by branch
  Stream<List<Supervisor>> getSupervisorsByBranch(String branch) {
    return userReference
        .where("Branch", isEqualTo: branch)
        .where("USER_TYPE", isEqualTo: supervisorType)
        .snapshots()
        .map(supervisorListFromSnapshot);
  }

//  ///get All supervisors by branch
//  Future getSupervisorByBranch(String branch) async {
//    return await _userReference
//        .where("Branch", isEqualTo: branch)
//        .getDocuments();
//  }

  ///find supervisor by id
  Future getSupervisorById(String id) async {
    QuerySnapshot querySnapshot =
        await userReference.where("Id", isEqualTo: id).getDocuments();
    if (querySnapshot != null) {
      return querySnapshot.documents;
    }
    return null;
  }

  Supervisor supervisorFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot == null ? null : Supervisor(
      id: snapshot.data["Id"],
      name: snapshot.data["Name"],
      phone: snapshot.data["Phone"],
    );
  }

  ///get supervisor by id
  Stream<Supervisor> getSupervisorDataById(String uid) {
    return userReference.document(uid).snapshots().map(supervisorFromSnapshot);
  }

  ///get all supervisors by branch
  Future getAllSupervisorsByBranch(String branch) async {
    return userReference.where("Branch", isEqualTo: branch).getDocuments();
  }
}
