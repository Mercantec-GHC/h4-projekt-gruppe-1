import 'package:flutter/material.dart';
import 'pages/landing.dart';
import 'pages/info.dart';
//import 'pages/lobby.dart';
import 'pages/account.dart';
import 'pages/stats.dart';
import 'pages/register.dart';
import 'pages/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BottomNavigationBarExample(),
    );
  }
}

// class BottomNavBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       color: Colors.red,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildIconButton(context, Icons.home, '/'),
//           _buildIconButton(context, Icons.analytics, '/stats'),
//           _buildIconButton(context, Icons.account_box, '/account'),
//           _buildIconButton(context, Icons.info, '/info'),
//         ],
//       ),
//     );
//   }

//   Widget _buildIconButton(BuildContext context, IconData icon, String route) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: IconButton(
//         icon: Icon(icon, color: Colors.black),
//         onPressed: () {
//           final currentRoute = ModalRoute.of(context)?.settings.name;
//           if (currentRoute != route) {
//             Navigator.pushReplacementNamed(context, route);
//           }
//         },
//       ),
//     );
//   }
// }

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
      int selectedIndex = 0;
      

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
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
