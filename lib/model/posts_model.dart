// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

List<Posts> postsFromJson(String str) =>
    List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posts {
  Posts({
    required this.id,
    required this.userId,
    required this.userName,
    required this.time,
    required this.header,
    required this.text,
  });

  int id;
  String userId;
  String userName;
  String time;
  String header;
  String text;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        id: json["ID"],
        userId: json["UserID"],
        userName: json["UserName"],
        time: json["Time"],
        header: json["Header"],
        text: json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "UserID": userId,
        "UserName": userName,
        "Time": time,
        "Header": header,
        "Text": text,
      };
}
