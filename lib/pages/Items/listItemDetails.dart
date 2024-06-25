import 'package:flutter/material.dart';
import 'package:lqitha/dao/models/comment.dart';
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/services/database/firestore.dart';
import 'package:lqitha/themes/light_mode.dart';

class ListItemDetails extends StatefulWidget {
  String postId;
  ListItemDetails({ super.key,required this.postId });

  @override
  State<ListItemDetails> createState() => _ListItemDetailsState();
}

class _ListItemDetailsState extends State<ListItemDetails> {
  var postdb = FireStoreService();
  late Future<Post> _postFuture;
  @override
  void initState() {
    super.initState();
    _postFuture = postdb.getPostById(widget.postId);
  }
  @override
  Widget build(BuildContext context){
    return   Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
           FutureBuilder(
            future: _postFuture,
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }
              else if(snapshot.hasError){
                return Center(
                  child: Text("Error :${snapshot.error}") ,
                );
              }
              else{
                String id = snapshot.data?.id ?? "";
                String name= snapshot.data?.name ?? "";
                String description= snapshot.data?.description ?? "";
                String location= snapshot.data?.location ?? "";
                String phone= snapshot.data?.phone ?? "";
                DateTime dateLost =   snapshot.data?.dateLost ?? DateTime(1999);
                List<Comment> comments = snapshot.data?.comments ?? [];
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
                      //locaiton
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
                                      trailing: const Text("user",style: TextStyle(fontSize: 15),),
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