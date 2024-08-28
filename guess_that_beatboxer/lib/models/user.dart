import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import '../api/fetch_user_stats.dart';
import '../api/fetch_user_matches.dart';
import 'user_stats.dart';
import 'match_history.dart';

class User {
  String jsonWebToken;
  int id = 0;
  String name = " ";
  String email = " ";
  String phone = " ";
  String userName = " ";
  String password = " ";
  UserStats userStats = UserStats();
  List<MatchHistory> matchHistory = [];


  User({this.jsonWebToken = " " });


  loadData () async{
    try {
      decode();
      await fetchUserData();
      await fetchMatchData();
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
  
  fetchUserData () async{
    try {
      if (expired()) {
        throw Exception('Token expired');
      }
    var jsonData =  await FetchUserStats(jsonWebToken, id);
    var data = jsonDecode(jsonData);
    userStats = UserStats.fromJson(data);
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }


fetchMatchData() async {
  try {
    if (expired()) {
      throw Exception('Token expired');
    }
    var jsonData = await FetchMatchStats(jsonWebToken, id);
    var data = jsonDecode(jsonData) as List<dynamic>;
    matchHistory = data.map((item) => MatchHistory.fromJson(item)).toList();
  } catch (e) {
    print(e);
    throw Exception('Failed to load match data');
  }
}

  decode (){
    var decodedToken = JwtDecoder.decode(jsonWebToken);
      id = decodedToken['id'];
      name = decodedToken['sub'];
      email = decodedToken['email'];
      phone = decodedToken['phone'];
      userName = decodedToken['username'];
    }

  expired(){
      return JwtDecoder.isExpired(jsonWebToken);
    }

  }




