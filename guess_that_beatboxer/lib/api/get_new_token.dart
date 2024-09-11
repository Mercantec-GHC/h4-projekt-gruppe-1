import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<String?> refreshAccessToken() async {
  final refreshToken = await storage.read(key: 'refreshToken');
  if (refreshToken == null) {
    throw Exception('No refresh token available');
  }

  final response = await http.post(
    Uri.parse('http://localhost:8080/token/refresh'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {'refresh_token': refreshToken},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final newToken = data['token'];
    await storage.write(key: 'jwtToken', value: newToken);
    return newToken;
  } else {
    throw Exception('Failed to refresh access token');
  }
}