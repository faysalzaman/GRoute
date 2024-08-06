import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading {
  // Spinkit loading

  static Widget spinkitLoading(Color color, double size) {
    return SpinKitChasingDots(
      color: color,
      size: size,
    );
  }
}
