import 'package:flutter/material.dart';
import 'package:lqitha/themes/light_mode.dart';

void showToast(BuildContext context, String text){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text(text,
        style: TextStyle(color: UIColors.white),  
          )
        )
      );
  }