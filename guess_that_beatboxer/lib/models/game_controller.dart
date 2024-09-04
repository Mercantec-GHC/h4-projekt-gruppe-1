import 'dart:convert';
import 'dart:math';
import 'package:guess_that_beatboxer/models/game.dart';


class GameController {
  bool myTurn;
  bool gameStarted;
  var beatBoxer; 
  List<String> usedBeatBoxer = [];
  Game game;
  String currentBeatboxer;
  int timer = 0;

  GameController({this.myTurn = false, this.gameStarted = false, this.beatBoxer, required this.game, this.currentBeatboxer = " "});




    randomBeatBoxer(){
    var random = new Random();
    var randomIndex = random.nextInt(beatBoxer.length);
    while(usedBeatBoxer.contains(beatBoxer[randomIndex]["name"])){
      randomIndex = random.nextInt(beatBoxer.length);
    }
    usedBeatBoxer.add(beatBoxer[randomIndex]["name"]);
    this.currentBeatboxer = beatBoxer[randomIndex]["name"];
  }



  void startGame(){
    game.sendMessage({"action": "start_timer"});
  }
  newRound(){
    usedBeatBoxer = [];
    randomBeatBoxer();
    this.myTurn = !this.myTurn;
    gameStarted = false;
    
  }

  void skip(id){
    game.sendMessage({"action": "skip", "host": "${game.host}", "user_id" : "$id"});
    print("skip");

  }
  void point(){
    print("point");
    randomBeatBoxer();
    game.notifyListeners();
  }

}