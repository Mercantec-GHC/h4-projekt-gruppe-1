import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/models/user.dart';

class ChangeUsername extends StatefulWidget {
  final User user;

  const ChangeUsername({super.key, required this.user});

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
   /*    final newUsername = _usernameController.text; */

     /*  String newToken= await patchUser(newUsername, widget.user.id); */
      /* await widget.user.updateToken(newToken); */

      setState(() {
        _statusMessage = "Username changed successfully!";
        _isLoading = false;
      });

    } catch (e) {
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
                  width: double.infinity,
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter new username",
                    ),
                  ),
                ),
              ),
              
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white)),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),                  
                ),
                onPressed: _isLoading ? null : _changeUsername,
                child: _isLoading ? const CircularProgressIndicator() : const Text('Change username'),
              ),
              if (_statusMessage.isNotEmpty) ...[
                const SizedBox(height: 10),
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
