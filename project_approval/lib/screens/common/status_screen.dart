import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/screens/common/dashboard_bottom_navigationbar.dart';
import 'package:project_approval/screens/common/dashboard_drawer.dart';
import 'package:project_approval/screens/common/sub_pages/approved_projects_screen.dart';
import 'package:project_approval/screens/common/sub_pages/pending_projects_screen.dart';
import 'package:project_approval/screens/common/sub_pages/rejected_projects_screen.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/style.dart';

class StatusScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;
  StatusScreen({this.snapshot,});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: DashboardDrawer(
          snapshot: snapshot,),
        appBar: dashboardAppBar,
        body: StatusScreenBody(
          snapshot: snapshot,
        ),
        bottomNavigationBar: DashboardBottomNavigationBar(snapshot: snapshot, selectedNavIndex: statusIndex,),
      ),

    );
  }

}

class StatusScreenBody extends StatelessWidget {
  final DocumentSnapshot snapshot;
  StatusScreenBody({this.snapshot});

  @override
  Widget build(BuildContext context) {
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
                      minHeight: MediaQuery.of(context).size.height - 150,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Card(
                      margin: EdgeInsets.only(bottom: 2),
                      elevation: 10,
                      child: Container(
                        color: Colors.cyanAccent.withOpacity(.4),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PendingProjectsScreen(),
                                      ),
                                    );
                                  } ,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(.4),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black12, width: 2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/logo/pending_project_icon.svg',
                                          color: Colors.black87,
                                          semanticsLabel: 'pending projects',
                                          width: 60,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Pending Projects',
                                          textAlign: TextAlign.center,
                                          style: appBarTitleStyle.copyWith(
                                              color: Colors.black87,
                                              fontFamily: "Raleway Bold",
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RejectedProjectsScreen(),
                                      ),
                                    );
                                  } ,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.redAccent.withOpacity(.4), width: 2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/logo/rejected_project_icon.svg',
                                          color: Colors.red,
                                          semanticsLabel: 'rejected projects',
                                          width: 60,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Rejected Projects',
                                          textAlign: TextAlign.center,
                                          style: appBarTitleStyle.copyWith(
                                              color: Colors.red,
                                              fontFamily: "Raleway Bold",
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ApprovedProjectsScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.green.withOpacity(.4), width: 2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/logo/approved_project_icon.svg',
                                          color: Colors.green,
                                          semanticsLabel: 'approved projects',
                                          width: 60,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Approved Projects',
                                          textAlign: TextAlign.center,
                                          style: appBarTitleStyle.copyWith(
                                              color: Colors.green,
                                              fontFamily: "Raleway Bold",
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
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
