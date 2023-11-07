import 'package:kcgerp/Model/post.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class PostDatabaseHelper {
  static final PostDatabaseHelper _instance = PostDatabaseHelper._internal();
  Database? _database;

  factory PostDatabaseHelper() {
    return _instance;
  }

  PostDatabaseHelper._internal();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'post_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts(
        id TEXT PRIMARY KEY,
        title TEXT,
        dp TEXT,
        image_url TEXT,
        description TEXT,
        likes TEXT,
        link TEXT,
        name TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<void> insertPost(Post post) async {
    final db = await database;
    try {
      // Convert image_url and likes to JSON-encoded strings
      final Map<String, dynamic> postMap = post.toMap();
      postMap['image_url'] = jsonEncode(post.image_url);
      postMap['likes'] = jsonEncode(post.likes);

      await db?.insert('posts', postMap);
    } catch (e) {
      //print("Error inserting post: $e");
    }
  }

  Future<List<Post>> getPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('posts');
    return List.generate(maps.length, (index) {
      return Post(
        title: maps[index]['title'],
        dp: maps[index]['dp'],
        image_url: jsonDecode(maps[index]['image_url']),
        description: maps[index]['description'],
        likes: jsonDecode(maps[index]['likes']),
        link: maps[index]['link'],
        name: maps[index]['name'],
        id: maps[index]['id'],
        createdAt: maps[index]['createdAt'],
      );
    });
  }
}
