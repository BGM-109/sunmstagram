import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunmstagram/provider/google_sign_in_provider.dart';
import 'package:sunmstagram/screens/create_screen.dart';
import 'package:sunmstagram/screens/home_screen.dart';
import 'package:sunmstagram/screens/index_screen.dart';
import 'package:sunmstagram/screens/initial_screen.dart';
import 'package:sunmstagram/screens/login_screens.dart';
import 'package:sunmstagram/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            actionsIconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
          ),
        ),
        initialRoute: InitialScreen.id,
        routes: {
          InitialScreen.id: (context) => const InitialScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          CreateScreen.id: (context) => const CreateScreen(),
          IndexScreen.id: (context) => const IndexScreen(),
        },
        home: const HomeScreen(),
      ),
    );
  }
}
