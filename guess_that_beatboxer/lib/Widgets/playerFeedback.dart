import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/match_history.dart'; 

class MatchTile extends StatelessWidget {
  final MatchHistory match;

  MatchTile({required this.match});

  void showMatchDetailsDialog(BuildContext context) {
    final formattedDate = "${match.createdAt.day}/${match.createdAt.month}/${match.createdAt.year}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Match Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Winner: ${match.winner}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Loser: ${match.loser}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${match.player_1_user_name} match info',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Username: ${match.player_1_user_name}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Points: ${match.player_1_points}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comment: ${match.player_1_comment}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${match.player_2_user_name} match info',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Username: ${match.player_2_user_name}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Points: ${match.player_2_points}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Comment: ${match.player_2_comment}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Match Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Draw: ${match.draw ? "Yes" : "No"}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Played At: $formattedDate',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<MyAppState>().user;
    return GestureDetector(
      onTap: () => showMatchDetailsDialog(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Match ${match.createdAt.day}/${match.createdAt.month}/${match.createdAt.year}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                match.draw
                    ? "The match ended in a draw"
                    : int.parse(match.winner) == user.id
                        ? "You won the match"
                        : "You lost the match", 
                style: TextStyle(
                  color: match.draw ? const Color.fromARGB(255, 0, 0, 0) : int.parse(match.winner) == user.id? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Player 1: ${match.player_1_user_name}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text("Comment: ${match.player_1_comment}"),
              SizedBox(height: 8),
              Text(
                "Player 2: ${match.player_2_user_name}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text("Comment: ${match.player_2_comment}"),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerFeedback extends StatelessWidget {
  final User user;

  PlayerFeedback({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    user.matchHistory.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final recentMatches = user.matchHistory.take(3).toList();
    return Container(
      margin: EdgeInsets.only(top: 25),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(1),
            child: Text(
              "Recent games",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: recentMatches.length,
              itemBuilder: (context, index) {
                final match = recentMatches[index];
                return MatchTile(
                  match: match,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}