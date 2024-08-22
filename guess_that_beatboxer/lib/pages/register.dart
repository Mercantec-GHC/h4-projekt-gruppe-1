import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'landing.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late Future<User> futureUser;

  @override
    void initState() {
    super.initState();
    futureUser = registerUser();
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
                FutureBuilder<User>(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                )
                              
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

  class User {
  final int id;
  final String name;
  final String nickname;
  final String email;
  final String password;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.nickname,
    required this.email,
    required this.password,
    required this.phone
    });
  

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'nickname': String nickname,
        'email': String email,
        'password': String password,
        'phone': String phone,
      } => User(
        id: id,
        name: name,
        nickname: nickname,
        email: email,
        password: password,
        phone: phone,
      ),
      _=> throw Exception('Failed to load user'),
    };
  }
}

Future<User> registerUser() async {
  final response = await http.get(Uri.parse('https://h4-projekt-gruppe-1.onrender.com/user/1'));

  if (response.statusCode == 200) {
    print(response.body);
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load users');
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