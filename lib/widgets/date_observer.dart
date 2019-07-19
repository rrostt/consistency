import 'package:flutter/material.dart';
import 'dart:async';

typedef Widget BuilderCallback(BuildContext context, DateTime date);

class DateObserver extends StatefulWidget {
  final BuilderCallback builder;

  DateObserver({this.builder});

  @override
  State<DateObserver> createState() {
    return DateObserverState();
  }
}

class DateObserverState extends State<DateObserver> {
  var date = DateTime.now();
  Timer timer;

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _stopTimer();
  }

  void _startTimer() {
    timer = Timer(Duration(seconds: 10), () {
      var now = DateTime.now();
      if (now.day != date.day) {
        setState(() {
          date = now;
        });
      }
      _startTimer();
    });
  }

  void _stopTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, date);
  }
}
