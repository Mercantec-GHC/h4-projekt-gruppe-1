import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBarLobby.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import '../Widgets/closeLobby.dart';


class LobbyPage extends StatefulWidget {
  final String matchId;

  const LobbyPage({super.key, required this.matchId});

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  List<String> players = [];

  void addPlayer(String playerName) {
    if (!players.contains(playerName)) {
      setState(() {
        players.add(playerName);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You are already in the lobby!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLobbyFunction("Lobby", action: CloseLobbyButton()),
      body: LobbyPageContent(
        matchId: widget.matchId,
        players: players,
        addPlayer: addPlayer,
      ),
    );
  }
}

class LobbyPageContent extends StatelessWidget {
  final String matchId;  // Add matchId here
  final List<String> players;
  final Function(String) addPlayer;

  const LobbyPageContent({
    super.key,
    required this.matchId,  // Make sure matchId is required
    required this.players,
    required this.addPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final user = appState.user;

    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MatchIdSection(matchId: matchId),
          SizedBox(height: 16),
          KategoriSection(),
          SizedBox(height: 16),
          SpilTidSection(),
          SizedBox(height: 16),
          PlayerSection(players: players),
          SizedBox(height: 16),
          JoinSection(
            addPlayer: addPlayer,
            userName: user?.userName,
          ),
          SizedBox(height: 16),
          StartSection(),
        ],
      ),
    );
  }
}

class MatchIdSection extends StatelessWidget {
  final String matchId;

  MatchIdSection({required this.matchId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Match ID',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          matchId,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class KategoriSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4, // Number of categories
      itemBuilder: (context, index) {
        return CategoryCard(title: getTitle(index));
      },
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Solo";
      case 1:
        return "Coming soon";
      case 2:
        return "Coming soon";
      case 3:
        return "Coming soon";
      default:
        return "";
    }
  }
}

class CategoryCard extends StatelessWidget {
  final String title;

  CategoryCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle selection logic here
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('../assets/beatbox.png'), // Replace with actual image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

class SpilTidSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Change time per round",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeSelector(title: "Minutes"),
            SizedBox(width: 8,),
            Text(
              ":",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8,),
            TimeSelector(title: "Seconds"),
          ],
        ),
      ],
    );
  }
}

class TimeSelector extends StatefulWidget {
  final String title;

  TimeSelector({required this.title});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          child: DropdownButton<int>(
            value: _selectedValue,
            items: List.generate(
              60,
              (index) => DropdownMenuItem(
                value: index,
                child: Text(index.toString().padLeft(2, '0')),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
              });
            },
          ),
        ),
        Text(widget.title),
      ],
    );
  }
}

class PlayerSection extends StatelessWidget {
  final List<String> players;

  PlayerSection({required this.players});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Players",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...players.map((playerName) => PlayerCard(playerName: playerName)).toList(),
      ],
    );
  }
}

class PlayerCard extends StatelessWidget {
  final String playerName;

  PlayerCard({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(width: 10),
          Text(playerName),
        ],
      ),
    );
  }
}

class JoinSection extends StatelessWidget {
  final Function(String) addPlayer;
  final String? userName;

  JoinSection({required this.addPlayer, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (userName != null) {
            addPlayer(userName!);
          }
        },
        child: Text("Join Lobby", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

class StartSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle start game logic
        },
        child: Text("Start game", style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}