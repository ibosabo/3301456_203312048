import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ibrahimsaboo/play_music.dart';
import 'Auth/log_in.dart';
import 'Auth/sign_up.dart';
import 'GirisSayfasi.dart';
import 'Screens/HomePage.dart';
import 'Screens/Playist.dart';
import 'Screens/sqlite.dart';
import 'Screens/firebaseprocess.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "Home Page",
      home: const SignupPage(),
    );
  }
}