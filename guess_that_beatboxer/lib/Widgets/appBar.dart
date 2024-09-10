import 'package:flutter/material.dart';
import '../pages/howToPlay.dart';

void showHowToPlayPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: HowToPlayPageContent(),
        ),
      );
    },
  );
}

AppBar appBarFunction(String text, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 42,
        ),
        const SizedBox(width: 25),
        Text(text),
      ],
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.help_outline, color: Colors.black),
        onPressed: () {
          showHowToPlayPopup(context);
        },
      ),
    ],
  );
}
