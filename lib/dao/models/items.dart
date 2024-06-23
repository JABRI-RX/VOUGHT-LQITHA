 

import 'package:flutter/material.dart';
import 'package:lqitha/dao/models/post.dart';

class Items extends ChangeNotifier{
  final List<Post> _posts = [
    
  ];
  //getters
  List<Post> get posts => _posts;
  //setter
  //operations
  //add post
  void AddPost(Post p){
    _posts.add(
      p
    );
    notifyListeners();
  }
  //edit post
  //TODO add edit post
  void editPost(String id,Post p){
    return;
  }
  //remove post
  void removePostById(String id){
    for(var i=0;i<_posts.length;i++){
      if(_posts[i].id == id){
        _posts.removeAt(i);
      }
    }
    notifyListeners();

  }
}