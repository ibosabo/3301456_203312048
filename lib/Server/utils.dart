import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Model/Music.dart';

class DbUtils {
  static final DbUtils _dbUtils = DbUtils._internal();
  DbUtils._internal();
  factory DbUtils() {
    return _dbUtils;
  }

  static Database? _db;
  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    final path = join(await getDatabasesPath(), 'music_database.db');
    final dbMusics = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbMusics;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS musics (singerName TEXT, songName TEXT, year INTEGER)",
    );
  }

  Future<void> insertMusic(Music music) async {
    final db = await this.db;
    await db?.insert(
      'musics',
      music.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Music>> getMusics() async {
    final db = await this.db;
    final List<Map<String, dynamic>>? maps = await db?.query('musics');
    return List.generate(maps!.length, (i) {
      return Music(
        singerName: maps[i]['singerName'] as String,
        songName: maps[i]['songName'] as String,
        year: maps[i]['year'] as int,
      );
    });
  }

  Future<void> updateMusic(Music music) async {
    final db = await this.db;
    await db?.update(
      'musics',
      music.toMap(),
      where: "singerName = ?",
      whereArgs: [music.singerName],
    );
  }

  Future<void> deleteMusic(String singerName) async {
    final db = await this.db;
    await db?.delete(
      'musics',
      where: "singerName = ?",
      whereArgs: [singerName],
    );
  }
}
