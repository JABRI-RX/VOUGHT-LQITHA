import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/services/database/firestore.dart';
import 'package:lqitha/themes/light_mode.dart';

class DeleteItem extends StatefulWidget {
const DeleteItem({ super.key });

  @override
  State<DeleteItem> createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {
  //get userId
  final authService = AuthService();
  //store 
  final db = FireStoreService();
  late String? userId;
  late Future<List<Map<String,dynamic>>> _postsFuture;

  void deletePostById(String postId) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title:const Text("Are you sure you want to delete this item ? ") ,
        actions: [
          //no
          TextButton(
            onPressed: (){
            Navigator.pop(context);
            },
            child: Text("No",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary
              ),
            )
          ),
          //yes
          TextButton(
            onPressed: () async{
              log(postId);
               await db.deletePostById(postId);
               setState(() {
                _postsFuture = db.getPostsByUserId(userId!);
                Navigator.pop(context);
              });
            },
            child: Text("Yes",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary
              ),
            )
          ),
        ],
      );
    });
   
    
  }
  @override
  void initState() {
 
    super.initState();
    userId = authService.getCurrentUser()?.uid;
    _postsFuture = db.getPostsByUserId(userId!);

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
                return const Center(
                  child: Text("You Have no Items"),
                );
              }
              else if (snapshot.hasError){
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              else{
                log(snapshot.data.toString());
                List<Map<String,dynamic>> posts = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context,index){
                      String docId = posts[index]['id'];
                      Post p = posts[index]["data"];

                      // log("Post in list item is ${p.id}");
                      return  Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: UIColors.red,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          leading:   Icon(Icons.delete,color: color,),
                          
                          title: Text(p.name ?? "No Title",
                            style: TextStyle(color: color),
                          ),
                          subtitle: Text(p.description ?? "No description",
                            style: TextStyle(color: color),
                          ),
                          // trailing: Icon(Icons.delete ,color: color, ),
                          onTap: () {
                            deletePostById(docId);
                            
                            // Navigator.push(
                            //   context, 
                            //   MaterialPageRoute(
                            //     builder: (context)=> DetailsItem(postId:p.id!))
                            // );
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