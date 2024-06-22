
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 
import 'package:lqitha/services/auth/auth_gate.dart';
import 'package:lqitha/themes/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      //Themeprovider
      ChangeNotifierProvider(create: (context) => ThemeProvider(),),
    ],
    child: MyApp(),
    )
  );
}
class MyApp extends StatelessWidget {
const MyApp({ super.key });

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themedata,
    );
  }
}