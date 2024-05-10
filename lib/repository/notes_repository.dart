import 'package:path/path.dart';
import 'package:phase/modals/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteRespository {
  static const _dbName = "notes_database.db";
  static const _tableName = "notes";

  static Future<Database> _database() async {
    final database = openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY,title TEXT,description TEXT,createdAt TEXT)');
    }, version: 1);
    return database;
  }

  static insert({required Note note}) async {
    final db = await _database();
    await db.insert(
      _tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (index) {
      return Note(
        id: maps[index]["id"],
        title: maps[index]["title"],
        description: maps[index]["description"],
        createdAt: DateTime.parse(maps[index]["createdAt"]),
      );
    });
  }
}
