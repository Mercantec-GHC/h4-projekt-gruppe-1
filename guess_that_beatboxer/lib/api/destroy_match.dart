import 'package:http/http.dart' as http;

Future<void> destroyMatch(id) async {

  final response = await http.delete(
    Uri.parse('http://localhost:3000/match/$id'),
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to load');
  }
}