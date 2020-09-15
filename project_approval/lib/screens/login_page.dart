import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:project_approval/bloc/bloc.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/screens/forget_password.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/user_service.dart';
import 'package:project_approval/utils/style.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: loginScreenAppBar,
        body: _LoginScreenBody(),
      ),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  @override
  __LoginScreenBodyState createState() => __LoginScreenBodyState();
}

class __LoginScreenBodyState extends State<_LoginScreenBody> {
  final UserService _userService = new UserService();
  String error = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authBloc = new AuthBloc();
    return  isLoading ? LoadingScreen() : SingleChildScrollView(
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
                        height: 230,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: Colors.cyanAccent.withOpacity(.4),
                            padding: EdgeInsets.only(bottom: 40),
                            child: Center(
                              child: Image(
                                width: 150,
                                height: 150,
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
                                SizedBox(height: 60,),
                                Container(
                                  child: StreamBuilder<String>(
                                      stream: authBloc.email,
                                      builder: (context, snapshot) {
                                        return TextField(
                                          onChanged: authBloc.emailChanged,
                                          keyboardType: TextInputType.emailAddress,
                                          maxLines: 1,
                                          style: appBarTitleStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontFamily: "Raleway Bold"
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: -10, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            hintText: "Enter Email ID",
                                            hintStyle: TextStyle(
//                                          height: 3,
                                                fontSize: 16,
                                                decoration: TextDecoration.none,
                                                fontFamily: "Raleway Bold"
                                            ),
                                            labelText: "Email ID",
                                            labelStyle: appBarTitleStyle.copyWith(
                                              color: Colors.black54,
                                              fontFamily: "Verdana",
                                              fontSize: 18,
                                              height: 1,
                                            ),

                                            errorText: snapshot.error,
                                          ),
                                        );
                                      }
                                  ),
                                ),
                                SizedBox(height: 30.0,),
                                Container(
                                  child: StreamBuilder<String>(
                                      stream: authBloc.password,
                                      builder: (context, snapshot) {
                                        return TextField(
                                          onChanged: authBloc.passwordChanged,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          maxLines: 1,
                                          style: appBarTitleStyle.copyWith(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontFamily: "Raleway Bold"
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: -10, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            hintText: "Enter Password",
                                            hintStyle: TextStyle(
//                                            height: 3,
                                                fontSize: 16,
                                                decoration: TextDecoration.none,
                                                fontFamily: "Raleway Bold"
                                            ),
                                            labelText: "Password",
                                            labelStyle: appBarTitleStyle.copyWith(
                                              color: Colors.black54,
                                              fontFamily: "Verdana",
                                              fontSize: 18,
                                              height: 1,
                                            ),
                                            errorText: snapshot.error,
                                          ),
                                        );
                                      }
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => ForgetPasswordScreen(),
                                                )

                                            );
                                          },
                                          child: Text("Forget Password?",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 14,
                                                fontFamily: "Raleway Bold"
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                error != null ? SizedBox(height: 15,) : Container(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(error,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 14,
                                              fontFamily: "Raleway Bold"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.0,),
                                StreamBuilder<bool>(
                                    stream: authBloc.submitCheck,
                                    builder: (context, loginCredentialSnapshot) {
                                      return RaisedButton(
                                        onPressed: loginCredentialSnapshot.hasData ? ()  {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          authBloc.email.listen((emailEvent) {
                                            authBloc.password.listen((passwordEvent) async {
                                              dynamic result = await _userService.signInUser(
                                                  emailEvent, passwordEvent);

//                                              dynamic result = await _userService.signUpUser(
//                                                  emailEvent, passwordEvent);
                                              ///result == null means user has signed in and auth has changed.
                                              if(result != null) {
                                                  setState(() {
                                                    isLoading = false;
                                                    error = result.toString();
                                                  });
                                              }
                                            });
                                          });
                                        } : null,
                                        color: Colors.white.withOpacity(.8),
                                        child: Text(
                                          "Login",
                                          style: defaultTextStyle.copyWith(
                                            color: Colors.black87,
                                            fontFamily: "RussoOne Regular",
                                            fontSize: 20,
                                          ),
                                        ),
                                      );
                                    }
                                )
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
                  height: 305,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(5, 210, 5, 0),
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: defaultTextStyle.copyWith(
                        fontSize: 30,
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
}
