import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sunmstagram/constants.dart';

class CreateScreen extends StatefulWidget {
  static String id = "create_screen";

  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  File? image;
  String? title;
  String? contents;
  String? location;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // Cant Access permission
      print("Fail to pic image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.black,
          title: const Text("새 게시물"),
          actions: [
            TextButton(
              onPressed: () {
                final firebaseStorageRef = FirebaseStorage.instance
                    .ref()
                    .child('post')
                    .child('${DateTime.now().millisecondsSinceEpoch}.png');

                final task = firebaseStorageRef.putFile(
                    image!, SettableMetadata(contentType: 'image/png'));
                task.then((value) {
                  var downloadUrl = value.ref.getDownloadURL();

                  downloadUrl.then((uri) {
                    CollectionReference doc =
                        FirebaseFirestore.instance.collection('post');
                    doc.add({
                      'photoUrl': uri.toString(),
                      'contents': contents!,
                      'title': title!,
                      'location': location!,
                      'email': user.email!,
                      'author': user.displayName!,
                      'userProfileUrl': user.photoURL!,
                    }).then((value) {
                      print("User Added");
                      Navigator.pop(context);
                    }).catchError(
                        (error) => print("Failed to add user: $error"));
                    ;
                  });
                });
              },
              child: const Text("등록"),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                image != null
                    ? InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Image.file(
                          image!,
                          width: 240,
                          height: 240,
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(256.0),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          pickImage();
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.collections_outlined,
                              size: 60,
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Text("Pick Image")
                          ],
                        ),
                      ),
                TextField(
                  decoration:
                      customInputDecoration.copyWith(labelText: "Post title"),
                  onChanged: (text) {
                    title = text;
                  },
                ),
                TextField(
                  decoration:
                      customInputDecoration.copyWith(labelText: "Post content"),
                  onChanged: (text) {
                    contents = text;
                  },
                ),
                TextField(
                  decoration:
                      customInputDecoration.copyWith(labelText: "Location"),
                  onChanged: (text) {
                    location = text;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
