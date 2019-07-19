import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/big_activity_badge.dart';
import '../widgets/close_button.dart' as prefix0;

class AddActivityScreen extends StatefulWidget {
  final DateTime initialDate;

  AddActivityScreen({initialDate})
      : initialDate = initialDate ?? DateTime.now();

  @override
  State<AddActivityScreen> createState() {
    return AddActivityScreenState(initialDate);
  }
}

class AddActivityScreenState extends State<AddActivityScreen> {
  var _date = DateTime.now();

  AddActivityScreenState(initialDate) {
    _date = initialDate;
  }

  @override
  Widget build(BuildContext context) {
    var activities = [
      {"name": "run"},
      {"name": "gym"}
    ];
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _titleRow(context),
            _dateRow(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: GridView.count(
                  crossAxisCount: 4,
                  children: <Widget>[
                    for (var activity in activities)
                      BigActivityBadge(
                          activity: activity['name'],
                          onTap: () {
                            Navigator.of(context).pop({
                              'date': DateFormat("yyyy-MM-dd").format(_date),
                              'activities': activity['name'],
                            });
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 25 + MediaQuery.of(context).padding.top,
          right: 15,
          child: prefix0.CloseButton(onTap: () {
            Navigator.of(context).pop();
          }),
        ),
      ],
    ));
  }

  Widget _titleRow(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          0, 110 + MediaQuery.of(context).padding.top, 0, 0),
      child: Center(
        child: Text(
          'What did you do?',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 36),
        ),
      ),
    );
  }

  Widget _dateRow(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Text(
            DateFormat("yyyy-MM-dd").format(_date),
            style: TextStyle(
              fontSize: 28,
              color: Color.fromARGB(255, 191, 179, 255),
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(context) async {
    var date = await showDatePicker(
        context: context,
        firstDate: DateTime.utc(1982),
        lastDate: DateTime.now(),
        initialDate: DateTime.now().subtract(Duration(milliseconds: 1)));
    if (date != null) {
      setState(() {
        _date = date;
      });
    }
  }
}
