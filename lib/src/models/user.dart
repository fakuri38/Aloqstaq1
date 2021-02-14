import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

enum UserState { available, away, busy }

class User {
  String id = UniqueKey().toString();
  String name;
  String email;
  String gender;
  String password;
  String token;
  DateTime dateOfBirth;
  String avatar;
  String address;
  String username;
  String verified = '';
  UserState userState;
  bool auth;
  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      username = jsonMap['username'] != null ? jsonMap['username'] : '';
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      password = jsonMap['password'] != null ? jsonMap['password'] : '';
      token = jsonMap['token'] != null ? jsonMap['token'] : '';
      verified = jsonMap['email_verified_at'] != null
          ? jsonMap['email_verified_at']
          : '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map['username'] = username;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["token"] = token;
    map["email_verified_at"] = verified;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

  User.init();

  User.basic(this.name, this.avatar, this.userState);

  User.advanced(this.name, this.email, this.gender, this.dateOfBirth,
      this.avatar, this.address, this.userState);

  User getCurrentUser() {
    return User.advanced(
        'Andrew R. Whitesides',
        'andrew@gmail.com',
        'Male',
        DateTime(1993, 12, 31),
        'img/user2.jpg',
        '4600 Isaacs Creek Road Golden, IL 62339',
        UserState.available);
  }

  getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth);
  }
}
