import 'package:flutter/material.dart';
import 'package:lqitha/themes/light_mode.dart';
class MyTextfield extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final Color color;
  final double? padding;
  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText, required this.color, 
    this.padding,   
  });
  @override
  Widget build(BuildContext context) {
     // TODO: implement build
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: padding ?? 25.0),
      child: TextField(
 
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color:color),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color)
          ),
          hintText:hintText,
          hintStyle: TextStyle(color:color) 
        ),
        style: TextStyle(color: UIColors.black),
      ),
    );
  }
}