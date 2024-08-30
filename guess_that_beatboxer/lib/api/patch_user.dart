import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> patchUser(String username,String email, String phone, String password, int id) async {
  final Map<String, dynamic> body = {
    'username': username,
    'email': email,
    'phone': phone,
    'password': password,
  };

  final response = await http.patch(
    Uri.parse('https://h4-projekt-gruppe-1.onrender.com/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body), 
    
  );

  if (response.statusCode == 200) {
    var token = jsonDecode(response.body)['token'];

    if (token != null) {
      return token;
    } else {
      throw Exception('Failed to change username: Token is null.');
    }
  } else {
    print('Failed with status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to change username');
  }
}
