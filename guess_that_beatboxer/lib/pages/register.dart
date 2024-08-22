import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'landing.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
    void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    const String appTitle = 'Register';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('../assets/logo.png',
                fit: BoxFit.contain,
                height: 150, 
              ),
            Text("Welcome To Guess That Beatboxer!", style: TextStyle(fontSize: 20),),
              inputFields(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegisterBTN(),
                ],
              ),

                              
            ],
          ),
        ),
      ),
    );
  }
}


class RegisterBTN extends StatelessWidget {

  void _register(BuildContext context) {
        showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bruger oprettet med succes'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
          ],
        );
      },
    );
  }

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
        onPressed: () {
         _register(context);
        },
        child: const Text('Create account'),
      ),
    );
  }
}



List<String> labels = [
  'First Name',
  'Last Name',
  'Email',
  'Password',
  'Confirm Password',
];

class inputFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            for (var label in labels)  
              Padding(
                padding: const EdgeInsets.all(10),
                child: 
                  TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: label,
                    hintText: label,
                  ),
                ),
              ),

            ],
          ),
          
        );
      }
    }