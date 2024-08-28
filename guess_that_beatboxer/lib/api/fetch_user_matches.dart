import 'package:http/http.dart' as http;

Future<dynamic> FetchMatchStats (token, id) async {
  final response = await http.get(
    Uri.parse('https://h4-projekt-gruppe-1-1.onrender.com/user/$id'),
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