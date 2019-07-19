import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  final VoidCallback onTap;

  CloseButton({@required this.onTap});

  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 216, 216, 216)),
          child: Icon(Icons.close, color: Colors.white),
        ),
        onTap: onTap);
  }
}
