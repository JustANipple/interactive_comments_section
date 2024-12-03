import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/comment.dart';
import '../models/user.dart';

class CommentDatabase {
  static final CommentDatabase _instance = CommentDatabase._internal();

  factory CommentDatabase() => _instance;

  CommentDatabase._internal();

  Database? _database;
  static const String _dbName = "interactiveCommentsSection.db";
  static const String _commentsTableName = "comments";
  static const String _usersTableName = "users";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_commentsTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        parentId INTEGER,
        text TEXT NOT NULL,
        likes INTEGER,
        userAddId INTEGER NOT NULL,
        userUpdateId INTEGER,
        dateAdd NUMERIC NOT NULL,
        dateUpdate NUMERIC
      )
    ''');
    await db.execute('''
      INSERT INTO $_commentsTableName (parentId, text, likes, userAddId, userUpdateId, dateAdd, dateUpdate)
      VALUES
        (NULL, 'Impressive! Though it seems the drag feature could be improved. But overall it looks incredible. You’ve nailed the design and the responsiveness at various breakpoints works really well.', 0, 4, 4, '2024-11-22T00:00:00.000000', '2024-11-01T00:00:00.000000'),
        (NULL, 'Woah, your project looks awesome! How long have you been coding for? I’m still new, but think I want to dive into React as well soon. Perhaps you can give me an insight on where I can learn React? Thanks!', 0, 3, 3, '2024-11-17T00:00:00.000000', '2024-11-22T00:00:00.000000'),
        (2, '@maxblagun If you’re still new, I’d recommend focusing on the fundamentals of HTML, CSS, and JS before considering React. It’s very tempting to jump ahead but lay a solid foundation first.', 0, 2, 2, '2024-11-24T00:00:00.000000', '2024-11-22T00:00:00.000000'),
        (2, '@ramsesmiron I couldn’t agree more with this. Everything moves so fast and it always seems like everyone knows the newest library/framework. But the fundamentals are what stay constant.', 0, 1, 1, '2024-11-29T00:00:00.000000', '2024-11-22T00:00:00.000000')
    ''');
    await db.execute('''
      CREATE TABLE $_usersTableName (
        id INTEGER PRIMARY KEY,
        name TEXT,
        avatarImageUrl TEXT        
      )
    ''');
    await db.execute('''
      INSERT INTO $_usersTableName (id, name, avatarImageUrl)
      VALUES 
        (1, 'juliusomo', 'assets/avatars/image-juliusomo.png'),
        (2, 'ramsesmiron', 'assets/avatars/image-ramsesmiron.png'),
        (3, 'maxblagun', 'assets/avatars/image-maxblagun.png'),
        (4, 'amyrobson', 'assets/avatars/image-amyrobson.png')
    ''');
  }

  Future<int> insertComment(Comment comment) async {
    final db = await database;
    return await db.insert(
      _commentsTableName,
      comment.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateComment(Comment comment) async {
    final db = await database;
    comment.dateUpdate = DateTime.now();
    return await db.update(_commentsTableName, comment.toJson(),
        where: 'id = ?', whereArgs: [comment.id]);
  }

  Future<int> deleteComment(Comment comment) async {
    final db = await database;
    return await db
        .delete(_commentsTableName, where: 'id = ?', whereArgs: [comment.id]);
  }

  Future<Comment> readComment(int id) async {
    final db = await database;
    List<Map<String, Object?>> records =
        await db.query(_commentsTableName, where: 'id = ?', whereArgs: [id]);
    Comment comment = Comment.fromJson(records.first);
    return comment;
  }

  Future<List<Comment>> readComments() async {
    final db = await database;
    List<Map<String, Object?>> records = await db.query(_commentsTableName);
    List<Comment> comments = [];
    for (final record in records) {
      comments.add(Comment.fromJson(record));
    }
    return comments;
  }

  Future<List<User>> readUsers() async {
    final db = await database;
    List<Map<String, Object?>> records = await db.query(_usersTableName);
    List<User> users = [];
    for (final record in records) {
      users.add(User.fromJson(record));
    }
    return users;
  }
}
