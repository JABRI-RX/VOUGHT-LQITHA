import 'package:flutter/material.dart';
import 'package:lqitha/components/logo.dart';
 
import 'package:lqitha/components/my_drawer_tile.dart';
import 'package:lqitha/pages/Items/AddItem.dart';
import 'package:lqitha/pages/Items/deleteItem.dart';
import 'package:lqitha/pages/Items/findItem.dart';
import 'package:lqitha/pages/Items/listitem.dart';
import 'package:lqitha/pages/Items/updateItem.dart';
import 'package:lqitha/pages/Settings.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/themes/light_mode.dart';

class Home extends StatefulWidget {
  late Color color ;
  late List<MyDrawerTile> drawerItem ;
  Home({ super.key }){
    color = UIColors.white;
    drawerItem = [
    //add Missing item,
    MyDrawerTile(
      text: "Add An Item",
      icon: Icons.add,
      color: color,
      onTap: (){}
    ),
    //update missing item
      MyDrawerTile(
      text: "Update My Items",
      icon: Icons.update,
      color: color,
      onTap: (){}
    ),
    //delete missing item
      MyDrawerTile(
      text: "Delete My Items",
      icon: Icons.delete,
      color: color,
      onTap: (){}
    ),
    //find mssing Item
    MyDrawerTile(
      text: "Find An Item",
      icon: Icons.search,
      color: color,
      onTap: (){}
    ),
    MyDrawerTile(
      text: "List My Items",
      icon: Icons.list,
      color: color,
      onTap: (){}
    ),
    
    //settings list tile
      MyDrawerTile(
      text: "Settings",
      icon: Icons.settings,
      color: color,
      onTap: (){}
    ),
   
    //settings list tile
      MyDrawerTile(
      text: "Sign Out",
      icon: Icons.logout,
      color: color,
      onTap: (){}
    ),
  ];
  } 

  @override
  State<Home> createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  var authService = AuthService();
  //drawer
  int _selectedDrawerIndex = 0;
  _getDrawerItemWiget(int pos){
    switch(pos){
      //add item
      case 0:
        return const AddItem();
      //update item
      case 1:
        return const UpdateItem();
      //delete item
      case 2:
        return const DeleteItem();
      //find item
      case 3:
        return const FindItem();
      //list items
      case 4:
        return const ListItem();
      //setting
      case 5:
        return const Settings();
      //sign out:
 
      //error
      default:
      return const Center(
        child: Text("Logout  ",
          style: TextStyle(fontSize: 50),
        ),
      );
    }
  }
  _onSelectItem(int index){
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.pop(context);
  }
  
  void logout(){
    final authService = AuthService();
    showDialog(
      context: context, 
      builder:(context) {
        return AlertDialog(
          title: const Text("Are you sure want To Sign Out?",
              
          ),
          actions: [
            //no
            TextButton(
              onPressed: () async {
                await authService.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              }, 
              child: Text("Yes",
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary,)
                ),
            ) ,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child:   Text("No",
                 style: TextStyle(color: Theme.of(context).colorScheme.secondary,) ,
                ),
            )
            //yes
          ],
        );
      },);
  }
  @override
  Widget build(BuildContext context){
    var drawerOptions = <Widget>[];
    drawerOptions.add(
      //app logo
      const Padding(
        padding: EdgeInsets.only(top:100.0),
        child: Logo(),
      ),
    );
    for(var i =0; i<widget.drawerItem.length ;i++){
      var d = widget.drawerItem[i];
      bool isLast = i == widget.drawerItem.length -1;
      drawerOptions.add(
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child:   ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: Icon(d.icon,color: UIColors.white,),
            title: Text(d.text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: UIColors.white
              ),
            ),
            selected: i == _selectedDrawerIndex,
            selectedTileColor: isLast? UIColors.red: UIColors.blue,
            onTap: (){
              _onSelectItem(i);
              if(isLast){
                logout();
              }
              
            },
          ),
        )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title:  Text("Welcome Back ${authService.getCurrentUser()!.displayName}",
          style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.inversePrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: drawerOptions,
        ),
      ),
      // drawer: MyDrawer(),
      body: _getDrawerItemWiget(_selectedDrawerIndex),
    );
  }
}