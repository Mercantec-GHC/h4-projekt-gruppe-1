import 'package:flutter/material.dart';
import '../Widgets/appBar.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFunction("How to play"),
      backgroundColor: Colors.black,
      body: HowToPlayPageContent(),
    );
  }
}

class HowToPlayPageContent extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HowToPlaySection(),
          SizedBox(height: 16),
          VipUpSection(),
          SizedBox(height: 16),
          VipDownSection(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class HowToPlaySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "How to Play:\n"
      "1. Hold the phone to the forehead: The player who has to guess holds the phone to the forehead so that the screen faces the other players.\n"
      "2. Start the guess: A word or phrase appears on the screen. The other players give hints or descriptions without saying the word directly.\n"
      "3. Guess the Word: The player holding the phone tries to guess the word based on the hints.\n"
      "4. Next word: If the word is guessed correctly, tip the phone down to get a new word. To skip the word, tip the phone upwards.\n"
      "5. Time: You have a certain amount of time to guess as many words as possible. When the time is up, the correct answers are tallied.",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class VipUpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Tilt the phone down to get a new word when you guess correctly.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }
}

class VipDownSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Tilt the phone up to skip a word.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }
}