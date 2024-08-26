import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBar.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../Widgets/profile.dart';
import 'package:guess_that_beatboxer/pages/lobby.dart';





class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarFunction("Landing page"),  
      body: HomePageContent(),

    );
  }
}

class HomePageContent extends StatelessWidget {
  final indexFunction;

  const HomePageContent({super.key, this.indexFunction});

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
          CreateLobbyButton(),
          SizedBox(height: 16),
          RecentGamesSection(),
          SizedBox(height: 16),
          NearbyPlayersSection(),
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

class CreateLobbyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LobbyPage()));
        },
        child: Text('Create Lobby', style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

class RecentGamesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Games',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: RecentGameTile(player: 'Player 2', feedback: 'Great beatboxing session!')),
            SizedBox(width: 8),
            Expanded(child: RecentGameTile(player: 'Player 4', feedback: 'Fun and competitive')),
          ],
        ),
      ],
    );
  }
}

class RecentGameTile extends StatelessWidget {
  final String player;
  final String feedback;

  RecentGameTile({required this.player, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              player,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(feedback),
          ],
        ),
      ),
    );
  }
}

class NearbyPlayersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Players',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: NearbyPlayerTile(player: 'Player 3')),
            SizedBox(width: 8),
            Expanded(child: NearbyPlayerTile(player: 'Player 5')),
          ],
        ),
        SizedBox(height: 8),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Join game', style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class NearbyPlayerTile extends StatelessWidget {
  final String player;

  NearbyPlayerTile({required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(player),
      ),
    );
  }
}
