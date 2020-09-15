import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent,
      child: SpinKitDualRing(
        color: Colors.teal,
        size: 50.0,
      ),
    );
  }
}

class TransparentLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SpinKitDualRing(
        color: Colors.teal,
        size: 50.0,
      ),
    );
  }
}
