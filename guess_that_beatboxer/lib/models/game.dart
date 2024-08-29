import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/api/destroy_match.dart';
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
    var gameContext;



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
    this.player_2_user_name = ""
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
    }




    Future<void> connectToGameChannel() async{
        WebSocketChannel channel  = await WebSocketChannel.connect(
            Uri.parse('ws://h4-projekt-gruppe-1-1.onrender.com/cable'),
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



    joinGame(player, type) {
        final message = {
            "command": "message",
            "identifier": jsonEncode({"channel": "GameChannel", "game_id": this.id}),
            "data": jsonEncode({"action": "join", "playerInfo":{"user_name": player, "player_type": type}}),
        };
        channel!.sink.add(jsonEncode(message));
    }

    leaveGame() {
        final message = {
            "command": "message",
            "identifier": jsonEncode({"channel": "GameChannel", "game_id": this.id}),
            "data": jsonEncode({"action": "leave"}),
        };
        channel!.sink.add(jsonEncode(message));
    }


    
    delete()
    {
          final message = {
            "command": "message",
            "identifier": jsonEncode({"channel": "GameChannel", "game_id": this.id}),
            "data": jsonEncode({"action": "delete"}),
        };
        channel!.sink.add(jsonEncode(message));

          

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
    }
}