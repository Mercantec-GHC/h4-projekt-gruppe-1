import 'package:http/http.dart' as http;

Future<dynamic> FetchUserStats (token, id) async {
  final response = await http.get(
    Uri.parse('https://kim.magsapi.com/user_stat/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load');
  }

} 