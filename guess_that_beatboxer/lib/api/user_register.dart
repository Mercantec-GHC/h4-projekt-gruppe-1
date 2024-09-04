import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> postUser(String name, String username, String email, String phone, String password, String image) async {
  final userResponse = await http.post(
    Uri.parse('https://h4-projekt-gruppe-1.onrender.com/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    }),
  );

  if (userResponse.statusCode == 201) {
    final userId = jsonDecode(userResponse.body)['user_id'];

    final imageResponse = await http.post(
      Uri.parse('https://h4-projekt-gruppe-1.onrender.com/image/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': 'User Image',
        'image': image,
      }),
    );

    if (imageResponse.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } 

  else {
    return false;
  }
}