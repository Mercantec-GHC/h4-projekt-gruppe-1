import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> patchUser(String username, String email, String phone, String password, int id, {String? image}) async {
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
      if (image != null) {
        final imageResponse = await http.patch(
          Uri.parse('https://h4-projekt-gruppe-1.onrender.com/image/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'name': 'User Image',
            'image': image,
          }),
        );

        if (imageResponse.statusCode != 200) {
          throw Exception('Failed to update image');
        }
      }
      return token;
    } else {
      throw Exception('Failed to change username: Token is null.');
    }
  } else {
    throw Exception('Failed to change username');
  }
}