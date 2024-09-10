import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:guess_that_beatboxer/Widgets/userStats/statsCard.dart';

class PlayerStatsBar extends StatelessWidget {
  final user;

  const PlayerStatsBar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final	DateTime updated = DateTime.parse((user.userStats.updated));
    final formattedDate = DateFormat.yMMMd().add_Hm().format(updated);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top:20),
          child: const Text(
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
