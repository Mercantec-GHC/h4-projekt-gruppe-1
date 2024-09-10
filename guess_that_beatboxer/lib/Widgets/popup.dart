import 'package:flutter/material.dart';

Future<dynamic> popup(BuildContext context, text) {
    return showDialog(
            
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text('Error'),
                  content: Text(text),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
        }
