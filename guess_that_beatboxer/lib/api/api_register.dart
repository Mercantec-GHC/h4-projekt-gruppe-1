import 'dart:convert';
import 'package:http/http.dart' as http;




Future<String> postUser(user, password) async {
  final response = await http.post(Uri.parse('https://h4-projekt-gruppe-1.onrender.com/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': '$user',
      'password': '$password',
    }),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['token'];
  } else {
    throw Exception('Failed to load album');
  }
  

}