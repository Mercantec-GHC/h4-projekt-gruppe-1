import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/main.dart';
import 'package:guess_that_beatboxer/models/user.dart';
import 'package:guess_that_beatboxer/pages/register.dart';
import 'package:provider/provider.dart';
import '../Widgets/buttons.dart';
import '../api/fetch_login.dart';
import '../Widgets/appBarLogin.dart';
import '../Widgets/util/resetPassword.dart';
import 'package:guess_that_beatboxer/notificationManager/notificationService.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    checkForToken();
  }

  Future<void> checkForToken() async {
    var token = await User.getToken();
    if (token != null) {
      var user = User(jsonWebToken: token);
      if (!user.expired()) {
        user.decode();
        var appState = context.read<MyAppState>();
        appState.user = user;
        await user.loadData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      appBar: appBarLoginFunction("Login"),
      body: Center(
        child:SingleChildScrollView( // Gør det muligt at rulle, når tastaturet dukker op
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:  
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    height: 150,
                  ),
                  Text(
                    "Welcome To Guess That Beatboxer!",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  LoginForm(),
                  SizedBox(height: 200),
                ],
              ),
            ),
        )
      )
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> login(appState) async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });
    try {
      String email = _emailController.text;
      String password = _passwordController.text;
      var tokens = await fetchLogin(email, password);
      appState.user = User(jsonWebToken: tokens[0],refreshToken: tokens[1]);
      await appState.user.saveToken();
      await appState.user.loadData();
      NotificationService().onUserLogin(true, appState.user);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));

    } catch (e) {
      _showPopup(context, "Invalid email or password");
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
    if(_isLoading){
      return CircularProgressIndicator();
    }else {
      return Form(
      key: _formKey,
      child:
     Padding(
       padding: const EdgeInsets.all(15),
       child: Column(
        children: <Widget> 
        [
          Text("email"),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: (value) => value!.isEmpty ? 'Please enter a E-amil' : null,
          ),
          SizedBox(height: 10),
          Text("Password"),
          //fejl lige her !!!!!
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: 'Enter your password',
            ),
            obscureText: true,
            validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
          ),
          
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Buttons(
                      text: "Forgot password",
                      pressFunction: () {
                        resetPassword(context);
                      },
                      backgroundColor: Colors.white,
                      textColor: Colors.black),
                SizedBox(width: 10),
                Buttons(text: "Login",pressFunction: () async {await login(appState);}, backgroundColor: Colors.black, textColor: Colors.white),
            ],
          ),
          SizedBox(height: 10),
          Buttons(text: "Create acccount", pressFunction: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));} , backgroundColor: Colors.black, textColor: Colors.white, length: double.infinity),
        ],
           ),
     ),
    );
    }
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



