class Post {
  String userID;
  String title;
  String content;

  Post(this.userID, this.title, this.content);

  Post.fromJson(Map<String, dynamic> json)
    : userID = json['userID'],
      title = json['title'],
      content = json['content'];

  Map<String, dynamic> toJson() => {
    'userID' : userID,
    'title' : title,
    'content' : content,
  };
}