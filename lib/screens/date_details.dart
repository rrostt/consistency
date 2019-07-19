import 'package:flutter/material.dart';
import '../widgets/big_activity_badge.dart';
import '../model/model.dart';
import '../widgets/close_button.dart' as prefix0;
import 'package:scoped_model/scoped_model.dart';

class DateDetails extends StatelessWidget {
  final String date;

  DateDetails(this.date);

  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(builder: (context, child, model) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        body: Stack(
          children: <Widget>[
            _content(context, model),
            Positioned(
              top: 25 + MediaQuery.of(context).padding.top,
              right: 15,
              child: prefix0.CloseButton(onTap: () {
                Navigator.of(context).pop();
              }),
            )
          ],
        ),
      );
    });
  }

  Widget _content(context, MyModel model) {
    List<String> availableActivities = model.availableActivities;
    Future<List<Activity>> activities = model.getForDate(date);
    var dom = date.split('-')[2];
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: EdgeInsets.all(17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$dom',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(128, 0, 0, 0),
              ),
            ),
            FutureBuilder(
                future: activities,
                initialData: <Activity>[],
                builder: (context, snapshot) => GridView.count(
                        crossAxisCount: 4,
                        // childAspectRatio: 1,
                        shrinkWrap: true,
                        children: [
                          for (var activity in availableActivities)
                            _activity(
                                context,
                                model,
                                activity,
                                snapshot.data
                                    .map((x) => x.name)
                                    .toList()
                                    .contains(activity)),
                        ])),
          ],
        ),
      ),
    );
  }

  Widget _activity(context, MyModel model, String activity, bool enabled) {
    return BigActivityBadge(
        activity: activity,
        enabled: enabled,
        onTap: () {
          if (enabled) {
            model.removeActivity(Activity(name: activity, date: date));
          } else {
            model.addActivity(Activity(name: activity, date: date));
          }
        });
  }
}
