import 'package:uuid/uuid.dart';

class Comment {
  var _uuid = Uuid();
  String? commentId;
  String? userId;
  String? postId;
  String? content;
  DateTime? timestamp  ;

  Comment({
    this.commentId,
    this.userId,
    this.postId,
    this.content,
    this.timestamp,
 
  }){
 
    commentId =  commentId ?? _uuid.v4() ;
    timestamp = DateTime.now();
  }
  //from json
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      userId: json['userId'],
      postId: json['postId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
  //tojson
  Map<String,dynamic> toJson(){
    return {
      'commentId':commentId,
      'userId':userId,
      'postId':postId,
      'content':content,
      'timestamp':timestamp.toString(),
    };
  }
}
