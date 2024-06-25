import 'dart:convert';

class CUser{
  String userid;
  String username;
  String email;
  String? phone;
  CUser({
    required this.userid,
    required this.username,
    required this.email,
    this.phone,
  });
  // factory User.fromJson(Map<String,dynamic> json){
  //   return User(userid: json["userid"],
  //           username: username, 
  //           email: email, 
  //           phone: phone
  //   );
  // }
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
    // TODO: implement toString
    StringBuffer result = StringBuffer();
    result.writeln("user id : $userid");
    result.writeln("username : $username");
    result.writeln("user email : $email");
    result.writeln("user phone : $phone");
    return result.toString();
  }
}