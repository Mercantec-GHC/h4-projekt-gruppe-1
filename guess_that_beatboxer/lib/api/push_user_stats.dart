import 'package:http/http.dart' as http;


Future<String> PushUserStats (token, userStats) async {
  final response = await http.post(
    Uri.parse('https://h4-projekt-gruppe-1.onrender.com/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: userStats,
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load album');
  }

}