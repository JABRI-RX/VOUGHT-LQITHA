 
import 'dart:developer';
 
import 'package:flutter/material.dart';
 
import 'package:lqitha/dao/models/comment.dart';
import 'package:uuid/uuid.dart';

class Post extends ChangeNotifier{
  //uuid
  var _uuid =   const Uuid();
  String? id;
  String? name;
  String? description;
  String? location;
  String? phone;
  DateTime? dateLost;
  String? userId;
  List<Comment>   _comments = [];

  Post({
    this.id,
    this.name,
    this.description,
    this.location,
    this.phone,
    this.dateLost,
    this.userId,
  }){
    id = id ?? _uuid.v4();
  }
  //getters
  List<Comment> get comments => _comments;
  set comments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }
  //factory fromJson 
   factory Post.fromJson(Map<String, dynamic> json) {
    List<Comment> jsonComment = [];
 
 
    for(dynamic rawComment in json["comments"] as List<dynamic>){
      jsonComment.add(Comment(
        commentId: rawComment["commentId"],
        userId: rawComment["userId"],
        postId: rawComment["postId"],
        content: rawComment["content"],
        timestamp: DateTime.parse(rawComment["timestamp"]),
      ));
    }
     
    Post p = Post(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      location: json["location"],
      phone: json['phone'],
      dateLost:  DateTime.parse(json['dateLost']) ,
      userId: json['userId'],
    );
    //we add comments I Dont fucking now Why this hack exsis
    p.addComments(jsonComment);
    return p;
  }
  //post
  void addComments(List<Comment> commends){
    comments = commends;
  }
  //toson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location':location,
      'phone': phone,
      'dateLost': dateLost?.toString(),
      'userId': userId,
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
  //tostring
  @override
  String toString(){
    StringBuffer res=  StringBuffer();
    res.writeln("id $id");
    res.writeln("name $name");
    res.writeln("description $description");
    res.writeln("description $location");
    res.writeln("phone $phone");
    res.writeln("dateLost ${dateLost?.toString()}");
    res.writeln("userId $userId");
    res.writeln("comments: [ ");
 
    for(Comment comment in comments){
 
      res.writeln("\tcomment id ${comment.commentId}");
      res.writeln("\tuserId id ${comment.userId}");
      res.writeln("\titemId id ${comment.postId}");
      res.writeln("\tcontent id ${comment.content}");
      res.writeln("\ttimestamp id ${comment.timestamp}");
    }
    res.writeln("] ");
    return res.toString();
  }
   
}
