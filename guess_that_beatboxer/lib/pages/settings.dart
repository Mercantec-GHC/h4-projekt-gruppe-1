import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBar.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/pages/login.dart';
import 'package:guess_that_beatboxer/widgets/buttons.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Settings Page'),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Buttons( text: 'Delete account', pressFunction: () {
                  deleteAccount(context);
                }, length: 400,
                 ),
                 SizedBox(height: 5),
                Buttons( text: 'Logout', pressFunction: () async {
                  await user.deleteToken();
                  user = "";
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                }, length: 400,
                 ),
                 SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarExample(),
    );
  }
}

deleteAccount (context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
}