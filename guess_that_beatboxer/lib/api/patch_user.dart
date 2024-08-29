import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> patchUser(username, id) async {

  final response = await http.patch(Uri.parse('https://h4-projekt-gruppe-1.onrender.com/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: username,
  );
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['token'];
  } else {
    throw Exception('Failed to load');
  }
}