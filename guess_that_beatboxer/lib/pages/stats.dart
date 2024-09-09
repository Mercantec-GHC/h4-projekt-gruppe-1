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
      appBar: appBarFunction("Player stats", context),
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
          WinLoseSection(user: user),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth < 600 ? 2 : 3;

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
            GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                StatsBox(
                  title: 'Matches Played',
                  value: user.userStats.games_played.toString(),
                ),
                StatsBox(
                  title: 'Games Won',
                  value: user.userStats.wins.toString(),
                ),
                StatsBox(
                  title: 'Games Lost',
                  value: user.userStats.lost.toString(),
                ),
                StatsBox(
                  title: 'Skips',
                  value: user.userStats.skips.toString(),
                ),
                StatsBox(
                  title: 'Right guesses',
                  value: user.userStats.rightGuesses.toString(),
                ),
                StatsBox(
                  title: 'Draw',
                  value: user.userStats.draw.toString(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class WinLoseSection extends StatelessWidget {
  final user;

  const WinLoseSection({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final int gamesWon = user.userStats.wins;
    final int gamesLost = user.userStats.lost;
    final double winLoseRatio = gamesLost == 0
        ? gamesWon.toDouble()
        : gamesWon / gamesLost;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust padding based on the available width
        final padding = constraints.maxWidth < 400 ? 16.0 : 24.0;

        return Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Win/Lose Ratio',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 16),
                  Text(
                    winLoseRatio.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}