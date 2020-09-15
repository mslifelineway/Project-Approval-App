import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:project_approval/bloc/bloc.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/screens/forget_password_message.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/auth_service.dart';
import 'package:project_approval/utils/style.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: loginScreenAppBar,
      body: _ForgetPasswordBody(),
    );
  }
}

class _ForgetPasswordBody extends StatefulWidget {
  @override
  __ForgetPasswordBodyState createState() => __ForgetPasswordBodyState();
}

class __ForgetPasswordBodyState extends State<_ForgetPasswordBody> {
  final authBloc = new AuthBloc();
  String emailText = "";
  String forgetPasswordError = "";
  bool isForgetPasswordLoading = false;

  @override
  void initState() {
    authBloc.email.listen((event) {
      emailText = event;
    });
    super.initState();
  }

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
                              child: Image(
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                image: AssetImage("assets/logo/cits-logo.png"),
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
                          minHeight: MediaQuery.of(context).size.height - 370,
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
                                  height: 60,
                                ),
                                Container(
                                  child: StreamBuilder<String>(
                                      stream: authBloc.email.map((event) {
                                    return emailText;
                                  }), builder: (context, emailSnapshot) {
                                    return TextField(
                                      onChanged: authBloc.emailChanged,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      style: appBarTitleStyle.copyWith(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontFamily: "Open Sans Bold"),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: -5),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                        ),
                                        hintText: "Enter Email ID",
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            decoration: TextDecoration.none,
                                            fontFamily: "Raleway Bold"),
                                        errorText: emailSnapshot.error,
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                isForgetPasswordLoading
                                    ? TransparentLoadingScreen()
                                    : StreamBuilder<bool>(
                                        stream:
                                            authBloc.submitCheckOnlyForEmail,
                                        builder: (submitContext,
                                            checkSubmitSnapshot) {
                                          return Container(
                                            height: 40,
                                            decoration: checkSubmitSnapshot
                                                    .hasData
                                                ? BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                  )
                                                : BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.0),
                                                  ),
                                            child: FlatButton(
                                              onPressed: checkSubmitSnapshot
                                                      .hasData
                                                  ? () {
                                                      resetPassword(context);
                                                    }
                                                  : null,
                                              child: Text(
                                                'Continue',
                                                style:
                                                    defaultTextStyle.copyWith(
                                                  fontFamily:
                                                      "RussoOne Regular",
                                                  fontSize: 20,
                                                  color: checkSubmitSnapshot
                                                          .hasData
                                                      ? Colors.black87
                                                      : Colors.grey[500],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  forgetPasswordError,
                                  style: appBarTitleStyle.copyWith(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
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
                  height: 305,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(5, 260, 5, 0),
                  child: Text(
                    "Forget Password",
                    textAlign: TextAlign.center,
                    style: defaultTextStyle.copyWith(
                        fontSize: 25,
                        fontFamily: "SuezOne Regular",
                        color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    AuthService authService = new AuthService();
    setState(() {
      isForgetPasswordLoading = true;
    });
    //logic for resetting password
    dynamic result = await authService.resetPassword(emailText);
    if (result == null) {
      setState(() {
        isForgetPasswordLoading = false;
      });
      //redirect user to reset password message screen

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgetPasswordMessageScreen()));
    } else {
      setState(() {
        isForgetPasswordLoading = false;
        forgetPasswordError = result;
      });
    }
  }

  void forgetPassword(BuildContext context) {
    AuthService authService = new AuthService();
    setState(() {
      isForgetPasswordLoading = true;
    });
    ///check for this user is in database or not


  }
}
