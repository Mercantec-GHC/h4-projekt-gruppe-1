import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/api/fetch_user_by_mail.dart';
import 'package:guess_that_beatboxer/api/new_password.dart';
import 'package:guess_that_beatboxer/widgets/util/spinner.dart';

class ResetPasswordDialog extends StatefulWidget {
  @override
  _ResetPasswordDialogState createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  void _checkEmailAndResetPassword() async {
    setState(() {
      _isLoading = true;
      _isSuccess = false;
    });
    bool userExists = await fetchByMail(_emailController.text);
    if (userExists) {
      await updatePassword(_emailController.text, "kode1234");
      setState(() {
        _isSuccess = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
    if (_isSuccess) {
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Reset Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          LoadingSpinner(
            isLoading: _isLoading,
            isSuccess: _isSuccess,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            _checkEmailAndResetPassword();
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}

Future<dynamic> resetPassword(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ResetPasswordDialog();
    },
  );
}