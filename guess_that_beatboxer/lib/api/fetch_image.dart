  import 'package:http/http.dart' as http;
  import 'dart:convert';

Future<dynamic> fetchUserImage (token, id) async {
  final response = await http.get(
    Uri.parse('https://h4-projekt-gruppe-1.onrender.com/image/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
        var image = '';
        var data = jsonDecode(response.body);
        image = data['image'];
        return image;
  } else {
    throw Exception('Failed to load');
  }

} 