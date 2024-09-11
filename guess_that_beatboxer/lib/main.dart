import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:guess_that_beatboxer/models/game.dart';

import 'pages/landing.dart';
import 'pages/settings.dart';
import 'pages/userStats.dart';
import 'pages/stats.dart';
import 'pages/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Game()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
          ),
          cardTheme: CardTheme(
            color: Colors.white,
            elevation: 5,
            shadowColor: Colors.black,
          ),
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

  Future<void> updateRecentMatches() async {
    await user.fetchUserData();
    await user.fetchMatchData();
    notifyListeners();
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
        break;
      case 1:
        page = StatsPage();
        break;
      case 2:
        page = AccountPage();
        break;
      case 3:
        page = SettingsPage(user: appState.user);
        break;
      default:
        throw UnimplementedError();
    }

    return Scaffold(
      body: Center(
        child: page,
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            items: <BottomNavigationBarItem>[
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
          Positioned(
            top: -20.0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: themeColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}