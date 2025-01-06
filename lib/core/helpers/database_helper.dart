import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // DatabaseHelper._();
  // static final DatabaseHelper db = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'journal.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE journals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            mood TEXT,
            content TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<int> addJournal(
      {required String mood,
      required String content,
      required String date}) async {
    final db = await database;
    log('Adding journal entry', name: 'DatabaseHelper');
    return await db.insert('journals', {
      'mood': mood,
      'content': content,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> fetchJournals() async {
    final db = await database;
    final result = await db.query('journals');

    // Ensure no null values are returned
    return result.map((journal) {
      return {
        'mood': journal['mood'] ?? '😃', // Default mood
        'content': journal['content'] ?? 'No content', // Default content
        'date': journal['date'], // Default date
      };
    }).toList();
  }

  Future<int> deleteJournal({required int id}) async {
    final db = await database;
    return await db.delete('journals', where: 'id = ?', whereArgs: [id]);
  }
}
