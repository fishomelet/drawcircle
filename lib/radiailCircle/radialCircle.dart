import 'package:flutter/material.dart';
import 'dailPainter.dart';
import 'radialPainter.dart';
import '../dbHelper.dart';

class RadialCircle extends StatefulWidget {
  const RadialCircle({super.key});

  @override
  State<RadialCircle> createState() => _RadialCircleState();
}

class _RadialCircleState extends State<RadialCircle> {
  var activity = [
    // hour, minute, duration
    [23, 0, 100],
    [5, 30, 60],
    [13, 10, 30],
    [14, 20, 30],
    [1, 30, 60],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Text('hello'),
        ),
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: CustomPaint(painter: dailPainter()),
          ),
        ),
        Center(
            child: CustomPaint(
                painter: radialPainter(
                    radius: 130,
                    activityTime: activity,
                    rcolor: Colors.orange))),
        Center(
            child: CustomPaint(
                painter: radialPainter(radius: 100, activityTime: activity))),
      ]),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
