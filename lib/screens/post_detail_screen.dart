import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  Widget build(BuildContext context) {
    CollectionReference post = FirebaseFirestore.instance.collection('post');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: post.doc(docId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(child: Text("${data['title']} ${data['contents']}"));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
