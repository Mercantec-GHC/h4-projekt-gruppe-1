import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBarLobby.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import '../Widgets/closeLobby.dart';


class LobbyPage extends StatelessWidget {
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLobbyFunction("Lobby", action: CloseLobbyButton()),
      body: LobbyPageContent(), 
    );
  }
}


class LobbyPageContent extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final user = appState.user;
    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KategoriSection(),
          SizedBox(height: 16),
          SpilTidSection(),
          SizedBox(height: 16),
          PlayerSection(user: user),
          SizedBox(height: 16),
          StartSection(),
        ],
      ),
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
  final user;

  const PlayerSection({super.key, this.user});

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
        user != null
            ? PlayerCard(playerName: user.userName)
            : Text('Loading...'),
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