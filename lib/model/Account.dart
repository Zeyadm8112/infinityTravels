// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

List<Account> accountFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  });

  String id;
  String userName;
  String email;
  String? phoneNumber;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["Id"],
        userName: json["UserName"],
        email: json["Email"],
        phoneNumber: json["PhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Email": email,
        "PhoneNumber": phoneNumber,
      };
}
