import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerStatsBar extends StatelessWidget {
  final user;

  const PlayerStatsBar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final	DateTime updated = DateTime.parse((user.userStats.updated));
    print(updated);
    final formattedDate = DateFormat.yMMMd().add_Hm().format(updated);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top:20),
          child: Text(
            "Player Stats",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
        Text("Updated at $formattedDate"),
        SizedBox(
          height: 125,
          width: double.infinity,
          child: StatCards(user: user),
        ),
      ],
    );
  }
}

List<String> statCardsLabels = [
  'Matches played',
  'Wins',
  'Losses',
  'right guesses'
];

List<String> statsCardDataCall = [
  'gamesPlayed',
  'wins',
  'lost',
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
      'lost': user.userStats.lost,
      'rightGuesses': user.userStats.rightGuesses,
    };

    return Padding(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (var i = 0; i < statCardsLabels.length; i++)
              Padding(
                padding: const EdgeInsets.only(left:5),
                child: Container(
                  width: 200,
                  margin: EdgeInsets.only(top:20),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child : Padding(
                    padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statCardsLabels[i],
                          style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                            ),
                        ),
                      Text(
                        userStatsMap[statsCardDataCall[i]].toString(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       if (userStatsMap[statsCardDataCall[0]] != 0)
                      Text(
                        "${(userStatsMap[statsCardDataCall[i]] / userStatsMap[statsCardDataCall[0]] * 100).toStringAsFixed(2)}%",
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