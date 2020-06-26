import 'package:flutter/material.dart';

class CurrentHomeLabel extends StatelessWidget {
  final String label;
  final Color color;
  final double fontSize;
  CurrentHomeLabel({
    @required this.label, 
    @required this.color, 
    @required this.fontSize
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        color: this.color,
      ),
    );
  }
}