import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/activity_circle.dart';
import '../widgets/date_observer.dart';
import '../model/model.dart';
import 'date_details.dart';

class ActivityCalendar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        body: DateObserver(
            builder: (context, now) => GridView.builder(
                  reverse: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    var today = now;
                    var dayoffset = index - 2 * (index % 7) - 1 + today.weekday;
                    var date = today.subtract(Duration(days: dayoffset));
                    var dateStr = DateFormat("yyyy-MM-dd").format(date);
                    return GestureDetector(
                        onTap: () {
                          _showDetails(context, dateStr);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: dayoffset >= 0
                                    ? Color.fromARGB(255, 241, 241, 241)
                                    : Color.fromARGB(255, 230, 230, 230),
                                border: Border.all(
                                    color: Color.fromARGB(17, 0, 0, 0),
                                    width: 0.5)),
                            padding: EdgeInsets.all(3),
                            child: ScopedModelDescendant<MyModel>(
                                builder: (context, child, model) =>
                                    FutureBuilder(
                                      future: model.getForDate(dateStr),
                                      initialData: <Activity>[],
                                      builder: (context, snapshot) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${date.day}',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      64, 0, 0, 0))),
                                          for (var activity in snapshot.data)
                                            Padding(
                                              padding: EdgeInsets.all(2),
                                              child: ActivityCircle(
                                                  activity: activity, size: 12),
                                            )
                                        ],
                                      ),
                                    ))));
                  },
                )));
  }

  void _showDetails(BuildContext context, String date) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DateDetails(date);
    }));
  }
}
