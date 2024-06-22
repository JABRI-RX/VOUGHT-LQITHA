import 'package:flutter/material.dart';
 
import 'package:lqitha/dao/models/comment.dart';
import 'package:uuid/uuid.dart';

class Post extends ChangeNotifier{
  //uuid
  var uuid =   const Uuid();
  String? id;
  String? name;
  String? description;
  String? phone;
  DateTime? dateLost;
  String? userId;
  late List<Comment>   comments = [];

  Post({
    this.id,
    this.name,
    this.description,
    this.phone,
    this.dateLost,
    this.userId,
    List<Comment>? comments,
  }): comments = comments ?? [];
  //factory fromJson 
   factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["posts"]['id'],
      name: json["posts"]['name'],
      description: json["posts"]['description'],
      phone: json["posts"]['phone'],
      dateLost: json["posts"]['dateLost'] != null ? DateTime.parse(json["posts"]['dateLost']) : null,
      userId: json["posts"]['userId'],
      comments: (json["posts"]['comments'] as List<dynamic>?)
          ?.map((commentJson) => Comment.fromJson(commentJson))
          .toList() ?? [],
    );
  }
  //post
  void addComment(Comment c){
    comments.add(c);
    notifyListeners();
  }
  //toson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'phone': phone,
      'dateLost': dateLost?.toString(),
      'userId': userId,
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
  //tostring
  String toString(){
    StringBuffer res=  StringBuffer();
    res.writeln("id $id");
    res.writeln("name $name");
    res.writeln("description $description");
    res.writeln("phone $phone");
    res.writeln("dateLost ${dateLost?.toString()}");
    res.writeln("userId $userId");
    res.writeln("comments: ");
    for(Comment comment in comments){
    // String? commentId;
    // String? userId;
    // String? itemId;
    // String? content;
    // DateTime? timestamp  ;
      res.writeln("comment id ${comment.commentId}");
      res.writeln("userId id ${comment.userId}");
      res.writeln("itemId id ${comment.itemId}");
      res.writeln("content id ${comment.content}");
      res.writeln("timestamp id ${comment.timestamp}");
    }
    res.write("end comment");
    return res.toString();
  }
   
}
