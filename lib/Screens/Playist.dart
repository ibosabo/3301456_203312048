import 'package:flutter/material.dart';
import '../Server/MusicService.dart';

class Playlist extends StatelessWidget {
  final List<Music> musicList = [
    Music(title: 'Sentius akademi', artist: 'Yapay Zeka', audioPath: 'music/ses10.mp3'),
    Music(title: 'Adana Köprü Başı', artist: 'Murat Kurşun ', audioPath: 'music/ses.mp3'),
    Music(title: 'Experience', artist: 'Einaudi', audioPath: 'music/ses7.mp3'),
    Music(title: 'Billie Eilish', artist: 'lovely', audioPath: 'music/ses2.mp3'),
    Music(title: 'Runaway', artist: 'AURORA ', audioPath: 'music/ses3.mp3'),
    Music(title: 'Yanlış', artist: 'Tuğçe Kandemir', audioPath: 'music/ses4.mp3'),
    Music(title: 'Elimde Duran Fotoğrafın', artist: 'Bergen', audioPath: 'music/ses9.mp3'),
    Music(title: 'Tourner Dans Le Vide(Andrew Tate) ', artist: 'Indila', audioPath: 'music/ses6.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayerPage(
                    music: musicList[index],
                  ),
                ),
              );
            },
            child: MusicCard(music: musicList[index]),
          );
        },
      ),
    );
  }
}

class Music {
  final String title;
  final String artist;
  final String audioPath;

  Music({required this.title, required this.artist, required this.audioPath});
}

class MusicCard extends StatelessWidget {
  final Music music;

  const MusicCard({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey.shade900,
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.music_note, size: 50, color: Colors.white),
        title: Text(music.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(music.artist, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}

class MusicPlayerPage extends StatefulWidget {
  final Music music;

  MusicPlayerPage({required this.music});

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  double _sliderValue = 0.0;
  late MusicService musicService;

  @override
  void initState() {
    super.initState();
    musicService = MusicService();
    musicService.setUp();
    musicService.player.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        _sliderValue = duration.inSeconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    musicService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage("assets/images/resim10.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
            ),
            const SizedBox(height: 20),
            Text(
              widget.music.title,
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.music.artist,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            Slider(
              value: _sliderValue,
              min: 0.0,
              max: musicService.musicLength.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
                musicService.seekTo(value.toInt());
              },
            ),
            IconButton(
              icon: Icon(
                musicService.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              color: Colors.white,
              onPressed: () {
                if (musicService.isPlaying) {
                  musicService.stopMusic();
                } else {
                  musicService.playMusic(widget.music.audioPath);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

