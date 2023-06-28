import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'clockDailPainter.dart';

class ClockFace extends StatefulWidget {
  const ClockFace({super.key});

  @override
  State<ClockFace> createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Center(
              child: Transform.rotate(
                  angle: -math.pi / 2,
                  child: CustomPaint(painter: ClockPainter()))),
          Center(
            child: SizedBox(
                width: 290,
                height: 290,
                child: CustomPaint(
                  painter: ClockDialPainter(clockText: ClockText.arabic),
                )),
          ),
        ]),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    const rect = Rect.fromLTRB(-150, -150, 150, 150);
    const startAngle = 0.0;
    const sweepAngle = 2 * math.pi;
    const useCenter = false;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    var secHandBrush = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var minHandBrush = Paint()
      ..color = Colors.lightGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);

    var secHandX = 0 + 130 * math.cos(dateTime.second * 6 * math.pi / 180);
    var secHandY = 0 + 130 * math.sin(dateTime.second * 6 * math.pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    var minHandX = 0 + 110 * math.cos(dateTime.minute * 6 * math.pi / 180);
    var minHandY = 0 + 110 * math.sin(dateTime.minute * 6 * math.pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var hour = dateTime.hour + dateTime.minute / 60;
    var hourHandX = 0 + 70 * math.cos(hour * 30 * math.pi / 180);
    var hourHandY = 0 + 70 * math.sin(hour * 30 * math.pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    canvas.drawCircle(center, 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //throw UnimplementedError();
    return true;
  }
}
