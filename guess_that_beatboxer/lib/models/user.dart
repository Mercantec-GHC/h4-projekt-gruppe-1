import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import '../api/fetch_user_stats.dart';
import 'user_stats.dart';

class User {
  String jsonWebToken;
  int id = 0;
  String userName = " ";
  String email = " ";
  String phone = " ";
  String nickName = " ";
  String password = " ";
  UserStats userStats = UserStats();


  User({this.jsonWebToken = " " });





  loadData () async{
    try {
      decode();
      await fetchUserData();
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


  decode (){
    var decodedToken = JwtDecoder.decode(jsonWebToken);
      id = decodedToken['id'];
      userName = decodedToken['sub'];
      email = decodedToken['email'];
      phone = decodedToken['phone'];
      nickName = decodedToken['nickname'];
    }

  expired(){
      return JwtDecoder.isExpired(jsonWebToken);
    }

  }




