import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBar.dart';
import 'package:guess_that_beatboxer/models/user.dart';
import 'package:guess_that_beatboxer/pages/login.dart';
import 'package:guess_that_beatboxer/pages/register.dart';
import '../Widgets/buttons.dart';
import '../Widgets/settings/notificationsBTN.dart';
import '../Widgets/settings/muteSoundSwitch.dart';
import '../../api/patch_user.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:ui';

class SettingsPage extends StatefulWidget {
  final user;

  const SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState(user: user);
}

class _SettingsPageState extends State<SettingsPage> {
  final User user;
  _SettingsPageState({required this.user});
  final List<TextEditingController> _controllers = List.generate(Updatelabels.length, (index) => TextEditingController());

  bool _isLoading = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String? imageData;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const  initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const  initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

    void _updateUser() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final newUser = (
        userName: _controllers[0].text,
        email: _controllers[1].text,
        phone: _controllers[2].text,
        password: _controllers[3].text,
      );

      String newToken = await patchUser(
        newUser.userName,
        newUser.email,
        newUser.phone,
        newUser.password,
        image: imageData, 
        widget.user.id,
      );
      await widget.user.updateToken(newToken);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

@override
Widget build(BuildContext context) {
  List<String> userInfo = [
    user.userName,
    user.email,
    user.phone,
    'Password',
    'Bekræft Password',
  ];

  return Scaffold(
    appBar: appBarFunction("Settings", context),
    backgroundColor: Colors.white,
    body: Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Notification Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NotificationButton(flutterLocalNotificationsPlugin),
                    ),
                    const SizedBox(width: 20),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EnableSoundButton(),
                    ),
                  ]
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Change User Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: inputFields(_controllers, Updatelabels, userInfo, (data) {
                    setState(() {
                      imageData = data;
                    });
                  }),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Buttons(
                          text: 'Update',
                          pressFunction: () {
                            _updateUser();
                          },
                          length: double.infinity,
                          height: 50,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Buttons(
                          text: 'Cancel',
                          pressFunction: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                          },
                          length: double.infinity,
                          height: 50,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Buttons(
                          text: 'Delete Account',
                          pressFunction: () {
                            _updateUser();
                          },
                          length: double.infinity,
                          height: 50,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Buttons(
                          text: 'Logout',
                          pressFunction: () async {
                            await user.deleteToken();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                          },
                          length: double.infinity,
                          height: 50,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    ),
  );
}
}

List<String> Updatelabels = [
  'Username',
  'Email',
  'Telefon',
  'Password',
  'Bekræft Password',
];

deleteAccount(context) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
}