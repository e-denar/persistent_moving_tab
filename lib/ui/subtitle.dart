import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.grey));
  }
}
