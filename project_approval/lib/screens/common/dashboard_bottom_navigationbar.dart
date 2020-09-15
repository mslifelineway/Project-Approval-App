import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/models/user.dart';
import 'package:project_approval/screens/common/dashboard.dart';
import 'package:project_approval/screens/common/project_screen.dart';
import 'package:project_approval/screens/common/status_screen.dart';
import 'package:project_approval/screens/common/team_screen.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/services/db_services/database_service.dart';
import 'package:project_approval/services/db_services/student_service.dart';
import 'package:project_approval/services/db_services/supervisor_services.dart';
import 'package:project_approval/services/db_services/team_database_service.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:provider/provider.dart';

class DashboardBottomNavigationBar extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final int selectedNavIndex;

  DashboardBottomNavigationBar({
    this.snapshot,
    this.selectedNavIndex,
  });

  @override
  _DashboardBottomNavigationBarState createState() =>
      _DashboardBottomNavigationBarState();
}

class _DashboardBottomNavigationBarState
    extends State<DashboardBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        backgroundColor: Colors.cyanAccent,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        //since number of tabs in bottom navbar is 4 i.e 3-index, so when drawer item list is clicked/tapped
        //the index will be assign greater than 3 like 4,5 and so on. so let set default tab
        //that is selected tab index = 0, and color will such as tabs look like unselected, ie. no color
        currentIndex: widget.selectedNavIndex,
        onTap: (index) {
          onTapped(index, context);
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/logo/home_icon.svg',
              width: 30,
              color: Colors.pink,
            ),
            icon: SvgPicture.asset(
              'assets/logo/home_icon.svg',
              width: 30,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 14, fontFamily: "Roboto Regular"),
            ),
          ),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/logo/group.svg',
                width: 30,
                color: Colors.pink,
              ),
              icon: SvgPicture.asset(
                'assets/logo/group.svg',
                width: 30,
                color: Colors.black,
              ),
              title: Text(
                "Team",
                style: TextStyle(fontSize: 14, fontFamily: "Roboto Regular"),
              )),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/logo/project.svg',
                width: 30,
                color: Colors.pink,
              ),
              icon: SvgPicture.asset(
                'assets/logo/project.svg',
                width: 30,
                color: Colors.black,
              ),
              title: Text(
                "Projects",
                style: TextStyle(fontSize: 14, fontFamily: "Roboto Regular"),
              )),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/logo/project_status.svg',
                width: 30,
                color: Colors.pink,
              ),
              icon: SvgPicture.asset(
                'assets/logo/project_status.svg',
                width: 30,
                color: Colors.black,
              ),
              title: Text(
                "Status",
                style: TextStyle(fontSize: 14, fontFamily: "Roboto Regular"),
              )),
        ],
      ),
    );
  }

  void onTapped(int index, BuildContext context) async {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
        );
        break;

      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TeamScreen(
              snapshot: widget.snapshot,
            ),
          ),
        );

        break;

      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProjectScreen(
              snapshot: widget.snapshot,
            ),
          ),
        );
        break;

      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StatusScreen(
              snapshot: widget.snapshot,
            ),
          ),
        );
        break;
    }
  }
}
