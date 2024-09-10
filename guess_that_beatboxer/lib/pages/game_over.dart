import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_that_beatboxer/Widgets/buttons.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/models/game.dart';
import 'package:provider/provider.dart';


class GameOver extends StatefulWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var game = context.read<Game>();
    var appState = context.read<MyAppState>();
    var user = appState.user;


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${game.player_1_user_name}: ${game.player_1_points}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
                Text(
                  "${game.player_2_user_name}: ${game.player_2_points}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Center(
              child: game.draw
                  ? Text(
                      "It's a draw!",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                      ),
                    )
                  : game.winner == user.userName
                      ? Text(
                          "You win!",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.09,
                          ),
                        )
                      : Text(
                          "You lose!",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0), // Tilføj lidt polstring
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          labelText: "Leave a comment",
                          hintText: "Comment",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Buttons(
                    pressFunction: () async {
                      await game.sendComment(_commentController.text);
                      appState.updateRecentMatches();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()));

                    },
                    text: "Submit",
                    length: MediaQuery.of(context).size.width * 0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
