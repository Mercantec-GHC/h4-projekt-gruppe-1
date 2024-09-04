import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
    final backgroundColor;
    final textColor;
    final double length;
    final double height;
    final String text;
    final VoidCallback? pressFunction;
    final hoverColor;

  Buttons({
    super.key,
    this.text = "test",
    this.pressFunction,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.hoverColor = Colors.grey,  
    this.length = 100.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressFunction,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        padding: WidgetStateProperty.all(EdgeInsets.all(10)),
        minimumSize: WidgetStateProperty.all(Size(length, height)),
      ),
      child: Text(text, style: TextStyle(color: textColor),),
    );
  }
}