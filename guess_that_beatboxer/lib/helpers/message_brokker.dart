import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/popup.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/pages/game_over.dart';
import 'package:vibration/vibration.dart';

dynamic findData(data){
if (!isMessage(data)) {
 return null;
}
var message = data['message'];
if (!isHash(message)) {
  return null;
}
return message;

}



isHash(data){
  if (data is Map) {
    return true;
  }
  return false;
}

isMessage(data){
  return data['message'] != null;
}





handleMessage(data, game) async {

    if(data["type"] == "game_update"){
        game.updateGameData(data['game']);
      }

      if(data["type"] == "game_leave"){
        if (game.host == false){
          game.closeChannel();
          game.resetGame();
        }
      }

      if(data["type"] == "game_start"){
        game.startGame(data["beat_boxer"]);
      }

      if(data["type"] == "game_delete"){
        print(data);
        game.closeChannel();
        Navigator.pushReplacement(game.gameContext, MaterialPageRoute(builder: (context) => BottomNavBar()));
        if (!game.host){
          popup(game.gameContext, "Host has left the game");
        }
        game.resetGame();
      }
      if(data["type"] == "timer_started"){
        game.gameController.gameStarted = true;
      }
      if(data["type"] == "count_down"){
        game.gameController.timer = data["timer"];
      }
      if(data["type"] == "round_over"){
        game.gameController.timer = 0;
        game.round = (data["rounds"] as int).toDouble();
        game.gameController.newRound();
        
      }
      if(data["type"] == "game_over"){
        game.updateGameData(data['game']);
        print(data['game']);
        Navigator.pushReplacement(game.gameContext, MaterialPageRoute(builder: (context) => GameOver()));
      }

      if(data["type"] == "timer_update"){
        game.timer = data["timer"];
      }

      if(data["type"] == "half_time"){
        var hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator!) {
          if(game.gameController.myTurn){
            Vibration.vibrate();
          }
        }
      }
}