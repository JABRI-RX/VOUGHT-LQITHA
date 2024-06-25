 

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lqitha/components/logo.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_textfield.dart';
import 'package:lqitha/components/toast.dart';
import 'package:lqitha/dao/models/user.dart';
import 'package:lqitha/pages/login_page.dart';
 
import 'package:lqitha/services/auth/auth_gate.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/services/database/firestore.dart';
 
 
class RegisterPage extends StatefulWidget{
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController userNameController ;
  late TextEditingController emailController ;
  late TextEditingController passwordController ;
  late TextEditingController confirmedpasswordController ;
  //get auth serice
  late AuthService _authService ;
  late FireStoreService usersPB;
  //
  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmedpasswordController = TextEditingController();
    _authService = AuthService();
    usersPB = FireStoreService();
  }
  @override 
  void dispose() {
 
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmedpasswordController.dispose();
  }
  void register() async{
    
    //check if textfields are populated
    if( userNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty || 
        confirmedpasswordController.text.isEmpty
        ){
         showToast(context,"Some Fields Are Empty");
        }
    //check if password match 
    if(passwordController.text != confirmedpasswordController.text){
      showToast(context,"The passwords Do not Match.");
      return;
    }
    
    //create user
    try{
      await _authService.signUp(
        userNameController.text.trim(),
        emailController.text.trim(), 
        passwordController.text.trim()
        );
        log(_authService.getCurrentUser()?.displayName?? "");
        
        await usersPB.createUser(
          CUser(
              userid: _authService.getCurrentUser()!.uid, 
              username: userNameController.text,
              email: emailController.text, 
              phone: "+212600000000"
              )
        );
        if(!mounted) return;
        showToast(context, "Account Created successfully");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:(context)=> const LoginPage(
            )
          )
        );
 
    }
    on FirebaseAuthException catch(e){
      String result  = "";
      if(e.code == "Exception: weak-password"){
        result = "The password provided is too weak.";
      }
      else if (e.code == "email-already-in-use"){
        result = "The account already exists for that email.";
      }
      if(mounted){
        showToast(context,result);
      }
    }
    catch(e){
      if(mounted){   
        showToast(context,e.toString());
      }
    }  
  }
  
  @override
  Widget build(BuildContext context) {
    Color white_color = Theme.of(context).colorScheme.inversePrimary;
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body:  SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            //logo
            Logo(),
            //mesage, app slogan
            Text(
              "Let's Create Account",
              style: TextStyle(
                fontSize: 16,
                color:white_color
              ),  
            ),
            //Username
            const SizedBox(height: 20,),
            MyTextfield(
              controller: userNameController,
              hintText: "Username",
              color: white_color,
              obsecureText: false
            ),
            //email textfield
            const SizedBox(height: 20,),
            MyTextfield(
              controller: emailController,
              hintText: "Email",
              color: white_color,

              obsecureText: false
            ),
            //password textfield
            const SizedBox(height: 20,),
            MyTextfield(
              controller: passwordController,
              hintText: "Password",
              color: white_color,

              obsecureText: true
            ),
            //confirmed password textfield
            const SizedBox(height: 20,),
            MyTextfield(
              controller: confirmedpasswordController,
              hintText: "Confirm Password",
              color: white_color,
              obsecureText: true
            ),
            
            //sign in button
            const SizedBox(height: 20,),
            MyButton(
              text: "Sign Up",
              bgcolor:Theme.of(context).colorScheme.inversePrimary,
              fgcolor:Theme.of(context).colorScheme.surface,
              onTap:register
            ),
            const SizedBox(height: 20,),
        
            //not a member
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4,),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Login Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            )
          ],),
        ),
      ),
    );
  }
}