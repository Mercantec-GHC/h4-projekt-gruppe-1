import 'dart:convert';
import 'package:http/http.dart' as http;




Future<String> postUser(name, email, phone, password, username) async {
  final response = await http.post(Uri.parse('https://h4-projekt-gruppe-1.onrender.com/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': '$name',
      'email': '$email',
      'phone': '$phone',
      'password': '$password',
      'username': '$username',

    }),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['token'];
  } else {
    throw Exception('Failed to load album');
  }
  

}