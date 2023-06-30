import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dailyActivity.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   print(DbHelper.createActivity('6/9/2023', "Bedroom"));
// }

class DbHelper {
  bool isLoaded = false;

  Future<Database> loadDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!isLoaded) {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'elderlyDB.db');

      // delete existing if any
      await deleteDatabase(path);

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      // var data = await rootBundle.load(join('assets/dbfile/test.db'));
      final data = await rootBundle.load(join('assets', 'db', 'elderlyDB.db'));

      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

      isLoaded = true;
    }
    return openDatabase(join(await getDatabasesPath(), 'elderlyDB.db'));
  }

  Future<List<DailyActivity>> getDailyActivities(String showDate) async {
    final db = await loadDB();

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
