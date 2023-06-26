import 'dart:math' as math;

import 'package:flutter/material.dart';

class radialPainter extends CustomPainter {
  double radius;
  var activityTime;
  Color rcolor;

  radialPainter(
      {this.radius = 130,
      this.activityTime = const [
        [0, 0, 0]
      ],
      this.rcolor = const Color.fromRGBO(3, 212, 190, 1.0)});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    //double radius = 130;
    final rect = Rect.fromLTRB(-radius, -radius, radius, radius);
    final startAngle = 0.0;
    final sweepAngle = 2 * math.pi;
    var useCenter = false;

    var basepaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    var paint = Paint()
      ..color = rcolor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, basepaint);

    for (List<int> i in activityTime) {
      //start from 24 by rotate -90 degree + hour + minutes
      var startAngle2 =
          -math.pi / 2 + i[0] / 12 * math.pi + i[1] / 60 / 12 * math.pi;
      var sweepAngle2 = i[2] * 2 * math.pi / 60 / 24;
      canvas.drawArc(rect, startAngle2, sweepAngle2, useCenter, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
