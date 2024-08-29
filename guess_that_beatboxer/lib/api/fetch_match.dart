import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchMatch(token, id) async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/match/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 404) {
    return "No match found";
  }
  else{
    throw Exception('Failed to load');

  }
}