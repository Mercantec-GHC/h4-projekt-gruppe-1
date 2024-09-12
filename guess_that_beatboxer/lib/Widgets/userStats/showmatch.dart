import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:guess_that_beatboxer/api/fetch_user_by_id.dart';

Future<dynamic> showMatch(BuildContext context, match) async {
  final formattedDate = DateFormat.yMMMd().add_Hm().format(match.createdAt);
  var winnerUsername;
  var looserUsername;

  if (match.draw == true) {
    winnerUsername = match.player_1_user_name;
    looserUsername = match.player_2_user_name;
  } else {
    winnerUsername = await fetchUserById(int.parse(match.winner));
    looserUsername = await fetchUserById(int.parse(match.loser));
  }


  List<Map<String, dynamic>> players = [
    {
      'username': match.player_1_user_name,
      'points': match.player_1_points,
      'comment': match.player_1_comment,
    },
    {
      'username': match.player_2_user_name,
      'points': match.player_2_points,
      'comment': match.player_2_comment,
    },
  ];

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Match Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  if (match.draw == true) ...[
                    Text('Player 1: $winnerUsername', style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Player 2: $looserUsername', style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
                  ] else ...[
                    Text('Winner: $winnerUsername', style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Loser: $looserUsername', style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],

                const SizedBox(height: 16),
                ...players.map((player) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${player['username']} match info', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                      const Divider(),

                      Text('Username: ${player['username']}', style: const TextStyle(fontSize: 16)),

                      const SizedBox(height: 8),

                      Text('Points: ${player['points']}', style: const TextStyle(fontSize: 16)),

                      const SizedBox(height: 8),

                      Text('Comment: ${player['comment']}', style: const TextStyle(fontSize: 16)),

                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
                const Text('Match Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                const Divider(),

                Text('Draw: ${match.draw}', style: const TextStyle(fontSize: 16)),

                const SizedBox(height: 8),

                Text('Played At: $formattedDate', style: const TextStyle(fontSize: 16)),
                
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
          ),
        ],
      );
    },
  );
}