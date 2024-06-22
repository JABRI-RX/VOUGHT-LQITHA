import 'package:flutter/material.dart';
import 'package:lqitha/components/logo.dart';
import 'package:lqitha/components/my_drawer_tile.dart';
 
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/themes/light_mode.dart';

class MyDrawer extends StatefulWidget {
const MyDrawer({ super.key });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void logout(){
    final _authService = AuthService();
    showDialog(
      context: context, 
      builder:(context) {
        return AlertDialog(
          title: const Text("Are you sure want To Sign Out?"),
          actions: [
            //no
            TextButton(
              onPressed: () {
                _authService.signOut();
                Navigator.pop(context);
              }, 
              child:   const Text("Yes",
                style: TextStyle(color: UIColors.black),
              ),
            ) ,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child:   const Text("No",
               style: TextStyle(color: UIColors.black),),
            )
            //yes
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
   Color color = UIColors.white;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          //app logo
          const Padding(
            padding: EdgeInsets.only(top:100.0),
            child: Logo(),
          ),
          //home list tile
          MyDrawerTile(
            text: "Home",
            icon: Icons.home,
            color: color,
            onTap: (){Navigator.pop(context);}
          ),
         
          //logout list tile
          const Spacer(),
          MyDrawerTile(
            text: "Sign Out",
            icon: Icons.logout,
            color: UIColors.red,
            onTap: (){
              logout();
              print("-----------\nlogout");
            }
          )
        ],
      ),
    );
  }
}