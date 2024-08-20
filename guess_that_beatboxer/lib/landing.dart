import 'package:flutter/material.dart';
import 'main.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/logo.png',
              fit: BoxFit.contain,
              height: 42, // Adjust the height as needed
            ),
            SizedBox(width: 25),
            Text('Guess That Beatboxer'),
          ],
        ),
        centerTitle: true,
      ),
      body: HomePageContent(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileSection(),
          SizedBox(height: 16),
          StatsSection(),
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
class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.person, size: 40, color: Colors.grey),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Player name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Nickname',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
class StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.games),
            title: Text('Total Games Played'),
            trailing: Text('25'),
          ),
          ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text('Games Won'),
            trailing: Text('18'),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Games Lost'),
            trailing: Text('7'),
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
        onPressed: () {},
        child: Text('Create Lobby'),
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
            child: Text('Join game'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
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
