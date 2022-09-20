
import 'dart:convert';

Token tokenFromJson(String str) =>
    Token.fromJson(json.decode(str));

class Token {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? userName;
  String? issued;
  String? expires;
  String? roleName;
  String? userID;

  Token(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.userName,
      this.issued,
      this.expires,
      this.roleName,
      this.userID});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    userName = json['userName'];
    issued = json['.issued'];
    expires = json['.expires'];
    roleName = json['RoleName'];
    userID = json['User ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['userName'] = this.userName;
    data['.issued'] = this.issued;
    data['.expires'] = this.expires;
    data['RoleName'] = this.roleName;
    data['User ID'] = this.userID;
    return data;
  }
}