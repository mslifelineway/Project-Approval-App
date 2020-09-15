import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/utils/constants.dart';

///rounded profile image
class StudentProfileImageRounded extends StatelessWidget {
  final String profileImageUrl;

  StudentProfileImageRounded({this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.cyanAccent.withOpacity(.5),
        border: Border.all(color: Colors.black45, width: 2.0),
        shape: BoxShape.circle,
      ),
      child: profileImageUrl == defaultProfileImageUrl
          ? SvgPicture.asset(
        'assets/logo/user.svg',
        width: 50,
        color: Colors.black54,
      )
          : NetworkImage(
        "$profileImageUrl",
      ),
    );
  }
}