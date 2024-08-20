import 'package:flutter/material.dart';
import '../main.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Page')),
      body: Center(child: Text('This is the Account Page')),
      // bottomNavigationBar: BottomNavigationBarExample(),
    );
  }
}