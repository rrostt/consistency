import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import '../widgets/activity_circle.dart';
import '../model/model.dart';
import 'date_details.dart';

class ActivityList extends StatelessWidget {
  static final monthNames = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  static final dayNames = [
    '',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModelDescendant<MyModel>(
      builder: (context, child, model) => ListView.builder(
            itemBuilder: (context, i) {
              var date = DateTime.now().subtract(Duration(days: i));
              var year = date.year;
              var dom = date.day;
              var month = monthNames[date.subtract(Duration(days: 1)).month];
              var dateStr = DateFormat("yyyy-MM-dd").format(date);

              return FutureBuilder(
                  future: model.getForDate(dateStr),
                  initialData: <Activity>[],
                  builder: (context, AsyncSnapshot<List<Activity>> snapshot) =>
                      snapshot.hasError
                          ? Text(snapshot.error.toString())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  if (i == 0) _monthLabel('$month $year'),
                                  _dayItem(context, snapshot.data, date),
                                  if (dom == 1) _monthLabel('$month $year'),
                                ]));
            },
          ),
    ));
  }

  Widget _monthLabel(label) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 11),
        child: Text(
          label,
          style: TextStyle(fontSize: 24, color: Color.fromARGB(64, 0, 0, 0)),
        ),
      ),
    );
  }

  Widget _dayItem(context, activities, date) {
    var dom = date.day;
    var dateStr = DateFormat("yyyy-MM-dd").format(date);
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: EdgeInsets.all(17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(17, 0, 0, 0),
              blurRadius: 2.0,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Text('$dom',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(128, 0, 0, 0),
                )),
            Expanded(child: Container()),
            _activities(activities),
          ],
        ),
      ),
      onTap: () {
        _showDetails(context, dateStr);
      },
      behavior: HitTestBehavior.opaque,
    );
  }

  Widget _activities(List<Activity> activities) {
    return Row(
      children: <Widget>[
        for (var activity in activities)
          Padding(
            padding: EdgeInsets.only(left: 7),
            child: ActivityCircle(activity: activity),
          ),
      ],
    );
  }

  void _showDetails(BuildContext context, String date) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DateDetails(date);
    }));
  }
}
