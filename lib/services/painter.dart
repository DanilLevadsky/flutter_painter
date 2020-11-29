import 'dart:ui';

import 'package:flutter/material.dart';

import 'group_points.dart';

class Painter extends CustomPainter {
  var size;
  List<GroupPoints> offsets;
  var color;

  Painter({@required this.size, @required this.offsets, @required this.color})
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = this.size;

    for (int i = 0; i < offsets.length - 1; i++) {
      _paint.color = offsets[i].color;
      if (offsets[i].offset != null && offsets[i + 1].offset != null) {
        canvas.drawLine(offsets[i].offset, offsets[i + 1].offset, _paint);
      } else if (offsets[i].offset != null && offsets[i + 1].offset == null) {
        canvas.drawPoints(PointMode.points, [offsets[i].offset], _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

