import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/popup.dart';
import 'package:guess_that_beatboxer/api/fetch_match.dart';
import 'package:guess_that_beatboxer/models/game.dart';
import '../main.dart';
import 'package:guess_that_beatboxer/api/create_match.dart';




Future<dynamic> initializeGame(player_type, game, user, {match_id = 0}) async {




  if (player_type == "host") {
    var data = await createMatch(user.jsonWebToken);
    game.id = data["id"];
    game.host = true;
    await game.connectToGameChannel();
    while(!game.joined){
      await Future.delayed(Duration(seconds: 1));
    }
    await game.joinGame(user.userName, player_type);
    return "test";

    
  } else if(player_type == "join") {
    try {
      var data = await fetchMatch(user.jsonWebToken, match_id);
      if(data == "No match found"){
        Navigator.pushReplacement(game.gameContext, MaterialPageRoute(builder: (context) => BottomNavBar()));
        popup(game.gameContext, "Match not found");
      }else if (data["player_2_user_name"] != " "){
        Navigator.pushReplacement(game.gameContext, MaterialPageRoute(builder: (context) => BottomNavBar()));
        popup(game.gameContext, "Match is full");
      }else{
        
        game.id = data["id"];
        await game.connectToGameChannel();
        while(!game.joined){
        await Future.delayed(Duration(seconds: 1));
        }
        await game.joinGame(user.userName, player_type);
        return "test";
      }
    } catch (e) {
      
      throw Exception(e);
    }
   
  } else{
    throw Exception("Error: Invalid player type");
    
  }
}