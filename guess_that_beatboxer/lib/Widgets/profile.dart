import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/Widgets/util/defaultProfile.dart'; 
import 'package:provider/provider.dart';
import 'dart:convert';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var indexFunction = appState.onItemTapped;
    var user = appState.user;

    Uint8List? imageBytes;
    if (user.image.isNotEmpty) {
      try {
        imageBytes = base64Decode(user.image);
      } catch (e) {
        imageBytes = null;
      }
    } else {
      imageBytes = null;
    }

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            indexFunction(2);
          },
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.black,
            child: imageBytes != null
                ? ClipOval(
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  )
                : DefaultImage(), 
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              user.userName,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}