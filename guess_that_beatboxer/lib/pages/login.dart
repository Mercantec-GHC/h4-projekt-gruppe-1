import 'package:flutter/material.dart';
import '../Widgets/buttons.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset('../assets/logo.png',
              fit: BoxFit.contain,
              height: 150, 
            ),
            Text("Welcome To Guess That Beatboxer!", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20),
            LoginForm(),
            SizedBox(height: 200),
          ],
          ),
      ),
    );
  }



}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child:
     Padding(
       padding: const EdgeInsets.all(15),
       child: Column(
        children: <Widget> 
        [
          Text("Username"),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your username',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Buttons( text: "Forgot password", pressFunction: () {_showPopup(context);}, backgroundColor: Colors.white, textColor: Colors.black),
                Buttons(text: "Login",pressFunction: () {Navigator.pushReplacementNamed(context, "/");}, backgroundColor: Colors.black, textColor: Colors.white),
            ],
          ),
          Buttons(text: "Create acccount", pressFunction: () {Navigator.pushReplacementNamed(context, "/register");}, backgroundColor: Colors.black, textColor: Colors.white),
        ],
           ),
     ),
    );
  }


void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Forgot Password'),
          content: const Text('This is just a popup to show that you clicked forgot password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
