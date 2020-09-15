import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/screens/common/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/utils/style.dart';
import 'dart:math' as math;
class AboutScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  AboutScreen({
    this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: drawerScreenAppBar("About", context),
        body: AboutScreenBody(),
      ),
    );
  }
}

class AboutScreenBody extends StatelessWidget {

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
                Column(
                  children: [
                    ClipPath(
                      clipper: CustomLoginScreenClipper(),
                      child: Container(
                        height: 220,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 10,
                          child: Center(
                            child: Container(
                              color: Colors.cyanAccent.withOpacity(.4),
                              padding: EdgeInsets.fromLTRB(15, 50, 15, 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.rotate(
                                    child: Icon(
                                      Icons.send,
                                      size: 60,
                                      color: Colors.black87.withOpacity(.7),
                                    ),
                                    angle: 300 * math.pi / 180,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Project Approval System',
                                          textAlign: TextAlign.start,
                                          style: appBarTitleStyle.copyWith(
                                              color: Colors.black,
                                              fontFamily: "Open Sans Bold",
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Automation of Online Submission of Projects',
                                          style: appBarTitleStyle.copyWith(
                                              color: Colors.black,
                                              fontFamily: "Open Sans Regular",
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: CustomLoginScreenBottomClipper(),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 300,
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Card(
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
                                    SvgPicture.asset(
                                      'assets/logo/shapes_solid.svg',
                                      color: Colors.black45,
                                      semanticsLabel: 'shapes',
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'The problem of department is to establish a proper communication between students and supervisors regarding their projects and track the status of the project. This system will help the department, faculty and students in development of project.',
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Regular",
                                            height: 1.5,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/logo/draw_polygon_solid.svg',
                                      color: Colors.black45,
                                      semanticsLabel: 'Polygon',
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Academic Project management is a major issue which is faced by many Educational Institutions, the main reason for this is there is no automated System followed in any Institute. College management gathers all the Project Reports and project sources from students and store them physically in libraries. To overcome this practical problem and also to make the process easy we developed a secured application which is useful for each. ',
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black87,
                                            fontFamily: "Open Sans Regular",
                                            height: 1.5,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/logo/creative_commons_share_brands.svg',
                                      color: Colors.black45,
                                      semanticsLabel: 'Logout',
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'In this Online Project Approval System project, we will focus mainly on automating the process of project submission. In the sense project topics will be submitted online along with doc and approval will be provided online by the head of the department along with suggestions if any. This will reduce the physical efforts of students meeting the head of the department and also reduce the time frame period of completing this part of project work.',
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Regular",
                                            height: 1.5,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/logo/bookmark_solid.svg',
                                      color: Colors.black45,
                                      semanticsLabel: 'Logout',
                                      width: 30,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'The scope of the proposed application is any network connected system i.e., the projects developed as a Web application that opens in any system that is connected in a network with internet access to it.',
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Regular",
                                            height: 1.5,
                                            fontSize: 18),
                                      ),
                                    ),


                                  ],
                                ),

                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Expanded(
                                      child: Text(
                                        '- Copyright 2020 Project Approval System',
                                        textAlign: TextAlign.end,
                                        style: appBarTitleStyle.copyWith(
                                            color: Colors.black,
                                            fontFamily: "Open Sans Regular",
                                            height: 1.5,
                                            fontSize: 12),
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
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(5, 200, 5, 0),
                  child: Column(
                    children: [
                      Text(
                        'About',
                        textAlign: TextAlign.center,
                        style: appBarTitleStyle.copyWith(
                            color: Colors.black87,
                            fontFamily: "Raleway Bold",
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .2,
                        child: Divider(
                          color: Colors.black87,
                          thickness: 2,
                          height: 5,
                        ),
                      ),
                    ],
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
