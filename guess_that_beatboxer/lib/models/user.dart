import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../api/fetch_user_stats.dart';
import '../api/fetch_user_matches.dart';
import '../api/fetch_image.dart';
import '../api/get_new_token.dart';
import 'user_stats.dart';
import 'match_history.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  String jsonWebToken;
  int id = 0;
  String name = " ";
  String email = " ";
  String phone = " ";
  String userName = " ";
  String password = " ";
  String image = " ";
  UserStats userStats = UserStats();
  List<MatchHistory> matchHistory = [];
  String refreshToken;

  static final storage = FlutterSecureStorage();

  User({this.jsonWebToken = " ", this.refreshToken = " "});

  Future<void> saveToken() async {
    await storage.write(key: 'jwtToken', value: jsonWebToken);
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'jwtToken');
  }

  Future<String?> getNewToken() async {
    return await storage.read(key: 'jwtToken');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'jwtToken');
    await storage.delete(key: 'refreshToken');
  }

  Future<void> updateToken(String newToken) async {
    jsonWebToken = newToken;
    await saveToken();
  }

  Future<void> refreshTokenIfNeeded() async {
    if (isExpired) {
      try {
        final newAccessToken = await refreshAccessToken();
        if (newAccessToken != null) {
          await updateToken(newAccessToken);
        }
      } catch (e) {
        throw Exception('Failed to refresh access token');
      }
    }
  }

  loadData() async {
    try {
      await refreshTokenIfNeeded();
      decode();
      await fetchUserData();
      await fetchMatchData();
      image = await fetchUserImage(jsonWebToken, id);
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  fetchUserData() async {
    try {
      await refreshTokenIfNeeded();
      var jsonData = await FetchUserStats(jsonWebToken, id);
      var data = jsonDecode(jsonData);
      userStats = UserStats.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  fetchMatchData() async {
    try {
      await refreshTokenIfNeeded();
      var jsonData = await FetchMatchStats(jsonWebToken, id);
      var data = jsonDecode(jsonData) as List<dynamic>;
      matchHistory = data.map((item) => MatchHistory.fromJson(item)).toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to load match data');
    }
  }

  decode() {
    var decodedToken = JwtDecoder.decode(jsonWebToken);
    id = decodedToken['id'];
    name = decodedToken['sub'];
    email = decodedToken['email'];
    phone = decodedToken['phone'];
    userName = decodedToken['username'];
  }

  expired() {
    return JwtDecoder.isExpired(jsonWebToken);
  }

  bool get isExpired => JwtDecoder.isExpired(jsonWebToken);
}