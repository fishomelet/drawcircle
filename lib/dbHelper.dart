import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'radiailCircle/helper/dailyActivity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(path.join('assets', 'db', 'elderlyDB.db'));

  Future<List<DailyActivity>> getDailyActivities() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('DailyActivity');

    return List.generate(5, (i) {
      return DailyActivity(
          activityMinutes: maps[i]['ActivityMinutes'],
          area: maps[i]['Areas'],
          date: maps[i]['Date'],
          time: maps[i]['Time']);
    });
  }

  print(await getDailyActivities());
}
