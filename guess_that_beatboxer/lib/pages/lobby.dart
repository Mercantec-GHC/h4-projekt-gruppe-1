import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBarLobby.dart';
import 'package:guess_that_beatboxer/helpers/initialize_game.dart';
import 'package:guess_that_beatboxer/models/game.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import '../Widgets/closeLobby.dart';


class LobbyPage extends StatelessWidget {
  final player_type;
  final match_id;
  const LobbyPage({super.key, this.player_type, this.match_id = 0});

 
  @override
Widget build(BuildContext context) {
  if (player_type == "host") {
    return Host();
  } else if(player_type == "join") {
    return Join(match_id: match_id,); 
  } else{
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Error: Invalid player type"),
          ],
        ),
      ),
    );
  }
}
}

class Join extends StatelessWidget {
  final match_id;
  const Join({
    super.key,
    this.match_id,
  });

  @override
  Widget build(BuildContext context) {
    final game = context.read<Game>();
    final appState = context.read<MyAppState>();
    final user = appState.user;
    game.gameContext = context;
    return Scaffold(
      appBar: appBarLobbyFunction("Lobby", action: CloseLobbyButton(player_type: "join")),
      body: Center(
          child: FutureBuilder<dynamic>(
          future: initializeGame("join", game, user, match_id: match_id),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return LobbyPageContent();
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
        ),
      );
  }
}




class Host extends StatelessWidget {
  const Host({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final game = context.read<Game>();
    final appState = context.read<MyAppState>();
    final user = appState.user;
    game.gameContext = context;

    return Scaffold(
      appBar: appBarLobbyFunction("Lobby", action: CloseLobbyButton(player_type: "host",)),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: initializeGame("host", game, user),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return LobbyPageContent();
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

class LobbyPageContent extends StatefulWidget {
  const LobbyPageContent({super.key});

  @override
  _LobbyPageContentState createState() => _LobbyPageContentState();
}

class _LobbyPageContentState extends State<LobbyPageContent> {
  int selectedMinutes = 1;
  int selectedSeconds = 0; 

  @override
  Widget build(BuildContext context) {
    final game = context.watch<Game>();

    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MatchIdSection(matchId: game.id.toString()),
          SizedBox(height: 16),
          KategoriSection(),
          SizedBox(height: 16),
          SpilTidSection(
            selectedMinutes: selectedMinutes,
            selectedSeconds: selectedSeconds,
            onMinutesChanged: (int minutes) {
              setState(() {
                selectedMinutes = minutes;
              });
            },
            onSecondsChanged: (int seconds) {
              setState(() {
                selectedSeconds = seconds;
              });
            },
          ),
          SizedBox(height: 16),
          PlayerSection(),
          SizedBox(height: 16),
          StartSection(
            minutes: selectedMinutes,
            seconds: selectedSeconds,
          ),
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

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/beatbox.png'), // Replace with actual image path
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
  final int selectedMinutes;
  final int selectedSeconds;
  final ValueChanged<int> onMinutesChanged;
  final ValueChanged<int> onSecondsChanged;

  SpilTidSection({
    required this.selectedMinutes,
    required this.selectedSeconds,
    required this.onMinutesChanged,
    required this.onSecondsChanged,
  });

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
            TimeSelector(
              title: "Minutes",
              defaultValue: selectedMinutes,
              maxValue: 4,
              onChanged: onMinutesChanged,
            ),
            SizedBox(width: 8),
            Text(
              ":",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            TimeSelector(
              title: "Seconds",
              defaultValue: selectedSeconds,
              maxValue: 60,
              onChanged: onSecondsChanged,
            ),
          ],
        ),
      ],
    );
  }
}

class TimeSelector extends StatefulWidget {
  final String title;
  final int defaultValue;
  final int maxValue;
  final ValueChanged<int> onChanged;  

  TimeSelector({
    required this.title,
    required this.defaultValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  int? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          child: DropdownButton<int>(
            value: _selectedValue,
            items: List.generate(
              widget.maxValue,
              (index) => DropdownMenuItem(
                value: index,
                child: Text(index.toString().padLeft(2, '0')),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
                if (value != null) {
                  widget.onChanged(value);  
                }
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
  @override
  Widget build(BuildContext context) {
    final game = context.watch<Game>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Players",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(  
                    child: Text(
                      game.player_1_user_name,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      game.player_2_user_name,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class StartSection extends StatelessWidget {
  final int minutes;
  final int seconds;

  StartSection({required this.minutes, required this.seconds});

  @override
  Widget build(BuildContext context) {
    var game = context.watch<Game>();
    int totalseconds = (minutes * 60) + seconds;

    return Center(
      child: ElevatedButton(
        onPressed: () {
          game.initGame(totalseconds);
        },
        child: Text("Start game", style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}