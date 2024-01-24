import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

class Shape extends StatelessWidget {
  final String shape;
  final Color color;
  final double height, width;
  Shape(
      {required this.shape,
      required this.color,
      required this.height,
      required this.width,
      super.key});

  final ShapeBorder rectangle = RectangleShapeBorder(
    borderRadius: DynamicBorderRadius.only(
      topLeft: DynamicRadius.circular(10.toPXLength),
      bottomRight:
          DynamicRadius.elliptical(60.0.toPXLength, 10.0.toPercentLength),
    ),
  );

  final ShapeBorder circle = const CircleShapeBorder(
    border: DynamicBorderSide(
      style: BorderStyle.none,
      strokeJoin: StrokeJoin.miter,
      strokeCap: StrokeCap.round,
    ),
  );

  final ShapeBorder triangle = const TriangleShapeBorder(
    border: DynamicBorderSide(
      style: BorderStyle.none,
      strokeJoin: StrokeJoin.miter,
      strokeCap: StrokeCap.round,
    ),
  );

  final ShapeBorder polygon = const PolygonShapeBorder(
      border: DynamicBorderSide(
    style: BorderStyle.none,
    strokeJoin: StrokeJoin.miter,
    strokeCap: StrokeCap.round,
  ));

  ShapeBorder shapeBorder() {
    switch (shape) {
      case "triangle":
        return triangle;
      case "circle":
        return circle;
      case "polygon":
        return polygon;
      default:
        return rectangle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: shapeBorder(),
      color: color,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
