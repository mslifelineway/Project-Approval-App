import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'file:///E:/flutter_apps_workspace/project_approval/lib/screens/login_page.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/utils/style.dart';

class ForgetPasswordMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: loginScreenAppBar,
      body: _ForgetPasswordMessageScreenBody(),
    );
  }
}

class _ForgetPasswordMessageScreenBody extends StatelessWidget {
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
                        height: 280,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: Colors.cyanAccent.withOpacity(.4),
                            padding: EdgeInsets.only(bottom: 40),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                                    child: Text(
                                      "RESET PASSWORD",
                                      textAlign: TextAlign.center,
                                      style: defaultTextStyle.copyWith(
                                          fontSize: 30,
                                          fontFamily: "SuezOne Regular",
                                          color: Colors.black87),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      "We have sent a reset password link to your registered email address",
                                      textAlign: TextAlign.center,
                                      style: defaultTextStyle.copyWith(
                                          fontSize: 20,
                                          fontFamily: "Verdana",
                                          color: Colors.black87),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          )
                                      );
                                    },
                                    color: Colors.white.withOpacity(.8),
                                    child: Text(
                                      "Login",
                                      style: defaultTextStyle.copyWith(
                                        color: Colors.black87,
                                        fontFamily: "RussoOne Regular",
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
