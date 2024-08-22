import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:provider/provider.dart';




class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var indexFunction = appState.onItemTapped;
    var user = appState.user;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            indexFunction(2);
            print("Billedet blev klikket");
          },
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, size: 40, color: Colors.grey),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              user.userName,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
