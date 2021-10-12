import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? userName;
  final String? profileImage;

  MyUser({this.userName, this.profileImage});

  factory MyUser.fromMap(Map data) {
    data = data ?? {};
    return MyUser(
      userName: data['userName'] ?? '',
      profileImage: data['profileImage'] ?? '',
    );
  }

  factory MyUser.fromFirestore(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data as Map<String, dynamic>;
    return MyUser(
      userName: data['userName'] ?? '',
      profileImage: data['profileImage'] ?? '',
    );
  }
}
