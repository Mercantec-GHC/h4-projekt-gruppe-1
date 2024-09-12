
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/models/game.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GamePage extends StatelessWidget{

 GamePage();

  @override
 Widget build(BuildContext context) {
  context.read<Game>().gameContext = context;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  return Scaffold(
    body: Center(
      child: gameController()
        

      ),
    );
  }
}

class gameController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  var game = context.watch<Game>();
  
    final user = context.watch<MyAppState>().user;
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.blue,
      child: Center( 
      
        child: game.gameController.myTurn ? PlayerOne(game, user) : PlayerTwo(game.gameController.gameStarted),
      ),
    );
  }
  
}

class PlayerOne extends StatefulWidget {
  final game;
  final user;
  PlayerOne(this.game, this.user);

  @override
  State<PlayerOne> createState() => _PlayerOneState(game, user);
  var stream; 
}

class _PlayerOneState extends State<PlayerOne> {
  final game;
  final user;
  _PlayerOneState(this.game, this.user);
    DateTime? lastPrintedTime ;
    StreamSubscription<AccelerometerEvent>? stream; 

    @override
    initState() {
      super.initState();
        stream = accelerometerEventStream(samplingPeriod: Duration(milliseconds: 150)).listen((AccelerometerEvent event) {
          final currentTime = DateTime.now();
          if (game.gameController.gameStarted) {            
            if (lastPrintedTime == null || currentTime.difference(lastPrintedTime!).inSeconds >= 1) {
              if (event.z > 6.0) {
                lastPrintedTime = currentTime;
                game.gameController.skip(user.id);
              }
              if (event.z < -6.0) {
                lastPrintedTime = currentTime;
                game.gameController.point(user.id);
              }
            }
          }
        });
    }

    @override
    dispose() {
      super.dispose();
        if (stream != null) {
        stream!.cancel();
        }
    }

  @override
  Widget build(BuildContext context) {
    var game = context.read<Game>();
    return Container(
      constraints: BoxConstraints.expand(),
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${game.player_1_user_name} : ${game.player_1_points}", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05)),
              Text("Round: ${(game.round / 2).ceil()}", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.04)),
              Text("${game.player_2_user_name} :${game.player_2_points}", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.20),
          game.gameController.gameStarted?
          Center( 
            child: Text(game.gameController.currentBeatboxer ?? 'Unknown Beatboxer', style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.06)),
          )
          :
          Center(child: Text("Place this on your forehead", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.06),)
          )
        ],
      ),
    );
  }
}



class PlayerTwo extends StatelessWidget {
  var gameStated = false;
  PlayerTwo(this.gameStated);

  String  timerText(timer) {
    int minutes = timer ~/ 60;
    int seconds = timer % 60;
    String minuteStr = minutes.toString().padLeft(2, '0');
    String secondStr = seconds.toString().padLeft(2, '0');
    return "$minuteStr:$secondStr";
  }

  @override
  Widget build(BuildContext context) {
    var game = context.read<Game>();
    return Container(
      constraints: BoxConstraints.expand(),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${game.player_1_user_name} : ${game.player_1_points}", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.05)),
          Text("Round: ${(game.round / 2).ceil()}", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.04)),
          Text("${game.player_2_user_name} : ${game.player_2_points}", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.05)),
        ],
        ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.20),
        game.gameController.gameStarted?  
        Center(child: Text(timerText(game.gameController.timer), style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.1))
        ,)
        :
        Center(
          child:ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(10),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.3),
            ),
          onPressed: (){
            game.gameController.startGame();
          },
          child: Text("Start Game", style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05)),
        ),
          )
        ],
      ) 
    );
  }
}