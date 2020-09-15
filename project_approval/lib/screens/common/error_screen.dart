import 'package:flutter/material.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/screens/common/widgets.dart';
import 'package:project_approval/utils/style.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  ErrorScreen({this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: drawerScreenAppBar("Error", context),
        body: ErrorScreenBody(),

      ),
    );
  }
}

class ErrorScreenBody extends StatelessWidget {
  final String error;

  ErrorScreenBody({this.error});

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
                      minHeight: MediaQuery.of(context).size.height - 56,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height: 50,),
                            Text(
                              "${error ?? ''}",
                              style: appBarTitleStyle.copyWith(
                                  color: Colors.black,
                                  fontFamily: "Open Sans Regular",
                                  height: 1.5,
                                  fontSize: 18),
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
