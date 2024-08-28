import 'package:flutter/material.dart';

class ChangeUsername extends StatelessWidget {
  final user;

  ChangeUsername({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "change",
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "change username",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}