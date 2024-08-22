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


  User({this.jsonWebToken = " " });





  loadData (){
    try {
      decode();
      fetchUserData();
    } catch (e) {
      print(e);
    }
  }
  
  fetchUserData (){
    try {
      FetchUserStats(jsonWebToken, id);
    } catch (e) {
      print(e);
    }
  }


  decode (){
    var decodedToken = JwtDecoder.decode(jsonWebToken);
    print(decodedToken);
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




