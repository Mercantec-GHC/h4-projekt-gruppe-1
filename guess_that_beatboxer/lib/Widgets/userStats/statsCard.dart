import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> statCardsLabels = [
  'Matches played',
  'Wins',
  'Losses',
  'Draws',
  'Right guesses'
];

List<String> statsCardDataCall = [
  'gamesPlayed',
  'wins',
  'losses',
  'draw',
  'rightGuesses'
];

class StatCards extends StatelessWidget {
  final user;

  const StatCards({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userStatsMap = {
      'gamesPlayed': user.userStats.gamesPlayed,
      'wins': user.userStats.wins,
      'losses': user.userStats.lost, 
      'rightGuesses': user.userStats.rightGuesses,
      'draw': user.userStats.draw,
    };

    return Padding(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (var i = 0; i < statCardsLabels.length; i++)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statCardsLabels[i],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          userStatsMap[statsCardDataCall[i]].toString(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (userStatsMap['gamesPlayed'] != 0 && statsCardDataCall[i] != 'gamesPlayed')
                          Text(
                            "${(userStatsMap[statsCardDataCall[i]] / userStatsMap['gamesPlayed'] * 100).toStringAsFixed(0)}%",
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}