import 'dart:ui';

import 'package:flutter/material.dart';

import 'group_points.dart';

class Painter extends CustomPainter {
  var size;
  List<GroupPoints> points;
  var color;

  Painter({@required this.size, @required this.points, @required this.color})
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()..isAntiAlias = true;

    for (int i = 0; i < points.length - 1; i++) {
      _paint.color = points[i].color;
      _paint.strokeWidth = points[i].size;
      if (points[i].offset != null && points[i + 1].offset != null) {
        canvas.drawLine(points[i].offset, points[i + 1].offset, _paint);
      } else if (points[i].offset != null && points[i + 1].offset == null) {
        canvas.drawPoints(PointMode.points, [points[i].offset], _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

