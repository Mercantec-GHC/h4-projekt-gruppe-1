import 'package:flutter/material.dart';
import '../main.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stats Page')),
      body: Center(child: Text('This is the stats Page')),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}