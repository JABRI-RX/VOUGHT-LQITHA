import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
 
ThemeData light_mode = ThemeData(
  colorScheme:   const ColorScheme.light(
    surface:  Color(0xFF9bf404), 
    primary: Color(0xFFffeb00),
 
    secondary: Color(0xFF24d8e7),
    tertiary: Color(0xFFce2278),
    inversePrimary: Colors.white
    ),
  
);
class UIColors{
  static const Color red = Color(0xFFe06b74);
  static const Color green = Color(0xFF98c379);
  static const Color blue = Color(0xFF61AFEF);
  static const Color yellow = Color(0xFFE5c07b);
  static const Color black = Color(0xFF282c34);
  static const Color white = Color(0xFFffFFFF);
  static const Color purple  = Color(0xFF66489f);
}