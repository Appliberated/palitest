import 'package:flutter/material.dart';

class ResultTextWidget extends AnimatedWidget {
  const ResultTextWidget({
    super.key,
    required this.text,
    required this.color,
    required Animation<double> animation,
  }) : super(listenable: animation);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.0, color: color),
    );
  }
}
