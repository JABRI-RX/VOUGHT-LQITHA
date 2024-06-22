import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
const Logo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: const Image(
        image: AssetImage('assets/images/logo.png'),
        width: 150,
      )
    );
  }
}