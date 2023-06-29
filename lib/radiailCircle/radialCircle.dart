import 'package:flutter/material.dart';
import 'dailPainter.dart';
import 'helper/dailyActivity.dart';
import 'radialPainter.dart';
import '../dbHelper.dart';
import 'package:intl/intl.dart';

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

  var place = "Bedroom";
  var showDate = "6/9/2023";
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String? _selectedRoom1 = 'Bedroom';
  String? _selectedRoom2;
  String? _selectedRoom3;
  List<String> _rooms = ['Bedroom', 'Bathroom', 'Kitchen'];

  //var activityList = DbHelper.getDailyActivities("6/9/2023");
  // var activity;

  // void initState() {
  //   super.initState();
  //   activity = new DbHelper(showDate, place).activity;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEEE, MMM d, yyyy').format(_selectedDate),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select'),
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(painter: dailPainter()),
                ),
                Positioned(
                    top: 150,
                    left: 150,
                    child: CustomPaint(
                        painter: radialPainter(
                            radius: 130,
                            activityTime: activity,
                            rcolor: Colors.orange))),
                Positioned(
                    top: 150,
                    left: 150,
                    child: CustomPaint(
                        painter: radialPainter(
                            radius: 105, activityTime: activity))),
              ]),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: _selectedRoom1,
                items: _rooms.map((String room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child: Text(room),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRoom1 = value;
                  });
                },
              ),
              DropdownButton<String>(
                value: _selectedRoom2,
                items: _rooms.map((String room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child: Text(room),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRoom1 = value;
                  });
                },
              ),
              DropdownButton<String>(
                value: _selectedRoom3,
                items: _rooms.map((String room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child: Text(room),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRoom1 = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
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
