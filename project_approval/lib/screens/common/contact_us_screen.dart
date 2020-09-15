import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/screens/common/widgets.dart';

import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/utils/style.dart';
import 'dart:math' as math;

class ContactUsScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ContactUsScreen({
    this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: drawerScreenAppBar("Contact Us", context),
        body: ContactUsScreenBody(),
      ),
    );
  }
}

class ContactUsScreenBody extends StatelessWidget {
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
                            child: Form(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Text(
                                    "We are here to help and answer any Question you might have. We look forward to hearing from you."
                                    " We also accept any suggestions you might think our system can do better.",
                                    style: appBarTitleStyle.copyWith(
                                        color: Colors.black,
                                        fontFamily: "Open Sans Regular",
                                        height: 1.5,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      style: appBarTitleStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontFamily: "Raleway Bold"),
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        hintStyle: appBarTitleStyle.copyWith(
                                          color: Colors.black54,
                                          fontFamily: "Raleway Bold",
                                          fontSize: 16,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter your name.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      style: appBarTitleStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontFamily: "Raleway Bold"),
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle: appBarTitleStyle.copyWith(
                                          color: Colors.black54,
                                          fontFamily: "Raleway Bold",
                                          fontSize: 16,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter email id.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      style: appBarTitleStyle.copyWith(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontFamily: "Raleway Bold"),
                                      decoration: InputDecoration(
                                        hintText: "Message...",
                                        hintStyle: appBarTitleStyle.copyWith(
                                          color: Colors.black54,
                                          fontFamily: "Raleway Bold",
                                          fontSize: 16,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please write your message...';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      ///TODO: CREATE A SCREEN FOR SHOWING SENT RESPONSE OR MESSAGE
                                    },
                                    color: Colors.white.withOpacity(.8),
                                    child: Text(
                                      "Send",
                                      style: defaultTextStyle.copyWith(
                                        color: Colors.black87,
                                        fontFamily: "RussoOne Regular",
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
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
                        'Contact Us',
                        textAlign: TextAlign.center,
                        style: appBarTitleStyle.copyWith(
                            color: Colors.black87,
                            fontFamily: "Raleway Bold",
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .33,
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
