import 'package:flutter/material.dart';

class BigActivityBadge extends StatelessWidget {
  final String activity;
  final VoidCallback onTap;
  final bool enabled;
  BigActivityBadge(
      {@required this.activity, @required this.onTap, this.enabled = true});

  final Color _disabledColor = Color.fromARGB(128255, 196, 196, 196);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: enabled ? _color() : _disabledColor,
                boxShadow: [
                  if (enabled)
                    BoxShadow(
                      color: Color.fromARGB(18, 0, 0, 0),
                      blurRadius: 2.0,
                      offset: Offset(0, 2),
                    )
                ],
              ),
              child: Icon(_iconForActivity(activity),
                  size: 36, color: Color.fromARGB(255, 60, 60, 60)),
            ),
          ),
          Center(
            child: Text(
              activity,
              style: TextStyle(color: Color.fromARGB(81, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }

  Color _color() {
    switch (activity) {
      case 'run':
        return Color.fromARGB(255, 248, 231, 28);
      case 'gym':
        return Color.fromARGB(255, 126, 211, 33);
      default:
        return Color.fromARGB(255, 155, 155, 155);
    }
  }

  IconData _iconForActivity(String name) {
    switch (name) {
      case 'run':
        return Icons.directions_run;
      case 'gym':
        return Icons.fitness_center;
      default:
        return Icons.gesture;
    }
  }
}
