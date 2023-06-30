import 'package:drawcircle/radiailCircle/helper/dailyActivity.dart';
import 'package:flutter/material.dart';
import 'dailPainter.dart';
import 'radialPainter.dart';
import 'helper/dbHelper.dart';
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

  DateTime _selectedDate = DateTime.now();
  //var showDate = "6/9/2023";

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
      _fetchActivities();
    }
  }

  String? _selectedRoom1 = 'Bedroom';
  String? _selectedRoom2 = 'Bathroom';
  String? _selectedRoom3 = 'Kitchen';
  List<String> _rooms = [
    'Bedroom',
    'Bathroom',
    'Kitchen',
    'Dinning_Area',
    'Living_Room'
  ];

  final dbHelper = DbHelper();
  List<DailyActivity> _activityList = [];
  // var activity;

  void initState() {
    super.initState();
    dbHelper.loadDB();
    _fetchActivities();
  }

  Future<void> _fetchActivities() async {
    final showDate = DateFormat('M/d/yyyy').format(_selectedDate);
    final activityList = await dbHelper.getDailyActivities(showDate);
    setState(() {
      _activityList = activityList;
    });
  }

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
                DateFormat('EEEE, M/d/yyyy').format(_selectedDate),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () => {_selectDate(context)},
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
                            area: _selectedRoom1 ?? "",
                            activityList: _activityList,
                            rcolor: Colors.orange))),
                Positioned(
                    top: 150,
                    left: 150,
                    child: CustomPaint(
                        painter: radialPainter(
                            radius: 105,
                            area: _selectedRoom2 ?? "",
                            activityList: _activityList))),
                Positioned(
                    top: 150,
                    left: 150,
                    child: CustomPaint(
                        painter: radialPainter(
                            radius: 80,
                            area: _selectedRoom3 ?? "",
                            activityList: _activityList,
                            rcolor: Colors.purple.shade200))),
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
                    child: Text(
                      room,
                      style: TextStyle(color: Colors.orange),
                    ),
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
                    child: Text(
                      room,
                      style: TextStyle(color: Color.fromRGBO(3, 212, 190, 1.0)),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRoom2 = value;
                  });
                },
              ),
              DropdownButton<String>(
                value: _selectedRoom3,
                items: _rooms.map((String room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child: Text(room,
                        style: TextStyle(color: Colors.purple.shade200)),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRoom3 = value;
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
