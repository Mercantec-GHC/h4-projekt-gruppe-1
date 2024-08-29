import 'package:http/http.dart' as http;

Future<void> destroyMatch(id) async {

  final response = await http.delete(
    Uri.parse('https://h4-projekt-gruppe-1-1.onrender.com/match/$id'),
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to load');
  }
}