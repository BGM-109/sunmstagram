import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? userName;
  final String? profileImage;

  User({this.userName, this.profileImage});

  factory User.fromMap(Map data) {
    data = data ?? {};
    return User(
      userName: data['userName'] ?? '',
      profileImage: data['profileImage'] ?? '',
    );
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<dynamic, dynamic> data = doc.data as Map<dynamic, dynamic>;
    return User(
      userName: data['userName'] ?? '',
      profileImage: data['profileImage'] ?? '',
    );
  }
}
