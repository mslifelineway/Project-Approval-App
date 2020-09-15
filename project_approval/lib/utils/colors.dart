import 'package:flutter/material.dart';

final listItemGradientBackground = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Colors.white.withOpacity(0.1),
      Colors.black.withOpacity(0.1),
      Colors.white.withOpacity(0.1)
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  ),
);

final gradientHodPageBottomNavigationBar = LinearGradient(
  colors: [
    Colors.cyan.withOpacity(.8),
    Colors.white.withOpacity(0.8),
    Colors.cyan.withOpacity(0.8)
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

final teamAvailableColor = Colors.green;
final teamFullColor = Colors.red;