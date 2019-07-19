import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'model/model.dart';
import 'screens/activity_list.dart';
import 'screens/activity_calendar_round.dart';
import 'screens/activity_calendar.dart';

void main() async {
  MyModel model = MyModel();
  await model.init();
  runApp(ScopedModel<MyModel>(model: model, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 230, 230, 230),
            body: TabBarView(
              children: <Widget>[
                ActivityList(),
                ActivityCalendarRound(),
                ActivityCalendar()
              ],
            )),
      ),
    );
  }
}
