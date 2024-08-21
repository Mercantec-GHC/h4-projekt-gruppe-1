import 'package:flutter/material.dart';


class AccountPage extends StatelessWidget {
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
            Text('Player Profile'),
          ],
        ),
        centerTitle: true,
      ),
      body: AccountPageContent(),
    );
  }
}

class AccountPageContent extends StatelessWidget {
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