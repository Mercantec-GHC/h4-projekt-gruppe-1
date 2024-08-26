import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/pages/landing.dart';

class CloseLobbyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())); // Go back to the previous screen
        },
        child: Text('Close Lobby', style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}