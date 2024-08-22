import 'package:flutter/material.dart';
import '../main.dart';
import '../Widgets/profile.dart';
import 'package:provider/provider.dart';
import '../Widgets/appBar.dart';


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
    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSection(),
          SizedBox(height: 16),
          //StatsSection(),
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
    var appState = context.watch<MyAppState>();
    var indexFunction = appState.onItemTapped;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stats',
                  style: Theme.of(context).textTheme.headlineSmall, 
                ),
                ElevatedButton(
                  onPressed: () {
                    indexFunction(1);
                  },
                  child: Text('All stats', style: TextStyle(color: Colors.white),), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.games),
            title: Text('Total Games Played'),
            trailing: Text(user.userStats.gamesPlayed.toString()),
          ),
          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text('Games Won'),
            trailing: Text(user.userStats.wins.toString()),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Games Lost'),
            trailing: Text(user.userStats.lost.toString()),
          ),
        ],
      ),
    );
  }
}
