import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmstagram/provider/google_sign_in_provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName!),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
        ],
      ),
    );
  }
}
