import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String password;
  String email;
  String title;
  String username;
  String name;
  String profileImg;
  String uid;
  List followers;
  List following;
  String pushToken;
  String lastActive;
  bool isOnline;
  String createdAt;
  String about;

  UserData({
    required this.email,
    required this.password,
    required this.title,
    required this.username,
    required this.profileImg,
    required this.uid,
    required this.followers,
    required this.following,
    required this.name,
    required this.pushToken,
    required this.lastActive,
    required this.isOnline,
    required this.createdAt,
    required this.about,
  });

// To convert the UserData(Data type) to Map<String, object>
  Map<String, dynamic> convert2Map() {
    return {
      "password": password,
      "email": email,
      "title": title,
      "username": username,
      "name": name,
      "profileImg": profileImg,
      "uid": uid,
      "followers": [],
      "following": [],
      "pushToken": pushToken,
      "lastActive": lastActive,
      "isOnline": isOnline,
      "createdAt": createdAt,
      "about": about,
    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
      password: snapshot["password"],
      email: snapshot["email"],
      title: snapshot["title"],
      name: snapshot["name"],
      username: snapshot["username"],
      profileImg: snapshot["profileImg"],
      uid: snapshot["uid"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      pushToken: snapshot["pushToken"],
      lastActive: snapshot["lastActive"],
      isOnline: snapshot["isOnline"],
      createdAt: snapshot["createdAt"],
      about: snapshot["about"],
    );
  }

  Map<String, dynamic> toJson() {
    final dataa = <String, dynamic>{};
    dataa['profileImg'] = profileImg;
    dataa['about'] = about;
    dataa['name'] = name;
    dataa['created_at'] = createdAt;
    dataa['is_online'] = isOnline;
    dataa['uid'] = uid;
    dataa['last_active'] = lastActive;
    dataa['email'] = email;
    dataa['push_token'] = pushToken;
    dataa['password'] = password;
    dataa['title'] = title;
    dataa['username'] = username;
    dataa['followers'] = followers;
    dataa['following'] = following;

    return dataa;
  }
}

//*******Google Sing In */

class ChatUser {
  ChatUser(
      {required this.email,
      required this.password,
      required this.title,
      required this.username,
      required this.profileImg,
      required this.uid,
      required this.followers,
      required this.following,
      required this.name,
      required this.pushToken,
      required this.lastActive,
      required this.isOnline,
      required this.createdAt,
      required this.about});
  late String password;
  late String email;
  late String title;
  late String username;
  late String name;
  late String profileImg;
  late String uid;
  late List followers;
  late List following;
  late String pushToken;
  late String lastActive;
  late bool isOnline;
  late String createdAt;
  late String about;

  ChatUser.fromJson(Map<String, dynamic> json) {
    profileImg = json['profileImg'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    isOnline = json['is_online'] ?? '';
    uid = json['uid'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    title = json['title'] ?? '';
    username = json['username'] ?? '';
    pushToken = json['push_token'] ?? '';
    followers = json['followers'] ?? [];
    following = json['following'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final dataa = <String, dynamic>{};
    dataa['profileImg'] = profileImg;
    dataa['about'] = about;
    dataa['name'] = name;
    dataa['created_at'] = createdAt;
    dataa['is_online'] = isOnline;
    dataa['uid'] = uid;
    dataa['last_active'] = lastActive;
    dataa['email'] = email;
    dataa['push_token'] = pushToken;
    dataa['password'] = password;
    dataa['title'] = title;
    dataa['username'] = username;
    dataa['followers'] = followers;
    dataa['following'] = following;

    return dataa;
  }
}
