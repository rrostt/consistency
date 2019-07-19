import 'package:scoped_model/scoped_model.dart';
import 'package:consistency/adapters/db.dart';

class Activity {
  String name;
  String date;
  Activity({this.name, this.date});

  bool compareTo(Activity a) {
    return name == a.name && date == a.date;
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'date': date};
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(name: map['name'], date: map['date']);
  }
}

class MyModel extends Model {
  final Db db;

  List<String> _availableActivities = ['run', 'gym'];

  List<String> get availableActivities => _availableActivities;

  MyModel() : db = Db();

  Future<void> init() async {
    await db.open();
  }

  Future<List<Activity>> getForDate(String date) async =>
      db.getActivitiesForDate(date);

  Future<void> addActivity(Activity activity) async {
    if (!await db.exists(activity)) {
      await db.insert(activity);
      notifyListeners();
    }
  }

  Future<void> removeActivity(Activity activity) async {
    if (await db.exists(activity)) {
      await db.deleteActivity(activity);
      notifyListeners();
    }
  }
}
