import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guess_that_beatboxer/models/game.dart';

import 'pages/landing.dart';
import 'pages/settings.dart';
//import 'pages/lobby.dart';
import 'pages/account.dart';
import 'pages/stats.dart';
//import 'pages/register.dart';
import 'pages/login.dart';

void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Game()),
      ],
      child: MyApp(),
    ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Karla',
      ),
      home: Login(),
    ),
    );
  }
}


class MyAppState extends ChangeNotifier {
      var user;
      int selectedIndex = 0;

  void onItemTapped(int index) {
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
        appState.onItemTapped(index);
      }
  final themeColor = Theme.of(context).primaryColor;
    Widget page;
      switch (selectedIndex) {
        case 0:
          page = HomePage();
        case 1:
          page = StatsPage();
        case 2:
          page = AccountPage();
        case 3:
          page = SettingsPage();
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
