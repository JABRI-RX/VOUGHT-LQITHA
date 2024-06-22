 

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lqitha/components/logo.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_textfield.dart';
import 'package:lqitha/pages/login_page.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/themes/light_mode.dart';
 
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
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedpasswordController = TextEditingController();
  void showToast(String text){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text(text,
        style: TextStyle(color: UIColors.white),  
          )
        )
      );
  }
  void register() async{
    
    //check if textfields are populated
    if( userNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty || 
        confirmedpasswordController.text.isEmpty
        ){
         showToast("Some Fields Are Empty");
        }
    //check if password match 
    if(passwordController.text != confirmedpasswordController.text){
      showToast("The passwords Do not Match.");
      return;
    }
    //get auth serice
    final _authService = AuthService();
    //create user
    try{
      await _authService.signUp(
        userNameController.text.trim(),
        emailController.text.trim(), 
        passwordController.text.trim()
        );
        print(_authService.getCurrentUser()?.displayName);
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
      showToast(result);
    }
    catch(e){
 
     showToast(e.toString());
    }
 
     
  }
  void forgotPassword() async{

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