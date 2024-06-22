import "package:flutter/material.dart";
import 'package:lqitha/themes/dark_mode.dart';
import 'package:lqitha/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = light_mode;
  ThemeData get themedata => _themeData;

  bool get isDarkMode => _themeData == dark_mode;
  set themeData(ThemeData themedata){
    _themeData = themedata;
    notifyListeners();
  }
  void toggleTheme(){
    if(_themeData == light_mode){
      themeData = dark_mode;
    }else{
      themeData = light_mode;
    }
  }
}