 
import 'dart:developer';

class CUser{
  String  userid;
  String  username;
  String  email;
  String  phone;
  CUser({
    required this.userid,
    required this.username,
    required this.email,
    required this.phone,
  });
  factory CUser.fromJson(Map<String,dynamic> json){
 
    return CUser(
      userid: json["id"],
      username: json["name"], 
      email: json["email"], 
      phone: json["phone"]
    );
  }
  Map<String ,dynamic> toJson(){
    return {
      'id': userid,
      'name': username,
      'email': email,
      'phone':phone,
    };
  }
  @override
  String toString() {
 
    StringBuffer result = StringBuffer();
    result.writeln("user id : $userid");
    result.writeln("username : $username");
    result.writeln("user email : $email");
    result.writeln("user phone : $phone");
    return result.toString();
  }
}