import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBar.dart';
import 'package:guess_that_beatboxer/Widgets/playerFeedback.dart';
import 'package:guess_that_beatboxer/Widgets/popup.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../Widgets/profile.dart';
import 'package:guess_that_beatboxer/pages/lobby.dart';





class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarFunction("Landing page", context),  
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
          JoinLobbyButton(),
          SizedBox(height: 16),
          PlayerFeedback(user: user),
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

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LobbyPage(player_type: "host"),
            ),
          );
        },
        child: Text(
          'Create Lobby',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

class JoinLobbyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController matchIdController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: matchIdController,
          decoration: InputDecoration(
            labelText: 'Enter Match ID',
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (matchIdController.text.isEmpty) {
              popup(context, "Please enter a match ID");
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LobbyPage(player_type: "join", match_id: matchIdController.text),
              ),
            );
          },
          child: Text('Join Lobby', style: TextStyle(color: Colors.white),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
        ),
      ],
    );
  }
}


