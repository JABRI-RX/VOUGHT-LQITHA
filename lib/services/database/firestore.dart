import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lqitha/dao/models/post.dart';

class FireStoreService{
  final CollectionReference postsDB = FirebaseFirestore.instance.collection("posts");
  //save Post To Database
  Future<void> savePostToDatabase(Post p) async{
    await postsDB.add({
        'data':DateTime.now(),
        'posts':p.toJson()
      }
    );
  }
  Future<List<Post>> getPostsFromDatabase(String userId) async{
    try{
      QuerySnapshot querySnapshot = await postsDB
        // .where('userId',isEqualTo: userId)
        .get();
      print("---------------------------");
 
      List<Post> posts = querySnapshot.docs.map((doc){
        
        print(doc.data());
        print("---------------------------");

        Post p = Post.fromJson(doc.data() as Map<String,dynamic>);
        // Map<String, dynamic> json = doc.data() as Map<String,dynamic>;
        print(p);
        return Post();
      }).toList();

      return posts;
    }
    catch(e){
      print(e);
      return [];
    }
  }
}