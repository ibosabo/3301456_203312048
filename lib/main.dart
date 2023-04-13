import 'package:flutter/material.dart';
import 'package:ibrahimsaboo/play_music.dart';
import 'GirisSayfasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GirisSayfasi(),
    );
  }
}



