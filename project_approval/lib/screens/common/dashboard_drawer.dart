import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/models/hod.dart';
import 'package:project_approval/models/principal.dart';
import 'package:project_approval/models/student.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/screens/common/about_screen.dart';
import 'package:project_approval/screens/common/contact_us_screen.dart';
import 'package:project_approval/screens/common/dashboard.dart';
import 'package:project_approval/screens/common/logout_screen.dart';
import 'package:project_approval/screens/common/service_screen.dart';
import 'package:project_approval/screens/common/settings_screen.dart';
import 'package:project_approval/screens/common/update_profile_screen.dart';
import 'package:project_approval/utils/colors.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';
import 'package:project_approval/utils/style.dart';

class DashboardDrawer extends StatelessWidget {
  final DocumentSnapshot snapshot;
  DashboardDrawer(
      {this.snapshot,});

  @override
  Widget build(BuildContext context) {
    print("snapshot data: " + snapshot.data.toString());
    //variables we need
    String name = "Name";
    String profileImageUrl = defaultProfileImageUrl;
    String designation;
    String coOrdinatorId;
    String branch;
    String userType = snapshot.data["USER_TYPE"];
    if (userType == principalType) {
      Principal principal = Helper().generatePrincipalData(snapshot);
      if (principal != null) {
        name = principal.name;
        profileImageUrl = principal.profileImage ?? defaultProfileImageUrl;
        designation = principal.designation;

      }
    } else if (userType == supervisorType) {
      Supervisor supervisor = Helper().generateSupervisorData(snapshot);
      profileImageUrl = supervisor.profileImageUrl ?? defaultProfileImageUrl;
      name = supervisor.name;
      designation = supervisor.designation;
      branch = supervisor.branch;
    } else if (userType == hodType) {
      Hod hod = Helper().generateHodData(snapshot);
      print("hod details in drawer : " + hod.toString());
      profileImageUrl = hod.profileImageUrl ?? defaultProfileImageUrl;
      name = hod.name;
      designation = hod.designation;
      branch = hod.branch;

    } else if (userType == studentType) {
      Student student = Helper().generateStudentData(snapshot);
    }

    return Drawer(
      child: ListView(
        children: [
          ClipPath(
            clipper: CustomLoginScreenClipper(),
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 20.0),
              color: Colors.cyanAccent,
              constraints: BoxConstraints(
                minHeight: 300,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          border: Border.all(color: Colors.black87, width: 2.0),
                          shape: BoxShape.circle,
                        ),
                        child: profileImageUrl == defaultProfileImageUrl
                            ? SvgPicture.asset(
                                'assets/logo/user.svg',
                                width: 50,
                                color: Colors.black87,
                              )
                            : NetworkImage(
                                "$profileImageUrl",
                              ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ///update profile screen
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UpdateProfileScreen(snapshot: snapshot,),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
//                          color: Colors.white,
                          ),
                          child: Text(
                            'Edit Profile',
                            maxLines: 2,
                            style: appBarTitleStyle.copyWith(
                              fontSize: 15,
                              color: Colors.blueAccent,
                              fontFamily: "Open Sans Bold",
                            ),
                          ),
                        ),
                      )
                    ],

                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '$name',
                    style: appBarTitleStyle.copyWith(color: Colors.black),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  userType != principalType
                      ? Text(
                          'Branch - $branch',
                          maxLines: 2,
                          style: appBarTitleStyle.copyWith(
                            fontSize: 18,
                            color: Colors.black87,
                            fontFamily: "Raleway Bold",
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 5.0,
                  ),
                  (userType == hodType && userType != supervisorType)
                      ? Text(
                          "Co-ordinator Id - ${coOrdinatorId ?? 'NIL'}",
                          maxLines: 2,
                          style: appBarTitleStyle.copyWith(
                              fontSize: 18,
                              color: Colors.black87,
                              fontFamily: "Raleway Bold"),
                        )
                      : (userType == studentType)
                          ? Text(
                              'Designation- CSE7312',
                              maxLines: 2,
                              style: appBarTitleStyle.copyWith(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontFamily: "Raleway Bold"),
                            )
                          : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  userType != studentType ? Text(
                    'Designation- $designation',
                    maxLines: 2,
                    style: appBarTitleStyle.copyWith(
                        fontSize: 18,
                        color: Colors.black87,
                        fontFamily: "Raleway Bold"),
                  ) : Container(),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //home
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: listItemGradientBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Home',
                    style: appBarTitleStyle.copyWith(
                        color: Colors.grey[700], fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //my account
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutScreen(snapshot: snapshot,),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: listItemGradientBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('About',
                      style: appBarTitleStyle.copyWith(
                          color: Colors.grey[700], fontSize: 18)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //my orders
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ServiceScreen(snapshot: snapshot,),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: listItemGradientBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/logo/services_icon.svg',
                      color: Colors.grey[700], semanticsLabel: 'Services'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Services',
                      style: appBarTitleStyle.copyWith(
                          color: Colors.grey[700], fontSize: 18)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //categories
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContactUsScreen(snapshot: snapshot,),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: listItemGradientBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Contact Us',
                      style: appBarTitleStyle.copyWith(
                          color: Colors.grey[700], fontSize: 18)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //divider
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.white,
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //settings
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(snapshot: snapshot,),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: listItemGradientBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Settings',
                      style: appBarTitleStyle.copyWith(
                          color: Colors.grey[700], fontSize: 18)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //about
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LogoutScreen(snapshot: snapshot,),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: listItemGradientBackground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/logo/log_out.svg',
                      color: Colors.grey[700], semanticsLabel: 'Logout'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Logout',
                      style: appBarTitleStyle.copyWith(
                          color: Colors.grey[700], fontSize: 18)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
