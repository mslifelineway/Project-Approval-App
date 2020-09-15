import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/screens/common/dashboard_bottom_navigationbar.dart';
import 'package:project_approval/screens/common/dashboard_drawer.dart';
import 'package:project_approval/screens/common/sub_pages/view_files_screen.dart';
import 'package:project_approval/screens/common/sub_pages/view_projects_screen.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/style.dart';

class ProjectScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;
  ProjectScreen({this.snapshot,});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: DashboardDrawer(
          snapshot: snapshot,),
        appBar: dashboardAppBar,
        body: ProjectScreenBody(
          snapshot: snapshot,
        ),
        bottomNavigationBar: DashboardBottomNavigationBar(snapshot: snapshot, selectedNavIndex: projectIndex,),
      ),

    );
  }

}

class ProjectScreenBody extends StatelessWidget {
  final DocumentSnapshot snapshot;
  ProjectScreenBody({this.snapshot});
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
                                        builder: (context) => ViewProjectsScreen(),
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
                                          'assets/logo/project.svg',
                                          color: Colors.black87,
                                          semanticsLabel: 'view projects',
                                          width: 60,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'View Projects',
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
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ViewFilesScreen(),
                                      ),
                                    );
                                  } ,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black26, width: 2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/logo/view_files_icon.svg',
                                          color: Colors.black87,
                                          semanticsLabel: 'view files',
                                          width: 60,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'View Files',
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
