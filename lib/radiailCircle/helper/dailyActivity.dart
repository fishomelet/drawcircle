class DailyActivity {
  final String area;
  final String date;
  final String time;
  final num activityMinutes;

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
}
