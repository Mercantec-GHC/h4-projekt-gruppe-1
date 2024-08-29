import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/api/fetch_beatboxer.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:provider/provider.dart';
import 'package:guess_that_beatboxer/api/fetch_beatboxer.dart';
import 'package:guess_that_beatboxer/models/game_stats.dart';

class GamePage extends StatefulWidget {

  @override
  State<GamePage> createState() => _GamePageState();

}


class _GamePageState extends State<GamePage> {




  @override
 Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: FutureBuilder<String>(
        future: fetchBeatboxer(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return gameController(snapshot.data);
          } else {
            return Text('No data available');
          }
        },
      ),
    ),
  );
}
}


class gameController extends StatelessWidget {
  bool ready = false;
  var gameStats;
  gameController(data) {
    gameStats = GameStats(beat_boxer_string: data);
    gameStats.beatBoxerToJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.blue,
      child: Center(
        child: PlayerOne(gameStats),
      ),
    );
  }
  
}

class PlayerOne extends StatelessWidget {
  GameStats gameStats;

  PlayerOne(this.gameStats);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Player 1: 10", style: TextStyle(color: Colors.white)),
              Text("Player 2: 5", style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.20),
          Center( 
            child: Text(gameStats.beat_boxer_list[0]["name"], style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.1)),
          ),
        ],
      ),
    );
  }
}

class PlayerTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.blue,
      child: Center(
        child: Text('Player Two'),
      ),
    );
  }
}