import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._int();
  static Database ? _database;
  DatabaseHelper._int();
  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
  // Get the path to the database file
    String path = await getDatabasesPath() + 'tasks.db';
  // Open the database, creating it if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create the tasks table
        await db.execute('''
          CREATE TABLE tasks (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             title TEXT,
             description TEXT,
             isCompleted INTEGER
          )
        ''');
      },
    );
  }
}