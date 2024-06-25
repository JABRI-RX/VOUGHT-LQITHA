import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lqitha/components/my_button.dart';
import 'package:lqitha/components/my_textfield.dart';
import 'package:lqitha/components/toast.dart';
import 'package:lqitha/dao/models/comment.dart';
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/dao/models/user.dart';
import 'package:lqitha/services/auth/auth_service.dart';
import 'package:lqitha/services/database/firestore.dart';
 
class ListItemDetails extends StatefulWidget {
  String postId;
  ListItemDetails({ super.key,required this.postId });

  @override
  State<ListItemDetails> createState() => _ListItemDetailsState();
}

class _ListItemDetailsState extends State<ListItemDetails> {
  late TextEditingController commentBox ;
  late String userId;

  var firestore_db = FireStoreService();
  late Future<Map<String, dynamic>> _postFuture;
  late Future<Map<String,dynamic>> _usersFurue;
 
  @override
  void initState() {
    super.initState();
    commentBox = TextEditingController();
    _postFuture = firestore_db.getPostById(widget.postId);
    _usersFurue = _getUserMap();
    userId = AuthService().getCurrentUser()!.uid;
  }
  Future<Map<String,dynamic>> _getUserMap() async{
    List<CUser> users = await firestore_db.getUsers();
    Map<String,String> userMap = {};
    for(CUser user in users){
      userMap[user.userid] = user.username;
    }
    return userMap;
  }
  void postComment(String postId,String content)  {
    try{
      firestore_db.createComment(userId, postId, content)
      .then((onValue)=>{
        showToast(context,"Comment Added "),
        setState(() {
          _postFuture = firestore_db.getPostById(widget.postId); 
        })
      },
      onError: (e){
        showToast(context, e);
      }
      );
      
    }
    catch(e){
      log("Post Comment error $e");
    }
  }
  @override
  Widget build(BuildContext context){
    Color blueColor = Theme.of(context).colorScheme.secondary;
    double fontSize = 18;
    return   SingleChildScrollView(
      child: Padding(
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
                  // log(snapshot.data![0].toString());
                  Post p =  snapshot.data![0]["data"] as Post;
                  //we need this to modify the collection for some werid fucking reason 
                  //I hate firebase only good for login bad for others
                  String PostFireBaseID = snapshot.data![0]["id"].toString();
                  
                  Map<String,dynamic> userMap = snapshot.data![1] as Map<String,dynamic>;
                  String name= p.name ?? "";
                  String description= p.description ?? "";
                  String location= p.location ?? "";
                  String phone= p.phone ?? "";
                  String userName =  userMap[p.userId];
                  DateTime dateLost =   p.dateLost ?? DateTime(1999);
                  List<Comment> comments = p.comments ?? [];
 
                  log("result : ${userId} == ${p.userId} ${userId == p.userId}");
                  // log(snapshot.data![1].toString());
                  return Container(
                    child: Column(
                      children: [
                        //title 
                        Column(
                          children: [
                              Text("Name : ",
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                              Text(name  ,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        //descrption
                        Column(
                          children: [
                              Text("Description : ",
                             
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                              Text(description ,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        //location
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                              Text("location : ",
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                              Text(location  ,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        //phone
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                              Text("Phone : ",
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                              Text(phone  ,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        //dateLost
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                              Text("Date Lost : ",
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                              Text(dateLost.toString().split(" ")[0]  ,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        //Created By
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                              Text("Created By : ",
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                              Text(  userId == p.userId ? "You":userName,
                              style: TextStyle(
                                fontSize: fontSize,
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
                        //add comments
                        MyTextfield(
                            controller: commentBox,
                            color: blueColor,
                            obsecureText: false,
                            hintText: "Comment",
                            padding: 0,
                        ),
                        const SizedBox(height: 10,),
                        MyButton(
                          text: "Post Comment",
                          onTap: (){
                            postComment(PostFireBaseID,commentBox.text.trim());
                          },
                          bgcolor: blueColor,
                          fgcolor: Theme.of(context).colorScheme.inversePrimary,
                          padding: 20,
                          
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
                                          userId == comment.userId
                                          ? "You"
                                          : userMap[comment.userId],
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
      ),
    );
  }
}