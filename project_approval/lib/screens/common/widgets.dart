import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/models/supervisor.dart';
import 'package:project_approval/models/team.dart';
import 'package:project_approval/screens/common/hod_list_page.dart';
import 'package:project_approval/screens/common/sub_pages/phase_details_screen.dart';
import 'package:project_approval/screens/common/sub_pages/student_details.dart';
import 'package:project_approval/screens/common/sub_pages/update_student_screen.dart';
import 'package:project_approval/screens/common/sub_pages/update_team_screen.dart';
import 'package:project_approval/screens/common/sub_pages/upload_files_screen.dart';
import 'package:project_approval/screens/common/supervisor_screen.dart';
import 'package:project_approval/services/db_services/team_database_service.dart';
import 'package:project_approval/utils/style.dart';
import 'package:provider/provider.dart';

///appbar for drawer screens
Widget drawerScreenAppBar(String title, BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: appBarTitleStyle,
    ),
    backgroundColor: Colors.cyanAccent,
    leading: InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.black87,
        size: 30,
      ),
    ),
  );
}

///hod details widget
class HodDetailsWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  HodDetailsWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HodListPage(
              snapshot: snapshot,
            ),
          ),
        );
      },
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
              'assets/logo/admin_icon.svg',
              color: Colors.black87,
              semanticsLabel: 'Hod Details',
              width: 60,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Hod Details',
              textAlign: TextAlign.center,
              style: appBarTitleStyle.copyWith(
                  color: Colors.black87,
                  fontFamily: "Raleway Bold",
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

///update student widget
class StudentDetailsWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  StudentDetailsWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StudentDetailsScreen(),
          ),
        );
      },
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
              'assets/logo/student.svg',
              color: Colors.black87,
              semanticsLabel: 'Student Details',
              width: 60,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Student Details',
              textAlign: TextAlign.center,
              style: appBarTitleStyle.copyWith(
                  color: Colors.black87,
                  fontFamily: "Raleway Bold",
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

///phase details widget
class PhaseDetailsWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PhaseDetailsWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PhaseDetailsScreen(),
          ),
        );
      },
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
              'assets/logo/phase_icon.svg',
              color: Colors.black87,
              semanticsLabel: 'Phase details',
              width: 60,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Phase Details',
              textAlign: TextAlign.center,
              style: appBarTitleStyle.copyWith(
                  color: Colors.black87,
                  fontFamily: "Raleway Bold",
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

///supervisor details widget
class SupervisorDetailsWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  SupervisorDetailsWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SupervisorScreen(snapshot: snapshot),
          ),
        );
      },
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
              'assets/logo/superwiser.svg',
              color: Colors.black87,
              semanticsLabel: 'Supervisors',
              width: 60,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Supervisors',
              textAlign: TextAlign.center,
              style: appBarTitleStyle.copyWith(
                  color: Colors.black87,
                  fontFamily: "Raleway Bold",
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

///UpdateTeam widget
class UpdateTeamWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  UpdateTeamWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StreamProvider<List<Team>>.value(
                value: TeamDatabaseService(uid: snapshot.data["Id"]).getTeams,
                builder: (context, snapshot) {
                  return UpdateTeamScreen();
                }),
          ),
        );
      },
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
              'assets/logo/group.svg',
              color: Colors.black87,
              semanticsLabel: 'update team',
              width: 60,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Update Team',
              textAlign: TextAlign.center,
              style: appBarTitleStyle.copyWith(
                  color: Colors.black87,
                  fontFamily: "Raleway Bold",
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

///update student widget
class UpdateStudentWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  UpdateStudentWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UpdateStudentScreen(),
          ),
        );
      },
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
              'assets/logo/student.svg',
              color: Colors.black87,
              semanticsLabel: 'Update Student',
              width: 60,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Update Student Details',
              textAlign: TextAlign.center,
              style: appBarTitleStyle.copyWith(
                  color: Colors.black87,
                  fontFamily: "Raleway Bold",
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

///upload files widget
class UploadFilesWidget extends StatelessWidget {
  final DocumentSnapshot snapshot;

  UploadFilesWidget({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UploadFilesScreen(),
          ),
        );
      },
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
              'assets/logo/upload.svg',
              color: Colors.black87,
              semanticsLabel: 'Upload Files',
              width: 60,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Upload Files',
              textAlign: TextAlign.center,
              style: appBarTitleStyle.copyWith(
                  color: Colors.black87,
                  fontFamily: "Raleway Bold",
                  fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

