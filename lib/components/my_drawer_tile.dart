import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final void Function()? onTap;
  const MyDrawerTile({
     super.key ,
     required this.text,
     required this.icon,
     required this.color,
       this.onTap
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: color,fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          icon,
          color: color,
        ),
        onTap: onTap,
      ),
    );
  }
}