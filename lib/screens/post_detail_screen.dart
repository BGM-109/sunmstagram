import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sunmstagram/components/post_detail_icon.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  Widget build(BuildContext context) {
    CollectionReference post = FirebaseFirestore.instance.collection('post');
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("탐색 탭", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
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
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(data['userProfileUrl']),
                  ),
                  title: Row(
                    children: const [
                      Text("realyoonchang",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("팔로우", style: TextStyle(color: Colors.blue))
                    ],
                  ),
                  subtitle: Text("짐박스"),
                  trailing: Icon(Icons.more_horiz),
                ),
                AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      data['photoUrl'],
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          PostDetailIcon(icon: FontAwesomeIcons.heart),
                          PostDetailIcon(icon: FontAwesomeIcons.comment),
                          PostDetailIcon(icon: FontAwesomeIcons.paperPlane),
                        ],
                      ),
                      const PostDetailIcon(icon: FontAwesomeIcons.bookmark),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("님외 1278명이 좋아합니다."),
                      Text("userId postContent 더보기")
                    ],
                  ),
                )
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
