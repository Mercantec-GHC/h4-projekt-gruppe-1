import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> fetchByMail(String email) async {
  final response = await http.get(
    Uri.parse('https://h4-projekt-gruppe-1.onrender.com/user/email/$email'),
   /*  Uri.parse('http://localhost:8080/user/email/$email'), */
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}