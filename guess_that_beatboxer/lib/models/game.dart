import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/popup.dart';
import 'package:guess_that_beatboxer/models/game_controller.dart';
import 'package:guess_that_beatboxer/pages/game.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:guess_that_beatboxer/helpers/message_brokker.dart';

class Game extends ChangeNotifier {
    int id; 
    String winner;
    String loser;
    int player_1_points;
    int player_2_points;
    bool draw;
    String player_1_comment;
    String player_2_comment;
    String player_1_user_name;
    String player_2_user_name;
    WebSocketChannel? channel;
    bool joined = false;
    bool host = false;
    late BuildContext gameContext;
    late GameController gameController;
    double round = 1.0;
    int timer = 60;

    Game({
    this.id = 0, 
    this.winner = " ", 
    this.loser = " ", 
    this.player_1_points = 0, 
    this.player_2_points = 0, 
    this.draw = false, 
    this.player_1_comment = "", 
    this.player_2_comment = "",
    this.player_1_user_name = "",
    this.player_2_user_name = "",
    });

    updateGameData(data){
        this.id = data['id'];
        this.winner = data['winner'];
        this.loser = data['loser'];
        this.player_1_points = data['player_1_points'];
        this.player_2_points = data['player_2_points'];
        this.draw = data['draw'];
        this.player_1_comment = data['player_1_comment'];
        this.player_2_comment = data['player_2_comment'];
        this.player_1_user_name = data['player_1_user_name'];
        this.player_2_user_name = data['player_2_user_name'];
        this.timer = data['timer'];

    }

    Future<void> connectToGameChannel() async{
        WebSocketChannel channel  = await WebSocketChannel.connect(
            Uri.parse('wss://kim.magsapi.com/cable'),
        );
        final identifier = jsonEncode({"channel": "GameChannel", "game_id": this.id});
        channel.sink.add(jsonEncode({"command": "subscribe", "identifier": identifier}));
    
        this.channel = channel;
    
        await channel.stream.listen((message) {
            final data = jsonDecode(message);
            
            if (data['type'] == 'confirm_subscription') {
              this.joined = true;
            }
            var mapData = findData(data);

            if (mapData != null) {
              handleMessage(mapData, this);
              notifyListeners();
            }


        });
    
    }
  
    closeChannel() {
        if (this.channel != null) {
            this.channel!.sink.close(1000);
        }
    }

    joinGame(player, type, userId) {
        sendMessage({"action": "join", "playerInfo":{"user_name": player, "player_type": type, "user_id": userId}});
    }

    leaveGame() {
        sendMessage({"action": "leave"});
    }
    
    delete()
    {
      sendMessage({"action": "delete"});
    }

    initGame(time){
        if(this.host){
          if(this.player_2_user_name == " "){
            popup(this.gameContext, "Waiting for player to join");
          }
          else{

            sendMessage({"action": "start", "timer": time});
        };

        }

      }
    

  

    startGame(beatBoxerList) {

      this.gameController = GameController(myTurn: this.host, beatBoxer: beatBoxerList, game: this);
      this.gameController.randomBeatBoxer();
     Navigator.pushReplacement(this.gameContext, MaterialPageRoute(builder: (context) => GamePage()));

    }

    resetGame(){
        this.winner = " ";
        this.loser = " ";
        this.player_1_points = 0;
        this.player_2_points = 0;
        this.draw = false;
        this.player_1_comment = "";
        this.player_2_comment = "";
        this.player_1_user_name = "";
        this.player_2_user_name = "";
        this.joined = false;
        this.host = false;
        this.round = 1.0;
        this.timer = 60;
    }


Future<void> sendMessage(message) async {
  final jsonMessage = {
    "command": "message",
    "identifier": jsonEncode({"channel": "GameChannel", "game_id": this.id}),
    "data": jsonEncode(message),
  };
  channel!.sink.add(jsonEncode(jsonMessage));
}

Future<void> sendComment(comment) async {
  await sendMessage({"action": "comment", "comment": comment, "host": this.host});
  await Future.delayed(Duration(milliseconds: 200));
  
  this.closeChannel();
  this.resetGame();
}
    @override
  void notifyListeners() {
    super.notifyListeners();
  }


 
}