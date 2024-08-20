import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
    final backgroundColor;
    final textColor;
    final length;
    final height;
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
    this.length = 130,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressFunction,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        padding: WidgetStateProperty.all(EdgeInsets.all(10)),
        minimumSize: WidgetStateProperty.all(Size(length, height)),
      ),
      child: Text(text, style: TextStyle(color: textColor),),
    );
  }
}