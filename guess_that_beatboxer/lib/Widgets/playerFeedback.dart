import 'package:flutter/material.dart';
import '../models/user.dart';

class MatchTile extends StatelessWidget {
  final int matchNumber;
  final String player1;
  final String player1Feedback;
  final String player2;
  final String player2Feedback;

  MatchTile({
    required this.matchNumber,
    required this.player1,
    required this.player1Feedback,
    required this.player2,
    required this.player2Feedback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Match $matchNumber",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Player 1: $player1",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Comment: $player1Feedback"),
            SizedBox(height: 8),
            Text(
              "Player 2: $player2",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Comment: $player2Feedback"),
          ],
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
                  matchNumber: index + 1,
                  player1: match.player_1_user_name,
                  player1Feedback: match.player_1_comment,
                  player2: match.player_2_user_name,
                  player2Feedback: match.player_2_comment,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}