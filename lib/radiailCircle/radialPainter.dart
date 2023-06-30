import 'dart:math' as math;

import 'package:drawcircle/radiailCircle/helper/dailyActivity.dart';
import 'package:flutter/material.dart';

class radialPainter extends CustomPainter {
  double radius;
  String area;
  List<DailyActivity> activityList;
  var timeList = [];
  Color rcolor;

  radialPainter(
      {required this.radius,
      required this.area,
      required this.activityList,
      this.rcolor = const Color.fromRGBO(3, 212, 190, 1.0)});

  void getTimeList() {
    final list =
        activityList.where((activity) => activity.area == area).toList();
    //list.length
    list.forEach((element) {
      timeList.add(element.getTime());
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    //double radius = 130;
    final rect = Rect.fromLTRB(-radius, -radius, radius, radius);
    const startAngle = 0.0;
    const sweepAngle = 2 * math.pi;
    var useCenter = false;

    getTimeList();

    var basepaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    var paint = Paint()
      ..color = rcolor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, basepaint);

    for (var i in timeList) {
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
