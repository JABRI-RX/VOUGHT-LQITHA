import 'dart:developer';

import 'package:flutter/material.dart';
 
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/services/database/firestore.dart';
 
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
  late Future<List<Post>> _postsFuture;
  
  @override
  void initState() {
 
    super.initState();
    userId = authService.getCurrentUser()?.uid;
    _postsFuture = db.getPostsFromDatabase(userId!);

  }
  void loadData(){
    // print(_postsFuture.)
  }
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        FutureBuilder(
          future: _postsFuture,
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasError){
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
 
            else{
              List<Post> posts = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context,index){
                    Post p = posts[index];
                    return  ListTile(
                      leading: const Icon(Icons.inbox),
                      title: Text(p.name ?? "No Title"),
                        subtitle: Text(p.description ?? "No description"),
                    );
                  }
                ),
              );
            }
          }
        )
      ],
    );
  }
}