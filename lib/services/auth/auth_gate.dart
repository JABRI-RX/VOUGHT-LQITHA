import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lqitha/auth/login_or_register.dart';
 
import 'package:lqitha/pages/home.dart';

class AuthGate extends StatelessWidget {
const AuthGate({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot){
          if(snapshot.hasData){
 
            return   Home();
          }
          else{
            return const LoginOrRegister();
          }
        } ,
      ),
    );
  }
}