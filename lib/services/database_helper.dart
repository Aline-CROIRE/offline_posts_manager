import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post_model.dart';

class DatabaseHelper {
  // 1. Private Constructor & Singleton Instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // 2. Get the database (if it exists, return it; if not, initialize it)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('posts.db');
    return _database!;
  }

  // 3. Initialize the database file in the device storage
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // 4. Create the 'posts' table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }

  // --- CRUD OPERATIONS ---

  Future<int> insertPost(Post post) async {
    final db = await instance.database;
    return await db.insert('posts', post.toMap());
  }

  Future<List<Post>> getAllPosts() async {
    final db = await instance.database;
    // Sort by createdAt descending (newest first)
    final result = await db.query('posts', orderBy: 'createdAt DESC');
    return result.map((map) => Post.fromMap(map)).toList();
  }

  Future<int> updatePost(Post post) async {
    final db = await instance.database;
    return await db.update(
      'posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  Future<int> deletePost(int id) async {
    final db = await instance.database;
    return await db.delete(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close the database connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}