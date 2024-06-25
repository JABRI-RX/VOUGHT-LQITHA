 
 
import 'package:flutter/material.dart';
import 'package:lqitha/components/Toast.dart';
import 'package:lqitha/components/logo.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_textfield.dart';
import 'package:lqitha/pages/forgot_password.dart';
import 'package:lqitha/pages/home.dart';
 
import 'package:lqitha/services/auth/auth_service.dart';
 
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
 
  const LoginPage({super.key,   this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController ;
  late TextEditingController passwordController;
 
  void login() async{
    //validation
    if( emailController.text.isEmpty || 
        passwordController.text.isEmpty){
        showToast(context,"Some Fields Are Empty.");
        return;
    }
    // Authentication logic here
    final authService = AuthService();
 
    try{
     
      //signin 
      await authService.signIn(
        emailController.text.trim(), 
        passwordController.text.trim()
        );
      if(mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>   Home()));
      }
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
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Color whiteColor = Theme.of(context).colorScheme.inversePrimary;
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
                const Logo(),
                //message, app slogan
                Text(
                  "Missing Items Report App",
                  style: TextStyle(
                    fontSize: 16,
                    color: whiteColor,
                  ),
                ),
                //email textfield
                const SizedBox(height: 20),
                MyTextfield(
                    controller: emailController,
                    hintText: "Email",
                    color: whiteColor,
                    obsecureText: false),
                //password textfield
                const SizedBox(height: 20),
                MyTextfield(
                    controller: passwordController,
                    hintText: "Password",
                    color: whiteColor,

                    obsecureText: true),
                //sign in button
                const SizedBox(height: 20),
                MyButton(
                  text: "Sign In",
                  onTap: login,
                  bgcolor:whiteColor,
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
                          color: whiteColor),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: whiteColor,
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
                          color: whiteColor),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: (){
                   Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword()), 
                            // (route) => false
                          );
                      },
                      child: Text(
                        "Click Here",
                        style: TextStyle(
                            color: whiteColor,
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
