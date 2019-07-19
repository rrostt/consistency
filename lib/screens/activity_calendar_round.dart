import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/activity_circle.dart';
import '../widgets/date_observer.dart';
import '../model/model.dart';
import 'date_details.dart';

class ActivityCalendarRound extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 236, 238),
        body: DateObserver(
          builder: (context, now) => Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
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
                  child: ScopedModelDescendant<MyModel>(
                    builder: (context, child, model) => FutureBuilder(
                      future: model.getForDate(dateStr),
                      initialData: <Activity>[],
                      builder: (context, snapshot) => _DayWidget(
                        children: snapshot.data
                            .map<Widget>((activity) =>
                                ActivityCircle(activity: activity, size: 12))
                            .toList(),
                        color: dayoffset >= 0
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(128, 255, 255, 255),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  void _showDetails(BuildContext context, String date) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DateDetails(date);
    }));
  }
}

class _DayWidget extends StatelessWidget {
  final List<Widget> children;
  final Color color;

  _DayWidget({this.children, this.color});

  Widget build(BuildContext context) {
    var layoutChildren = children
        .asMap()
        .map((i, child) => MapEntry(i, LayoutId(id: '$i', child: child)))
        .values
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.all(1.5),
      child: CustomMultiChildLayout(
        delegate: _DayWidgetLayoutDelegate(numItems: children.length),
        children: layoutChildren,
      ),
    );
  }
}

class _DayWidgetLayoutDelegate extends MultiChildLayoutDelegate {
  final int numItems;
  _DayWidgetLayoutDelegate({@required this.numItems});

  @override
  void performLayout(Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = numItems > 1 ? 8 : 0; //size.width / 4;

    for (var i = 0; i < numItems; i++) {
      Size childSize = layoutChild('$i', BoxConstraints.loose(size));

      double angle = i * Math.pi * 2 / numItems;
      positionChild(
        '$i',
        Offset(center.dx - childSize.width / 2 + radius * Math.cos(angle),
            center.dy - childSize.height / 2 + radius * Math.sin(angle)),
      );
    }
  }

  @override
  bool shouldRelayout(_DayWidgetLayoutDelegate oldDelegate) =>
      oldDelegate.numItems != numItems;
}
