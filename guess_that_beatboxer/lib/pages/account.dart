import 'package:flutter/material.dart';
import '../main.dart';
import '../Widgets/profile.dart';

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