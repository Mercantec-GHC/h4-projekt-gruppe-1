import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/models/game.dart';
import 'package:provider/provider.dart';

class CloseLobbyButton extends StatelessWidget {
final player_type;

  const CloseLobbyButton({
    Key? key,
    required this.player_type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = context.watch<Game>();
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (player_type == "host"){
          game.delete();
          }else{
            game.leaveGame();
          }

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
        },
        child: Text(
          'Close Lobby',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}