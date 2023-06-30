class DailyActivity {
  final String area;
  final String date;
  final String time;
  final num activityMinutes;

  // num hour;
  // num min;

  const DailyActivity({
    required this.area,
    required this.date,
    required this.time,
    required this.activityMinutes,
  });

  @override
  String toString() {
    return 'DailyActivity($area, $date, $time, $activityMinutes)';
  }

  List<num> getTime() {
    var timef = time.split(":");
    num hour = int.parse(timef[0]);
    num minute = int.parse(timef[1]);

    return [hour, minute, activityMinutes];
  }
}
