import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunmstagram/models/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<MyUser>> streamGetAllUser() {
    return _db.collection('userData').snapshots().map(
        (docs) => docs.docs.map((doc) => MyUser.fromFirestore(doc)).toList());
  }
}
