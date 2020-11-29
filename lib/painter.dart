import 'dart:ui';
import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  var size;
  final List<Offset> offsets;
  var color;

  Painter({@required this.size, @required this.offsets, @required this.color})
      : super();

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = this.color
      ..isAntiAlias = true
      ..strokeWidth = this.size;

    for (int i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != null && offsets[i + 1] != null) {
        canvas.drawLine(offsets[i], offsets[i + 1], _paint);
      } else if (offsets[i] != null && offsets[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [offsets[i]], _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

