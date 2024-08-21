import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/landing.dart';
import 'pages/info.dart';
//import 'pages/lobby.dart';
import 'pages/account.dart';
import 'pages/stats.dart';
//import 'pages/register.dart';
//import 'pages/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BottomNavBar(),
    ),
    );
  }
}


class MyAppState extends ChangeNotifier {
      int selectedIndex = 0;

  void _onItemTapped(int index) {
      selectedIndex = index;
      notifyListeners();

  }

}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() =>
      _BottomNavBarState();
}

class _BottomNavBarState
    extends State<BottomNavBar> {
      

  @override
  Widget build(BuildContext context) {
      var appState = context.watch<MyAppState>();
      var selectedIndex = appState.selectedIndex;
      void _onItemTapped(int index) {
        appState._onItemTapped(index);
      }
  final themeColor = Theme.of(context).primaryColor;
    Widget page;
      switch (selectedIndex) {
        case 0:
          page = HomePage(indexFunction: _onItemTapped,);
        case 1:
          page = StatsPage();
        case 2:
          page = AccountPage();
        case 3:
          page = InfoPage();
        default:
          throw UnimplementedError();
      }
      
    return Scaffold(
      body: Center(
        child: Container(
          child: page,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: themeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Stats',
            backgroundColor: themeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
            backgroundColor: themeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: themeColor,
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
