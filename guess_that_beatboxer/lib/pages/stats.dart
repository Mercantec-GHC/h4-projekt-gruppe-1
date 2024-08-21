import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';


class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('../assets/logo.png',
              fit: BoxFit.contain,
              height: 42, 
            ),
            SizedBox(width: 25),
            Text('Player Stats'),
          ],
        ),
        centerTitle: true,
      ),
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

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var user = appState.user;
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
              user.userName,
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

