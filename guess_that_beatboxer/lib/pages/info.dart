import 'package:flutter/material.dart';
import '../main.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Info Page')),
      body: Center(child: Text('This is the Info Page')),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
