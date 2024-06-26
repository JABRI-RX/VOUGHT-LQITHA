 
 
import 'package:flutter/material.dart';
import 'package:lqitha/components/logo.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_textfield.dart';
 
 
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/themes/light_mode.dart';
 

class ForgotPassword extends StatefulWidget {
 
 
  const ForgotPassword({super.key,   });

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
 
  void showToast(String text){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text(text,
        style: TextStyle(color: UIColors.white),  
          )
        )
      );
  }
  void forgotPassword() async{
    final _authService = AuthService();
    if(emailController.text.isEmpty){
      showToast("The Email Field Is Empty");
    }
    //
    try{
      await _authService.resetPassword(emailController.text.trim());
      showToast("If You Have An Account Then A Pass ResetLink will be been Sent To Your Email");
    }
    catch(e){
      showToast(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    Color white_color = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                  "Forgot Password",
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
                //sign in button
                const SizedBox(height: 20),
                MyButton(
                  text: "Forgot Passowrd",
                  onTap: forgotPassword,
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
                      onTap: (){
                        Navigator.pop(context);
                        // Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate)
                      } ,
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                            color: white_color,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                //forgot password
                //not a member
 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
