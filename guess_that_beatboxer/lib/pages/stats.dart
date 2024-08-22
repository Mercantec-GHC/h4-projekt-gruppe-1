import 'package:flutter/material.dart';
import '../main.dart';
import '../Widgets/profile.dart';
import 'package:provider/provider.dart';
import '../Widgets/appBar.dart';
import '../Widgets/statsBox.dart';


class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFunction("Player stats"),
      body: StatsPageContent(),
    );
  }
}

class StatsPageContent extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final user = appState.user;
    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSection(),
          SizedBox(height: 16),
          StatsSection(user: user),
          SizedBox(height: 16),
          //WinLoseSection(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  final user;

  const StatsSection({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text(
              'Stats',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1, // 1:1 aspect ratio for a square box
                child: StatsBox(
                  title: 'Matches Played',
                  value: user.userStats.gamesPlayed.toString(),
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: StatsBox(
                  title: 'Games Won',
                  value: user.userStats.wins.toString(),
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: StatsBox(
                  title: 'Games Lost',
                  value: user.userStats.lost.toString(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: StatsBox(
                  title: 'Skips',
                  value: user.userStats.skips.toString(),
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: StatsBox(
                  title: 'Right guesses',
                  value: user.userStats.rightGuesses.toString(),
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: StatsBox(
                  title: 'Right guesses',
                  value: user.userStats.rightGuesses.toString(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}