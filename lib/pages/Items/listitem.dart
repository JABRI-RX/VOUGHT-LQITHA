import 'dart:developer';

import 'package:flutter/material.dart';
 
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/pages/Items/detailsItem.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/services/database/firestore.dart';
import 'package:lqitha/themes/light_mode.dart';
 
class ListItem extends StatefulWidget {
const ListItem({ super.key });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  //get userId
  final authService = AuthService();
  //store 
  final db = FireStoreService();
  late String? userId;
  late Future<List<Map<String,dynamic>>> _postsFuture;
  
  @override
  void initState() {
 
    super.initState();
    userId = authService.getCurrentUser()?.uid;
    _postsFuture = db.getPostsByUserId(userId!);

  }
  void loadData(){
    // print(_postsFuture.)
  }
  @override
  Widget build(BuildContext context){
    Color color = Theme.of(context).colorScheme.inversePrimary;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          FutureBuilder(
            future: _postsFuture,
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.data!.isEmpty == true){
                return Center(
                  child: Text("You Have no Items"),
                );
              }
              else if (snapshot.hasError){
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              else{
                List<Map<String, dynamic>> posts = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context,index){
                      Post p = posts[index]["data"];
                      log("Post in list item is ${p.id}");
                      return  Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading:   Icon(Icons.inbox,color: color,),
                          
                          title: Text(p.name ?? "No Title",
                            style: TextStyle(color: color),
                          ),
                          subtitle: Text(p.description ?? "No description",
                            style: TextStyle(color: color),
                          ),
                          trailing: Icon(Icons.arrow_right_alt ,color: color, ),
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context)=> DetailsItem(postId:p.id!))
                            );
                          },
                        ),
                      );
                    }
                  ),
                );
              }
            }
          )
        ],
      ),
    );
  }
}