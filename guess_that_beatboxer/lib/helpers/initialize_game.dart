import 'package:guess_that_beatboxer/api/fetch_match.dart';
import 'package:guess_that_beatboxer/models/game.dart';
import '../main.dart';
import 'package:guess_that_beatboxer/api/create_match.dart';




Future<dynamic> initializeGame(player_type, game, user, {match_id = 0}) async {




  if (player_type == "host") {
    var data = await createMatch(user.jsonWebToken);
    print("object");
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
      print(data);
      if(data == "No match found"){
        throw Exception("Error: Match not found");
      }
      game.id = data["id"];
      await game.connectToGameChannel();
      while(!game.joined){
      await Future.delayed(Duration(seconds: 1));
      }
      await game.joinGame(user.userName, player_type);
      return "test";
    } catch (e) {
      
      throw Exception('Failed to load data');
    }
   
  } else{
    throw Exception("Error: Invalid player type");
    
  }
}