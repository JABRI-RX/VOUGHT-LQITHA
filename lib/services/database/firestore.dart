 

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lqitha/dao/models/post.dart';

class FireStoreService{
  final CollectionReference postsDB = FirebaseFirestore.instance.collection("posts");
  //save Post To Database
  Future<void> savePostToDatabase(Post p) async{
    await postsDB.add({
        'posts':p.toJson()
      }
    );
  }
  Future<List<Post>> getPostsFromDatabase(String userId) async{
    try{
      QuerySnapshot querySnapshot = await postsDB
        // .where('userId',isEqualTo: userId)
        .get();
      //shit
      List<Post> posts = querySnapshot.docs.map((doc){
        return Post.fromJson(doc.data() as Map<String,dynamic>);
      }).toList();
 
      return posts;
    }
    catch(e){
      log(e.toString());
      return [];
    }
  }
}