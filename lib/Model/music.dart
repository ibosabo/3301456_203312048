class Music {
  final String singerName;
  final String songName;
  final int year;

  Music({
    required this.singerName,
    required this.songName,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'singerName': singerName,
      'songName': songName,
      'year': year,
    };
  }
}
