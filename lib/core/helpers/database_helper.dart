import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A helper class to manage the SQLite database for journal entries.
class DatabaseHelper {
  // Singleton instance of DatabaseHelper
  // DatabaseHelper._();
  // static final DatabaseHelper db = DatabaseHelper._();

  static Database? _database;

  /// Getter for the database instance. Initializes the database if it doesn't exist.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes the database and creates the 'journals' table if it doesn't exist.
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

  /// Adds a new journal entry to the 'journals' table.
  ///
  /// Parameters:
  /// - `mood`: The mood of the journal entry.
  /// - `content`: The content of the journal entry.
  /// - `date`: The date of the journal entry.
  ///
  /// Returns the id of the inserted journal entry.
  Future<int> addJournal({
    required String mood,
    required String content,
    required String date,
  }) async {
    final db = await database;
    log('Adding journal entry', name: 'DatabaseHelper');
    return await db.insert('journals', {
      'mood': mood,
      'content': content,
      'date': date,
    });
  }

  /// Fetches all journal entries from the 'journals' table.
  ///
  /// Returns a list of maps containing the journal entries.
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

  /// Deletes a journal entry from the 'journals' table by id.
  ///
  /// Parameters:
  /// - `id`: The id of the journal entry to delete.
  ///
  /// Returns the number of rows affected.
  Future<int> deleteJournal({required int id}) async {
    final db = await database;
    return await db.delete('journals', where: 'id = ?', whereArgs: [id]);
  }
}
