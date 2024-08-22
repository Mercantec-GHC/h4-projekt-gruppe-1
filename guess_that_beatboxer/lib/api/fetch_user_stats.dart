import 'package:http/http.dart' as http;

Future<String> FetchUserStats (token, id) async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/user_stat/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    return "test";
  } else {
    throw Exception('Failed to load album');
  }

} 