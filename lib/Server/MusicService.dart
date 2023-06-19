import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final MusicService _singleton = MusicService._internal();

  factory MusicService() {
    return _singleton;
  }

  MusicService._internal();

  AudioPlayer player = AudioPlayer();
  late AudioCache cache;

  bool isPlaying = false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();

  void setUp() {
    player.onAudioPositionChanged.listen((d) {
      currentPostion = d;

      player.onDurationChanged.listen((d) {
        musicLength = d;
      });
    });

    cache = AudioCache(fixedPlayer: player);
  }

  void playMusic(String song) {
    isPlaying = true;
    cache.play(song);
  }

  void stopMusic() {
    isPlaying = false;
    player.pause();
  }

  void seekTo(int sec) {
    player.seek(Duration(seconds: sec));
  }

  void dispose() {
    player.dispose();
  }
}
