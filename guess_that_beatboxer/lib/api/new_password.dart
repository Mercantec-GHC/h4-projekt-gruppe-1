import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> updatePassword(String email, String newPassword) async {
  final response = await http.post(
    Uri.parse('https://h4-projekt-gruppe-1.onrender.com/user/$email/password'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'password': newPassword,
    }),
  );

  if (response.statusCode == 200) {
    return 'Password updated successfully';
  } else {
    throw Exception('Failed to update password');
  }
}