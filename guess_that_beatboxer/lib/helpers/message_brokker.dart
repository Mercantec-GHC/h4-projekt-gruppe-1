import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';

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





handleMessage(data, game){


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
        game.closeChannel();
        game.resetGame();
        Navigator.pushReplacement(game.gameContext, MaterialPageRoute(builder: (context) => BottomNavBar()));
      }
      if(data["type"] == "timer_started"){
        game.gameController.gameStarted = true;
      }
      if(data["type"] == "count_down"){
        game.gameController.timer = data["timer"];
      }
      if(data["type"] == "round_over"){
        game.gameController.timer = 0;
        game.gameController.newRound();
        
      }

}