import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/userStats/showmatch.dart';

class MatchHistory extends StatelessWidget {
  final user;

  const MatchHistory({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    int winRate = 0;
    int gamesPlayedExcludingDraws = user.userStats.gamesPlayed - user.userStats.draw;
    if (gamesPlayedExcludingDraws != 0) {
      winRate = (user.userStats.wins / gamesPlayedExcludingDraws * 100).toInt();
    }
    winRate = winRate.isNaN ? 0 : winRate;

    return Container(
      margin: const EdgeInsets.only(top: 25),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(1),
            child: Text(
              "Match history",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                if (user.matchHistory.isEmpty)
                  const Center(
                    child: Text(
                      "No matches played yet",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                for (var i = 0; i < user.matchHistory.length; i++)
                  GestureDetector(
                    onTap: () {
                      showMatch(context, user.matchHistory[i]);
                    },
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          if (user.matchHistory[i].draw)
                            const Text(
                              "Draw!",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.pink,
                              ),
                            )
                          else if (user.matchHistory[i].winner == user.id.toString())
                            const Text(
                              "Win",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.green,
                              ),
                            )
                          else
                            const Text(
                              "Lose",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.red,
                              ),
                            ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              showMatch(context, user.matchHistory[i]);
                            },
                            child: const Text(
                              "View Match",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}