import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'radiailCircle/helper/dailyActivity.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   print(DbHelper.createActivity('6/9/2023', "Bedroom"));
// }

class DbHelper {
  var activity;

  DbHelper(var showDate, String place) {
    activity = createActivity(showDate, place);
  }

  static createActivity(var showDate, String place) async {
    var activity = [];
    var timef;
    int hour;
    int minute;
    //await loadDB();
    var list = await getDailyActivities(showDate);

    for (var i in list) {
      if (i.area == place) {
        timef = i.time.split(":");
        hour = int.parse(timef[0]);
        minute = int.parse(timef[1]);
        activity.add([hour, minute, i.activityMinutes]);
      }
    }

    return activity;
  }

  static loadDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'elderlyDB.db');

    // delete existing if any
    await deleteDatabase(path);

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    // var data = await rootBundle.load(join('assets/dbfile/test.db'));
    var data = await rootBundle.load(join('assets', 'db', 'elderlyDB.db'));

    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  }

  static Future<List<DailyActivity>> getDailyActivities(String showDate) async {
    final db =
        await openDatabase(join(await getDatabasesPath(), 'elderlyDB.db'));

    final List<Map<String, dynamic>> maps = await db
        .query('DailyActivity', where: '"Date" = ?', whereArgs: [showDate]);

    return List.generate(maps.length, (i) {
      return DailyActivity(
          activityMinutes: maps[i]['ActivityMinutes'] ?? 0,
          area: maps[i]['Areas'],
          date: maps[i]['Date'],
          time: maps[i]['Time']);
    });
  }
}
