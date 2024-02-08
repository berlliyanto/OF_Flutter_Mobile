import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget skeletonCircle({double radius = 50}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    child: CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade400,
    ),
  );
}
