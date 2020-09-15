import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/screens/common/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/utils/style.dart';
import 'dart:math' as math;

class ServiceScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ServiceScreen({
    this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: drawerScreenAppBar("Services", context),
        body: ServiceScreenBody(),
      ),
    );
  }
}

class ServiceScreenBody extends StatelessWidget {
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
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
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
                                      'assets/logo/our-services.svg',
                                      color: Colors.black87,
                                      semanticsLabel: 'services',
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Best Services for you',
                                            textAlign: TextAlign.start,
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black87,
                                                fontFamily: "Raleway Bold",
                                                fontSize: 20),
                                          ),
                                          Text(
                                            'Our Project is simple and effective. This is a simple user friendly system which can provide the user to have an automated data of Online Submissions made by Students.',
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black,
                                                fontFamily: "Open Sans Regular",
                                                height: 1.5,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'User Satisfaction',
                                            textAlign: TextAlign.start,
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black87,
                                                fontFamily: "Raleway Bold",
                                                fontSize: 20),
                                          ),
                                          Text(
                                            'This is a system which makes user work simple and ease to work on Automated Data of Online Submissions of Projects. This is more useful for Educational Institutions.',
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black,
                                                fontFamily: "Open Sans Regular",
                                                height: 1.5,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    SvgPicture.asset(
                                      'assets/logo/satisfaction.svg',
                                      color: Colors.black87,
                                      semanticsLabel: 'Satisfaction',
                                      width: 50,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/logo/maintenance.svg',
                                      color: Colors.black45,
                                      semanticsLabel: 'Logout',
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Maintenance Facility',
                                            textAlign: TextAlign.start,
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black87,
                                                fontFamily: "Raleway Bold",
                                                fontSize: 20),
                                          ),
                                          Text(
                                            'We provide Maintenance Facility to all the users so that any Updations and necessary requirements are Provided according to your Will & Wish.',
                                            style: appBarTitleStyle.copyWith(
                                                color: Colors.black,
                                                fontFamily: "Open Sans Regular",
                                                height: 1.5,
                                                fontSize: 18),
                                          ),
                                        ],
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
//                  color: Colors.red.withOpacity(.5),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(5, 200, 5, 0),
                  child: Column(
                    children: [
                      Text(
                        'Services',
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
