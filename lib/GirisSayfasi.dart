import 'package:flutter/material.dart';
import 'package:ibrahimsaboo/play_music.dart';
class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({Key? key}) : super(key: key);
  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}
class _GirisSayfasiState extends State<GirisSayfasi> {
  final TextEditingController _adSoyadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _adSoyadController,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: TextStyle(color: Colors.white),
                labelText: "Ad Soyad",
              ),
            ),

            const SizedBox(
              height: 5,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String adSoyad = _adSoyadController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Welcome(ad: adSoyad),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                padding: MaterialStateProperty.all(EdgeInsets.all(21)),
              ),
              child: const Text('  Giriş  '),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey.shade900,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          backgroundColor: Colors.blueGrey.shade900,
          title: const Text('SABO Music App'),
          toolbarHeight: 90,
          centerTitle: true,
        ),
      ),
    );
  }
}
class Welcome extends StatefulWidget {
  final String ad;
  const Welcome({Key? key, required this.ad}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}
class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PlayMusic()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(
        child: Text(
        'Hoşgeldin, ${widget.ad} ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        ),
    );
  }
}

class PlayMusicSayfasi extends StatelessWidget {
  const PlayMusicSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            ),
          ),
          child: const Text(' Müzik Çal '),
        ),
      ),
      backgroundColor: Colors.blueGrey.shade900,
    );
  }
}