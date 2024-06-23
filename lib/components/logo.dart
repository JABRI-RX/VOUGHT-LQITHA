import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
const Logo({ super.key });

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