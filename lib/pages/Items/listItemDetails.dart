import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lqitha/dao/models/comment.dart';
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/dao/models/user.dart';
import 'package:lqitha/services/database/firestore.dart';
import 'package:lqitha/themes/light_mode.dart';

class ListItemDetails extends StatefulWidget {
  String postId;
  ListItemDetails({ super.key,required this.postId });

  @override
  State<ListItemDetails> createState() => _ListItemDetailsState();
}

class _ListItemDetailsState extends State<ListItemDetails> {
  var firestore_db = FireStoreService();
  late Future<Post> _postFuture;
  late Future<Map<String,dynamic>> _usersFurue;
  @override
  void initState() {
    super.initState();
    _postFuture = firestore_db.getPostById(widget.postId);
    _usersFurue = _getUserMap();
  }
  Future<Map<String,dynamic>> _getUserMap() async{
    List<CUser> users = await firestore_db.getUsers();
 
    Map<String,String> userMap = {};
    for(CUser user in users){
 
      userMap[user.userid] = user.username;
    }
 
    return userMap;
  }
  @override
  Widget build(BuildContext context){
    return   Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
           FutureBuilder(
            future: Future.wait([_postFuture,_usersFurue]),
            builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
              
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }
              else if(snapshot.hasError){
                // log("${snapshot.data![0]}");
                return Center(
                  child: Text("Error in coments :${snapshot.error}") ,
                );
              }
              else{
                 
                Post p =  snapshot.data![0] as Post;
                Map<String,dynamic> userMap = snapshot.data![1] as Map<String,dynamic>;
                String name= p.name ?? "";
                String description= p.description ?? "";
                String location= p.location ?? "";
                String phone= p.phone ?? "";
                DateTime dateLost =   p.dateLost ?? DateTime(1999);
                List<Comment> comments = p.comments ?? [];
                // log(snapshot.data![1].toString());
                return Container(
                  child: Column(
                    children: [
                      //title 
                      Row(
                        children: [
                          const Text("Name : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                            Text(name  ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      //descrption
                      Row(
                        children: [
                          const Text("Description : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                            Text(description  ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      //location
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Text("location : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                            Text(location  ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      //phone
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Text("Phone : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                            Text(phone  ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      //dateLost
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Text("Date Lost : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                            Text(dateLost.toString().split(" ")[0]  ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      //comments
                      const SizedBox(height: 20,),
                      Text("Comments",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary
                        ),
                      ),
                      const SizedBox(height: 10,),
                      for(Comment comment in comments) ...[
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondary,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ListTile(
                                      title: Text(comment.content.toString()),
                                      trailing: Text(
                                        userMap[comment.userId] ?? "Unknown User",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,)
                          ],
                        )
                      ]
                    ],
                  ),
                );
              
              }
            })
        ],
      ),
    );
  }
}