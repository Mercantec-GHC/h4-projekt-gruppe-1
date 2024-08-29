import 'package:http/http.dart' as http;
import 'dart:convert';


Future<dynamic> createMatch(token) async {

  final response = await http.post(
    Uri.parse('http://localhost:3000/match'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load');
  }
}