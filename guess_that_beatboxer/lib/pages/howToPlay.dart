import 'package:flutter/material.dart';
import '../Widgets/appBar.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFunction("How to play", context),
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
          TiltUpSection(),
          SizedBox(height: 16),
          TiltDownSection(),
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
      "1. Hold the phone to the forehead: The player who has to guess holds the phone to the forehead so that the screen faces the other players.\n\n"
      "2. Start the guess: A beatboxer appears on the screen. The other players give hints or descriptions without saying the name directly.\n\n"
      "3. Guess the name: The player holding the phone tries to guess the name based on the hints.\n\n"
      "4. Next name: If the name is guessed correctly, tip the phone down to get a new name. To skip the name, tip the phone upwards.\n\n"
      "5. Time: You have a certain amount of time to guess as many names as possible. When the time is up, the correct answers are tallied.",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TiltUpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Transform.rotate(
              angle: 1.5708,
              child: Icon(
                Icons.phone_android,
                color: Colors.white,
                size: 32,
              ),
            ),
            Icon(
              Icons.arrow_downward,
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Tilt the phone down to get a new word when you guess correctly.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class TiltDownSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Transform.rotate(
              angle: -1.5708, 
              child: Icon(
                Icons.phone_android, 
                color: Colors.white,
                size: 32,
              ),
            ),
            Icon(
              Icons.arrow_upward, 
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'Tilt the phone up to skip a word.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}