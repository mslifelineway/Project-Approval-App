import 'package:flutter/material.dart';

class CustomLoginScreenClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    //half curve (divide into two points )
    var firstEndPoint = Offset(size.width * .5, size.height - 35);
    var firstControlPoint = Offset(size.width * .25, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    //other half curve also divided into two points
    var secondEndPoint = Offset(size.width, size.height - 70);
    var secondControlPoint = Offset(size.width * .75, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}

class CustomLoginScreenBottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 70);
    //half curve (divide into two points )
    var firstEndPoint = Offset(size.width * .5, 35);
    var firstControlPoint = Offset(size.width * .25, 15);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

//other half curve also divided into two points
    var secondEndPoint = Offset(size.width, 5);
    var secondControlPoint = Offset(size.width * .75, 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}