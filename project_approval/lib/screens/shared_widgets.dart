import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/style.dart';

final loginScreenAppBar = AppBar(
  backgroundColor: Colors.cyanAccent,
  title: Text(
    "PROJECT APPROVAL",
    style: appBarTitleStyle,
  ),
  centerTitle: true,
);

final defaultAppBar = AppBar(
  titleSpacing: -10.0,
  iconTheme: new IconThemeData(
    color: Colors.black87,
  ),
  backgroundColor: Colors.cyanAccent,
  title: Text(
    'PROJECT APPROVAL',
    style: appBarTitleStyle,
  ),
  centerTitle: true,
);

final dashboardAppBar = AppBar(
  titleSpacing: -10.0,
  iconTheme: new IconThemeData(
    color: Colors.black87,
  ),
  backgroundColor: Colors.cyanAccent,
  title: Row(
    children: [
      Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(5),
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/logo/cits-logo.png'),
            ),
          ),
        ],
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        'PROJECT APPROVAL',
        style: appBarTitleStyle,
      ),
    ],
  ),
  centerTitle: true,
);

final defaultScreenToShow = Container(
  color: Colors.cyanAccent.withOpacity(.6),
  child: Expanded(
    child: Text(
      'Oops! something went wrong please try again.',
      style: appBarTitleStyle.copyWith(
        fontSize: 22,
      ),
    ),
  ),
);

///gradient buttons
final gradientAddButton = LinearGradient(
  colors: [
    Colors.grey[300].withOpacity(.5),
    Colors.lightBlueAccent.withOpacity(.2),
  ],
);

final gradientAddFacultyButton = LinearGradient(
  colors: [
    Colors.black45.withOpacity(.5),
    Colors.cyanAccent.withOpacity(.2),
    Colors.black45.withOpacity(.5),
  ],
);
final gradientCancelFacultyButton = LinearGradient(
  colors: [
    Colors.grey[200],
    Colors.redAccent.withOpacity(.3),
//    Colors.black45.withOpacity(.5),
  ],
);

final branchPopupMenuItems = <PopupMenuItem<int>>[
  PopupMenuItem(
    value: branch,
    child: Text(
      selectBranch,
      style: appBarTitleStyle.copyWith(
        fontSize: 16,
        fontFamily: "Open Sans Bold",
        color: Colors.black54,
      ),
    ),
  ),
  PopupMenuItem(
    value: cse,
    child: Text(
      cseBranch,
      style: appBarTitleStyle.copyWith(
        fontSize: 16,
        fontFamily: "Open Sans Bold",
        color: Colors.black54,
      ),
    ),
  ),
  PopupMenuItem(
    value: mec,
    child: Text(
      mecBranch,
      style: appBarTitleStyle.copyWith(
        fontSize: 16,
        fontFamily: "Open Sans Bold",
        color: Colors.black54,
      ),
    ),
  ),
  PopupMenuItem(
    value: civ,
    child: Text(
      civBranch,
      style: appBarTitleStyle.copyWith(
        fontSize: 16,
        fontFamily: "Open Sans Bold",
        color: Colors.black54,
      ),
    ),
  ),
  PopupMenuItem(
    value: eee,
    child: Text(
      eeeBranch,
      style: appBarTitleStyle.copyWith(
        fontSize: 16,
        fontFamily: "Open Sans Bold",
        color: Colors.black54,
      ),
    ),
  ),
  PopupMenuItem(
    value: ece,
    child: Text(
      eceBranch,
      style: appBarTitleStyle.copyWith(
        fontSize: 16,
        fontFamily: "Open Sans Bold",
        color: Colors.black54,
      ),
    ),
  ),
];

///first index must be as select supervisor so we need this one
final selectSupervisorPopupMenuItem = PopupMenuItem(
  value: 0,
  child: Text(
    "Select Supervisor",
    style: appBarTitleStyle.copyWith(
      fontSize: 16,
      fontFamily: "Open Sans Bold",
      color: Colors.black54,
    ),
  ),
);
