import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/models/user.dart';
import 'package:project_approval/screens/common/dashboard_bottom_navigationbar.dart';
import 'package:project_approval/screens/common/dashboard_drawer.dart';
import 'package:project_approval/screens/common/error_screen.dart';
import 'package:project_approval/screens/common/widgets.dart';
import 'package:project_approval/screens/loading.dart';
import 'dart:math' as math;
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/auth_service.dart';
import 'file:///E:/flutter_apps_workspace/project_approval/lib/services/db_services/database_service.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    ///sign out automatically
//    AuthService authService =new AuthService();
//    authService.signOut();
    final User currentUser = Provider.of<User>(context);
    if (currentUser == null) LoadingScreen();
    print("currentUser in dashboard screen : " + currentUser.toString());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<DocumentSnapshot>(
          stream: DatabaseService(uid: currentUser.id).userData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingScreen();
            }
            print("checking....");
            print(snapshot.data.data);
            ///TODO: LOGIC IF USER IS ONLY AUTH BUT HIS DATA IS NOT PRESENT IN DATABASE (handle exception)
//            if (snapshot.data.data == null) {
////              Navigator.of(context).pushReplacement(MaterialPageRoute(
////                builder: (context) => ErrorScreen(),
////              ));
//                return ErrorScreen(error: reRegistrationMessage,);
//            }
            print("snapshot has data " + snapshot.toString());
            return Scaffold(
              drawer: DashboardDrawer(
                snapshot: snapshot.data,
              ),
              appBar: dashboardAppBar,
              body: DashboardBody(
                snapshot: snapshot.data,
              ),
              bottomNavigationBar: DashboardBottomNavigationBar(
                snapshot: snapshot.data,
                selectedNavIndex: homeIndex,
              ),
            );
          }),
    );
  }
}

class DashboardBody extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final int currentSelectedIndex;

  DashboardBody({this.snapshot, this.currentSelectedIndex});

  @override
  Widget build(BuildContext context) {
    String userType = "";
    if(snapshot.data != null)
      userType = snapshot.data["USER_TYPE"];
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomLoginScreenBottomClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 140,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Card(
                      margin: EdgeInsets.only(bottom: 2),
                      elevation: 10,
                      child: Container(
                        color: Colors.cyanAccent.withOpacity(.4),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
                        child: userType == principalType
                            ? PrincipalOptions(snapshot: snapshot)
                            : userType == hodType
                                ? HodOptions(
                                    snapshot: snapshot,
                                  )
                                : userType == supervisorType
                                    ? SupervisorOptions(
                                        snapshot: snapshot,
                                      )
                                    : Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

///principal options
class PrincipalOptions extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PrincipalOptions({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return snapshot == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HodDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StudentDetailsWidget(snapshot: snapshot),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PhaseDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SupervisorDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }
}

///hod options
class HodOptions extends StatelessWidget {
  final DocumentSnapshot snapshot;

  HodOptions({this.snapshot});

  @override
  Widget build(BuildContext context) {
    print("snapshot: " + snapshot.toString());
    return snapshot == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HodDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StudentDetailsWidget(snapshot: snapshot),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PhaseDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SupervisorDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }
}

///supervisor options
class SupervisorOptions extends StatelessWidget {
  final DocumentSnapshot snapshot;

  SupervisorOptions({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return snapshot == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HodDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StudentDetailsWidget(snapshot: snapshot),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PhaseDetailsWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SupervisorDetailsWidget(
                        snapshot: snapshot,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UpdateTeamWidget(
                        snapshot: snapshot,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UpdateStudentWidget(snapshot: snapshot),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UploadFilesWidget(snapshot: snapshot),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }
}
