import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/models/user.dart';
import 'package:guess_that_beatboxer/pages/register.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;
import '../Widgets/buttons.dart';
import '../api/fetch_login.dart';

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

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
Future<void> login(appState) async {
    if (_formKey.currentState!.validate()) {
       setState(() {
        _isLoading = true;
      });
      try {
        String username = _usernameController.text;
        String password = _passwordController.text;
        
        var token = await fetchLogin(username, password);
        appState.user = User(jsonWebToken: token);
        appState.user.decode();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } catch (e) {
        _showPopup(context, "Invalid username or password");
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    return Form(
      key: _formKey,
      child:
     Padding(
       padding: const EdgeInsets.all(15),
       child: Column(
        children: <Widget> 
        [
          Text("Username"),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              hintText: 'Enter your username',
            ),
            validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
          ),
          SizedBox(height: 10),
          Text("Password"),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: 'Enter your password',
            ),
            obscureText: true,
            validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
          ),
          
          SizedBox(height: 10),
          _isLoading
          ? CircularProgressIndicator()
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Buttons( text: "Forgot password", pressFunction: () {_showPopup(context, "forgot password");}, backgroundColor: Colors.white, textColor: Colors.black),
                Buttons(text: "Login",pressFunction: () async {await login(appState);}, backgroundColor: Colors.black, textColor: Colors.white),
            ],
          ),
          Buttons(text: "Create acccount", pressFunction: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));} , backgroundColor: Colors.black, textColor: Colors.white),
        ],
           ),
     ),
    );
  }

void _showPopup(BuildContext context, error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('$error'),
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



