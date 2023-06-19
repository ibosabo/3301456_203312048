import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../GirisSayfasi.dart';
import '../Screens/HomePage.dart';
import '../Screens/Playist.dart';
import '../Screens/sqlite.dart';
import '../Screens/firebaseprocess.dart';
import 'sign_up.dart';
import 'package:ibrahimsaboo/play_music.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInUser() async {
    try {
      String email = _emailController.text;
      String password = _passwordController.text;

      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Kullanıcı giriş yaptı: ${userCredential.user!.uid}');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlayMusic()),
      );
    } catch (e) {
      print('Hata: $e');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text(
                'Giriş yaparken bir hata oluştu. Lütfen bilgilerinizi kontrol edin.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Hata rengi olarak kırmızı kullanıldı
                  onPrimary: Colors.white,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text('Giriş Yap'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'E-posta',
                labelStyle: TextStyle(color: Colors.white), // E-posta etiket rengi olarak mavi kullanıldı
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon:
                Icon(Icons.email, color: Colors.white), // E-posta simgesi rengi olarak mavi kullanıldı
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Şifre',
                labelStyle: TextStyle(color: Colors.white), // Şifre etiket rengi olarak mavi kullanıldı
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                prefixIcon:
                Icon(Icons.lock, color: Colors.white), // Şifre simgesi rengi olarak mavi kullanıldı
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _signInUser,
              child: Text('Giriş Yap'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey.shade800, // Giriş yap düğmesi rengi olarak mavi kullanıldı
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                ).then((value) {
                  if (value == true) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Welcome(ad: '',)),
                      );
                    });
                  }
                });
              },
              child: Text('Kayıt Ol'),
              style: TextButton.styleFrom(
                primary: Colors.white, // Kayıt ol düğmesi rengi olarak mavi kullanıldı
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Playlist()),
                );
              },
              child: Text('Playlist Sayfasına Git'),
              style: TextButton.styleFrom(
                primary: Colors.white, // Playlist sayfasına git düğmesi rengi olarak mavi kullanıldı
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirebaseProcess()),
                );
              },
              child: Text('Firebase Sayfasına Git'),
              style: TextButton.styleFrom(
                primary: Colors.white, // Firebase sayfasına git düğmesi rengi olarak mavi kullanıldı
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('HomePage Ekranına Git'),
              style: TextButton.styleFrom(
                primary: Colors.white, // Home sayfasına git düğmesi rengi olarak mavi kullanıldı
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DbScreen()),
                );
              },
              child: Text('Veritabanı Ekranına Git'),
              style: TextButton.styleFrom(
                primary: Colors.white, // Veritabanı sayfasına git düğmesi rengi olarak mavi kullanıldı
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

