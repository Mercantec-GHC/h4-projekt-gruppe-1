import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/models/user.dart';
import 'package:guess_that_beatboxer/api/user_register.dart';
import 'package:guess_that_beatboxer/pages/login.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final List<TextEditingController> _controllers = List.generate(labels.length, (index) => TextEditingController());
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
        appBar: AppBar(
          title: const Text(appTitle),
        ),
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
                  inputFields(_controllers),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RegisterBTN(_controllers, _setLoading),
                    ],
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          setLoading(true);
          bool success = await submitUser(_controllers, context);
          setLoading(false);
          if (success) {
            showSuccessDialog(context);
          }
        },
        child: const Text('Create account'),
      ),
    );
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    );
  }
}

List<String> labels = [
  'Navn',
  'Email',
  'Telefon',
  'Password',
];

class inputFields extends StatelessWidget {
  final List<TextEditingController> _controllers;

  inputFields(this._controllers);

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: labels[i],
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
  print('Full Name: ${controllers[0].text}');
  print('Email: ${controllers[1].text}');
  print('Phone: ${controllers[2].text}');
  print('Password: ${controllers[3].text}');

  return await postUser(
    controllers[0].text,
    controllers[1].text,
    controllers[2].text,
    controllers[3].text,
  );
}