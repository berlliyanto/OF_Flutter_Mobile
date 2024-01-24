import 'package:flutter/material.dart';

Widget positionedShape(
    {double top = 0.0, double left = 0.0, required Widget child}) {
  return Positioned(
    top: top,
    left: left,
    child: child,
  );
}
