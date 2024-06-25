 

import 'dart:developer';
 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lqitha/dao/models/comment.dart';
 
import 'package:lqitha/dao/models/post.dart';
import 'package:lqitha/dao/models/user.dart';

class FireStoreService{
  final CollectionReference postsDB = FirebaseFirestore.instance.collection("posts");
  final CollectionReference usersDB = FirebaseFirestore.instance.collection("users");
  //save Post To Database
  Future<void> savePostToDatabase(Post p) async{
    await postsDB.add(p.toJson());
  }
  Future<void> deletePostById(String docpostId) async{
    try{
      await postsDB.doc(docpostId).delete().then(
        (doc)=> log("Post With Is $docpostId has been deleted f"),
        onError: (e)=>log("Error updating document $e")
        );
      
    }
    catch(e){
      log("Error deleting post: $e");
    }
  }
  Future<List<Map<String,dynamic>>> getPostsByUserId(String userId) async{
    try{
 
      QuerySnapshot querySnapshot = await postsDB
        .where('userId',isEqualTo: userId)
        .get();
      //shit
      List<Map<String,dynamic>> posts = querySnapshot.docs.map((doc){
        return {
          'id':doc.id,
          'data':Post.fromJson(doc.data() as Map<String,dynamic>)
        };
      }).toList();
  
      return posts;
    }
    catch(e){
      log("fireStore getPostsByUserId error ${e.toString()}");
      return [];
    }
  }
  Future<List<Map<String,dynamic>>> getPostsByName(String postName) async{
    try{
      QuerySnapshot querySnapshot = await postsDB
      .orderBy("name")
      .startAfter([postName])
      .endAt(['$postName\uf8ff'])
      .get();
      List<Map<String,dynamic>> posts = querySnapshot.docs.map((doc){
        return {
          'id':doc.id,
          'data':Post.fromJson(doc.data() as Map<String,dynamic>)
        };
      }).toList();
      return posts;
    }
    catch(e){
      log("firestore getPostsByName error ${e.toString()}");
      return [];
    }
  }
  Future<Map<String,dynamic>> getPostById(String postId) async{
    try{
 
      QuerySnapshot querySnapshot = await postsDB
        .where('id',isEqualTo:postId)
        .get();

      List<Map<String,dynamic>> posts = querySnapshot.docs.map((doc){
        return {
          'id':doc.id,
          'data':Post.fromJson(doc.data() as Map<String,dynamic>)
        };
      }).toList();

      return posts[0];
    }
    catch(e){
      return {};
    }
  }
  //users
  Future<void> createUser(CUser user) async {
    log("FireStore createUser output : ${user.toString()}");
    await usersDB.add(user.toJson()); 
 
  }
  Future<List<CUser>> getUsers() async{
    try{
      QuerySnapshot querySnapshot = await usersDB
      .get();
   
      List<CUser> users = querySnapshot.docs.map((doc){
        return  CUser.fromJson(doc.data() as Map<String,dynamic>);
      }).toList();
      return users;
    }
    catch(e){
      log("firestore getUsers error ${e.toString()}");
      return [];
    }
  }
  //comments
  Future<void> createComment(String userId,String postId,String content) async{
    try{
      Comment comment = Comment(
        userId: userId,
        postId: postId,
        content: content
      );
      postsDB.doc(postId).get().then((post){
        log(post.id);
      });
      await postsDB.doc(postId).update({
        'comments':FieldValue.arrayUnion([comment.toJson()]),
      });
    }
    catch(e){
      log("firestore.createComment error $e");
    }
    
  }
}