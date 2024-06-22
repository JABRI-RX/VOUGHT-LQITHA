import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final Function()? onTap;
  final String text;
  final Color bgcolor;
  final Color fgcolor;
  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.bgcolor,
    required this.fgcolor,
  });
  @override
  Widget build(BuildContext context) {
     
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal:25),
        decoration: BoxDecoration(color:bgcolor,borderRadius: BorderRadius.circular(10)),
        child: 
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: fgcolor,
                fontSize: 16
              ),
            ),
        ),
      ),
    );
  }
}