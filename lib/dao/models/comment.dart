class Comment {
  String? commentId;
  String? userId;
  String? itemId;
  String? content;
  DateTime? timestamp  ;

  Comment({
    this.commentId,
    this.userId,
    this.itemId,
    this.content,
    this.timestamp,
 
  });

  void addComment() {}
  void viewComment() {}
  void deleteComment() {}
  //from json
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json["comments"]['commentId'],
      userId: json["comments"]['userId'],
      itemId: json["comments"]['itemId'],
      content: json["comments"]['content'],
      timestamp: json["comments"]['timestamp'] != null
          ? DateTime.parse(json["comments"]['timestamp'])
          : null,
    );
  }
  //tojson
  Map<String,dynamic> toJson(){
    return {
      'commentId':commentId,
      'userId':userId,
      'itemId':itemId,
      'content':content,
      'timestamp':timestamp,
    };
  }
}
