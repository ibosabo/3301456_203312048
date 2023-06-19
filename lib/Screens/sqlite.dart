import 'package:flutter/material.dart';


import '../Model/Music.dart';
import '../Server/utils.dart';

class DbScreen extends StatefulWidget {
  const DbScreen({super.key});

  @override
  _DbScreenState createState() => _DbScreenState();
}

class _DbScreenState extends State<DbScreen> {
  final DbUtils dbUtils = DbUtils();
  List<Music> musics = [];

  final TextEditingController singerNameController = TextEditingController();
  final TextEditingController songNameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  void dispose() {
    singerNameController.dispose();
    songNameController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İstek Parça'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: singerNameController,
                decoration: const InputDecoration(
                  labelText: 'Singer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: songNameController,
                decoration: const InputDecoration(
                  labelText: 'Song',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _insertMusic(),
                child: const Text('Veritabanına Müzik Ekle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
              ),
              ElevatedButton(
                onPressed: () => _fetchMusics(),
                child: const Text('Veritabanından Müzikleri Al'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
              ),
              ElevatedButton(
                onPressed: () => _deleteMusic(),
                child: const Text('Müziği Sil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
              ),
              ElevatedButton(
                onPressed: () => _updateMusic(),
                child: const Text('Müziği Güncelle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Müzikler:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: musics.map((music) {
                  return Text('Singer: ${music.singerName}, Song: ${music.songName}, Year: ${music.year}');
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertMusic() async {
    final String singerName = singerNameController.text;
    final String songName = songNameController.text;
    final int year = int.parse(yearController.text);

    final newMusic = Music(
      singerName: singerName,
      songName: songName,
      year: year,
    );

    await dbUtils.insertMusic(newMusic);
    _fetchMusics();
  }

  Future<void> _fetchMusics() async {
    final List<Music> fetchedMusics = await dbUtils.getMusics();
    setState(() {
      musics = fetchedMusics;
    });
  }

  Future<void> _deleteMusic() async {
    final String singerName = singerNameController.text;
    await dbUtils.deleteMusic(singerName);
    _fetchMusics();
  }

  Future<void> _updateMusic() async {
    final String singerName = singerNameController.text;
    final String songName = songNameController.text;
    final int year = int.parse(yearController.text);

    final updatedMusic = Music(
      singerName: singerName,
      songName: songName,
      year: year,
    );

    await dbUtils.updateMusic(updatedMusic);
    _fetchMusics();
  }
}
