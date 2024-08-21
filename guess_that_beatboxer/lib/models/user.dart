import 'package:jwt_decoder/jwt_decoder.dart';

class User {
  String jsonWebToken;
  String userName;

  User({this.jsonWebToken = " " , this.userName = ''});



  decode (){
    var decodedToken = JwtDecoder.decode(jsonWebToken);
      userName = decodedToken['sub'];
    }

  expired(){
      return JwtDecoder.isExpired(jsonWebToken);
    }

  }




