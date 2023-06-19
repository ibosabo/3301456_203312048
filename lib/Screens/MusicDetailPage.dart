import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ibrahimsaboo/Model/musicdataresponse.dart';

class MusicDetailPage extends StatefulWidget {
  MusicDetailPage({Key? key, required this.response}) : super(key: key);
  final MusicDataResponse response;

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.response.image.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Music Detail Page"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                url,
                height: MediaQuery.of(context).size.height / 2.75,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32,),
            Text(
              widget.response.title.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade50),
            ),
            const SizedBox(height: 4,),
            Text(
              widget.response.artist.toString(),
              style: TextStyle(fontSize: 20, color: Colors.blueGrey.shade50),
            ),
            Slider(
              value: position.inSeconds.toDouble(),
              min: 0,
              activeColor: Colors.white,
              max: duration.inSeconds.toDouble(),
              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());
                await audioPlayer.seek(newPosition);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position), style: TextStyle(color: Colors.blueGrey.shade900)),
                  Text(formatTime(duration - position), style: TextStyle(color: Colors.blueGrey.shade900)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blueGrey.shade900,
              child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      twoDigitMinutes,
      twoDigitSeconds,
    ].join(':');
  }
}
