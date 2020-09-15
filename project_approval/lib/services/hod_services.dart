import 'package:project_approval/models/hod.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';

class HodService {

  ///return supervisor from hodFromDynamicMap -> Map<String, dynamic>
  ///NOTE - NOT USED YET
  Hod hodFromDynamicMap(doc) {
    return doc != null
        ? Hod(
            id: doc.data["Id"],
            name: doc.data["Name"],
            email: doc.data["Email"],
            password: doc.data["Password"],
            phone: doc.data["Phone"],
            profileImageUrl: doc.data["ProfileImageUrl"],
            designation: doc.data["Designation"],
            userType: doc.data["USER_TYPE"],
            branch: doc.data["Branch"],
          )
        : null;
  }

  Future updateHodProfileData(Hod hod) async{
    try {
      return await userReference.document(hod.id).updateData({
        "Name": hod.name,
        "Branch": hod.branch,
        "Phone": hod.phone,
        "Designation": hod.designation,
        "ProfileImageUrl": hod.profileImageUrl,
      });
    } catch(e) {
      return Helper().identifyErrorInException(e.toString());
    }
  }
}