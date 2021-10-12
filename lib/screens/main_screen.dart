import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmstagram/models/user_model.dart';
import 'package:sunmstagram/screens/create_screen.dart';
import 'package:sunmstagram/service/database.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instagram",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CreateScreen.id);
            },
            icon: const Icon(
              Icons.add_box_outlined,
            ),
          )
        ],
      ),
      body: Text(""),
    );
  }
}
