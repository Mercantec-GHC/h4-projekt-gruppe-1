import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var indexFunction = appState.onItemTapped;
    var user = appState.user;

    Uint8List? imageBytes;
    try {
      imageBytes = base64Decode(user.image);
    } catch (e) {
      print('Error decoding base64 string: $e');
      imageBytes = null;
    }

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
            child: ClipOval(
              child: imageBytes != null
                  ? Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    )
                  : Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey.shade700,
                    ),
            ),
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