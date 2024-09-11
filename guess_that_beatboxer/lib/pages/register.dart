import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/Widgets/appBarLogin.dart';
import 'package:guess_that_beatboxer/models/user.dart';
import 'package:guess_that_beatboxer/api/user_register.dart';
import 'package:guess_that_beatboxer/pages/login.dart';
import 'package:guess_that_beatboxer/widgets/util/inputFields.dart';
import 'package:guess_that_beatboxer/widgets/util/validation.dart';
import 'package:guess_that_beatboxer/widgets/util/spinner.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final List<TextEditingController> _controllers = [];
  bool _isLoading = false;
  bool _isRegistered = false;
  String? imageData;
  List<String> registerLabels = [
    'Navn',
    'Username',
    'Email',
    'Telefon',
    'Password',
    'Bekræft Password',
  ];

  @override
  void initState() {
    super.initState();
    _controllers.addAll(List.generate(registerLabels.length, (index) => TextEditingController()));
  }

  var user = User();

  @override
 Widget build(BuildContext context) {
    const String appTitle = 'Register';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: appBarLoginFunction("Register"),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      '../assets/logo.png',
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                    const Text(
                      "Welcome To Guess That Beatboxer!",
                      style: TextStyle(fontSize: 20),
                    ),
                    InputFields(_controllers, registerLabels, registerLabels, (data) {
                      setState(() {
                        imageData = data;
                      });
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RegisterBTN(_controllers, _setLoading, _setRegistered, imageData),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: Colors.black),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading || _isRegistered)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: LoadingSpinner(
                  isLoading: _isLoading,
                  isSuccess: _isRegistered,
                  successMessage: 'User registered successfully!',
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

  void _setRegistered(bool isRegistered) {
    setState(() {
      _isRegistered = isRegistered;
    });
  }
}

class RegisterBTN extends StatelessWidget {
  final List<TextEditingController> _controllers;
  final Function(bool) setLoading;
  final Function(bool) setRegistered;
  final String? imageData; 

  RegisterBTN(this._controllers, this.setLoading, this.setRegistered, this.imageData);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () async {
          if (!validateFields(context, _controllers)) return;

          setLoading(true);
          bool success = await submitUser(_controllers, context, imageData ?? '');
          setLoading(false);
          if (success) {
            setRegistered(true);
            await Future.delayed(Duration(seconds: 2));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
          }
        },
        child: const Text('Create account', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}



Future<bool> submitUser(List<TextEditingController> controllers, BuildContext context, String imageData) async {
  return await postUser(
    controllers[0].text,
    controllers[1].text,
    controllers[2].text,
    controllers[3].text,
    controllers[4].text,
    imageData
  );
}