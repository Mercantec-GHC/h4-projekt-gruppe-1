import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> fetchUserById(int id) async {
  final response = await http.get(
    Uri.parse('https://h4-projekt-gruppe-1.onrender.com/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return response.body.replaceAll('"', '');
  } else {
    return null;
  }
}