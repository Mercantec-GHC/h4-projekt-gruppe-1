import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/pages/login.dart';
import 'package:guess_that_beatboxer/widgets/buttons.dart';
import 'package:guess_that_beatboxer/widgets/appBar.dart';
import 'package:provider/provider.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();
    var user = appState.user;
    return Scaffold(
      appBar: appBarFunction("Settings"),
      body: Center(child:
        Column(
          children: [
            Text('Settings Page'),
            Buttons( text: 'Logout', pressFunction: () {
              user = "";
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
            }
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarExample(),
    );
  }
}
