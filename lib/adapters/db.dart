import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart';

class Db {
  static final String _createActivitiesTable =
      'CREATE TABLE IF NOT EXISTS activities(id INTEGER PRIMARY KEY, name TEXT, date TEXT) ';
  static final String _createDateIndex =
      'CREATE INDEX IF NOT EXISTS date ON activities(date)';

  Future<Database> database;

  Future<void> open() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'donethis.db'),
      onCreate: (db, version) {
        return db.execute(_createActivitiesTable).then((void x) {
          return db.execute(_createDateIndex);
        });
      },
      onUpgrade: (db, prevVersion, newVersion) {
        return db.execute(_createDateIndex);
      },
      version: 2,
    );
  }

  Future<void> insert(Activity activity) async {
    Database db = await database;
    await db.insert('activities', activity.toMap());
  }

  Future<bool> exists(Activity activity) async {
    Database db = await database;
    var results = await db.query('activities',
        where: 'name = ? AND date = ?',
        whereArgs: [activity.name, activity.date]);
    return results.length > 0;
  }

  Future<List<Activity>> getActivitiesForDate(String date) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('activities', where: 'date = ?', whereArgs: [date]);
    return results.map((row) => Activity.fromMap(row)).toList();
  }

  Future<void> deleteActivity(Activity activity) async {
    Database db = await database;
    return db.delete('activities',
        where: 'name = ? AND date = ?',
        whereArgs: [activity.name, activity.date]);
  }
}
