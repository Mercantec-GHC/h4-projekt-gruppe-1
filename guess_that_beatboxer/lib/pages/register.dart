import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBar.dart';
import 'package:guess_that_beatboxer/models/user.dart';
import 'package:guess_that_beatboxer/api/user_register.dart';
import 'package:guess_that_beatboxer/pages/login.dart';
import '../Widgets/buttons.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final List<TextEditingController> _controllers = List.generate(RegisterLabels.length, (index) => TextEditingController());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  var user = User();

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Register';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: appBarFunction("Register"),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    '../assets/logo.png',
                    fit: BoxFit.contain,
                    height: 150,
                  ),
                  Text(
                    "Welcome To Guess That Beatboxer!",
                    style: TextStyle(fontSize: 20),
                  ),
                  inputFields(_controllers, RegisterLabels, RegisterLabels),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RegisterBTN(_controllers, _setLoading),
                     
                    ],
                  ),
                   Buttons(text: 'Cancel', pressFunction: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      }, length: 300, height: 50),
                ],
              ),
            ),
            if (_isLoading)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}

class RegisterBTN extends StatelessWidget {
  final List<TextEditingController> _controllers;
  final Function(bool) setLoading;

  RegisterBTN(this._controllers, this.setLoading);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () async {
          if (!validateFields(context)) return;

          setLoading(true);
          bool success = await submitUser(_controllers, context);
          setLoading(false);
          if (success) {
            showSuccessDialog(context);
          }
        },
        child: const Text('Create account', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  bool validateFields(BuildContext context) {
    if (_controllers[0].text.isEmpty) {
      showErrorDialog(context, 'Du skal have et navn');
      return false;
    }
    if (_controllers[1].text.isEmpty) {
      showErrorDialog(context, 'Du skal vælge et username');
      return false;
    }
    if (_controllers[2].text.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_controllers[2].text)) {
      showErrorDialog(context, 'Skriv en gyldig email');
      return false;
    }
    if (_controllers[3].text.isEmpty) {
      showErrorDialog(context, 'Du skal have et telefonnummer');
      return false;
    }
    if (_controllers[4].text.isEmpty) {
      showErrorDialog(context, 'Du skal vælge et password');
      return false;
    }
    if (_controllers[5].text != _controllers[4].text) {
      showErrorDialog(context, 'Passwords matcher ikke');
      return false;
    }
    return true;
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bruger oprettet'),
          actions: <Widget>[
            TextButton(
              child: Text('Gå til Login'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));

              },
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

List<String> RegisterLabels = [
  'Navn',
  'Username',
  'Email',
  'Telefon',
  'Password',
  'Bekræft Password',
];

class inputFields extends StatelessWidget {
  final List<TextEditingController> _controllers;
  final List<String> labels;
  final List<String> userInfo;

  inputFields(this._controllers, this.labels, this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < labels.length; i++)
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _controllers[i],
                obscureText: labels[i].toLowerCase().contains('password'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: userInfo[i],
                  hintText: labels[i],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Future<bool> submitUser(List<TextEditingController> controllers, BuildContext context) async {

  return await postUser(
    controllers[0].text,
    controllers[1].text,
    controllers[2].text,
    controllers[3].text,
    controllers[4].text,
  );
}