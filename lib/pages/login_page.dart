 
 
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lqitha/components/Toast.dart';
import 'package:lqitha/components/logo.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_textfield.dart';
import 'package:lqitha/pages/forgot_password.dart';
import 'package:lqitha/pages/home.dart';
 
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/themes/light_mode.dart';
 

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
 
  const LoginPage({super.key,   this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  void login() async{
    //validation
    if( emailController.text.isEmpty || 
        passwordController.text.isEmpty){
        showToast(context,"Some Fields Are Empty.");
        return;
    }
    // Authentication logic here
    final _authService = AuthService();
 
    try{
     
      //signin 
      await _authService.signIn(
        emailController.text.trim(), 
        passwordController.text.trim()
        );
 

    }
 
    catch(e){
      if(e.toString().contains("invalid-credential") ){
        showToast(context,"Email Or Password is WRong ");
      }
      else{  
      showToast(context,"[${e.toString()}]");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color white_color = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                //logo
                Logo(),
                //message, app slogan
                Text(
                  "Missing Items Report App",
                  style: TextStyle(
                    fontSize: 16,
                    color: white_color,
                  ),
                ),
                //email textfield
                const SizedBox(height: 20),
                MyTextfield(
                    controller: emailController,
                    hintText: "Email",
                    color: white_color,
                    obsecureText: false),
                //password textfield
                const SizedBox(height: 20),
                MyTextfield(
                    controller: passwordController,
                    hintText: "Password",
                    color: white_color,

                    obsecureText: true),
                //sign in button
                const SizedBox(height: 20),
                MyButton(
                  text: "Sign In",
                  onTap: login,
                  bgcolor:white_color,
                  fgcolor:Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 20),
                //not a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member",
                      style: TextStyle(
                          color: white_color),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: white_color,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                //forgot password
                //not a member
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot Password ? ",
                      style: TextStyle(
                          color: white_color),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: (){
                   Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword()), 
                            // (route) => false
                          );
                      },
                      child: Text(
                        "Click Here",
                        style: TextStyle(
                            color: white_color,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
