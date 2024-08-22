import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  String jsonWebToken;
  String userName = " ";
  String email = " ";
  String phone = " ";
  String nickName = " ";
  String password = " ";

  User({this.jsonWebToken = " " });



  decode (){
    var decodedToken = JwtDecoder.decode(jsonWebToken);
      userName = decodedToken['name'];
      email = decodedToken['email'];
      phone = decodedToken['phone'];
      nickName = decodedToken['nickName'];
    }

  expired(){
      return JwtDecoder.isExpired(jsonWebToken);
    }

  }




