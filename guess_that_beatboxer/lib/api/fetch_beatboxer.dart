import 'package:http/http.dart' as http;

Future<String> fetchBeatboxer() async {
  final response = await http.get(
    Uri.parse('https://h4-projekt-gruppe-1-1.onrender.com/beat_boxer'),
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load');
  }

}