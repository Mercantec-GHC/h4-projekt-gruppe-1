import 'package:flutter/material.dart';
import 'pages/landing.dart';
import 'pages/info.dart';
//import 'pages/lobby.dart';
import 'pages/account.dart';
import 'pages/stats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/stats': (context) => StatsPage(),
        '/account': (context) => AccountPage(),
        '/info': (context) => InfoPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(context, Icons.home, '/'),
          _buildIconButton(context, Icons.analytics, '/stats'),
          _buildIconButton(context, Icons.account_box, '/account'),
          _buildIconButton(context, Icons.info, '/info'),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String route) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          if (currentRoute != route) {
            Navigator.pushNamed(context, route);
          }
        },
      ),
    );
  }
}


