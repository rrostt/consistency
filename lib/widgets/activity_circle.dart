import 'package:flutter/material.dart';
import '../model/model.dart';

class ActivityCircle extends StatelessWidget {
  final Activity activity;
  final double size;
  ActivityCircle({@required this.activity, this.size = 28});
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _color(),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(64, 0, 0, 0),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          )
        ],
      ),
    );
  }

  Color _color() {
    switch (activity.name) {
      case 'run':
        return Color.fromARGB(255, 248, 231, 28);
      case 'gym':
        return Color.fromARGB(255, 126, 211, 33);
      default:
        return Color.fromARGB(255, 155, 155, 155);
    }
  }
}
