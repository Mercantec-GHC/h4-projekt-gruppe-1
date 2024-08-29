import 'dart:convert';



class GameStats {
  var beat_boxer_string;
  var beat_boxer_list;
  var player1Score;
  var player2Score;
  var playerTurn;

  GameStats({this.beat_boxer_string, this.player1Score = 0, this.player2Score = 0});

  

 beatBoxerToJson(){
    beat_boxer_list = JsonDecoder().convert(beat_boxer_string);
 }

}