import 'package:flutter/material.dart';

bool validateFields(BuildContext context, List<TextEditingController> controllers) {
  if (controllers[0].text.isEmpty) {
    showErrorDialog(context, 'Du skal have et navn');
    return false;
  }
  if (controllers[1].text.isEmpty) {
    showErrorDialog(context, 'Du skal vælge et username');
    return false;
  }
  if (controllers[2].text.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(controllers[2].text)) {
    showErrorDialog(context, 'Skriv en gyldig email');
    return false;
  }
  if (controllers[3].text.isEmpty) {
    showErrorDialog(context, 'Du skal have et telefonnummer');
    return false;
  }
  if (controllers[4].text.isEmpty) {
    showErrorDialog(context, 'Du skal vælge et password');
    return false;
  }
  if (controllers[5].text != controllers[4].text) {
    showErrorDialog(context, 'Passwords matcher ikke');
    return false;
  }
  return true;
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}