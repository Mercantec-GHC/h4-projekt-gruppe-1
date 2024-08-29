import 'package:flutter/material.dart';
import '../api/patch_user.dart';
import '../models/user.dart';

class ChangeUsername extends StatefulWidget {
  final User user;

  ChangeUsername({Key? key, required this.user}) : super(key: key);

  @override
  _ChangeUsernameState createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  String _statusMessage = "";

  void _changeUsername() async {
    setState(() {
      _isLoading = true;
      _statusMessage = "";
    });

    try {
      final newUsername = _usernameController.text;

      String newToken= await patchUser(newUsername, widget.user.id);
      await widget.user.updateToken(newToken);

      setState(() {
        _statusMessage = "Username changed successfully!";
        _isLoading = false;
      });

    } catch (e) {
      print(e);
      setState(() {
        _statusMessage = "Failed to change username.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter new username",
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _isLoading ? null : _changeUsername,
                child: _isLoading ? CircularProgressIndicator() : Text('Submit'),
              ),
              if (_statusMessage.isNotEmpty) ...[
                SizedBox(height: 10),
                Text(
                  _statusMessage,
                  style: TextStyle(
                    color: _statusMessage == "Username changed successfully!"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
