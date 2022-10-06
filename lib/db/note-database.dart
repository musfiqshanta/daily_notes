
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notes/model/note.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;
  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, filepath);
    print("Database Path is");
    print(path);

    var db = await openDatabase(
      path,
      version: 200,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
    return db;
  }

  final textType = 'TEXT NOT NULL';
  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      // db.execute("ALTER TABLE notes ADD COLUMN newCol TEXT;");
      db.execute(
          "'ALTER TABLE $tableNotes ( ${NoteFields.comment} $textType,)");
      print("success");
    }
  }

// Create database
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    //final boolType = 'BOOLEAN NOT NULL';
    // final integerType = 'INTEGER NOT NULL';
    await db.execute(
        'CREATE TABLE $tableNotes ( ${NoteFields.id} $idType,${NoteFields.title} $textType,${NoteFields.comment} $textType,${NoteFields.description} $textType, ${NoteFields.time} $textType)');
  }

  //Create Table

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final ids = await db.insert(tableNotes, note.tomap());
    return note.copy(id: ids);
  }

// Read data
  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final map = await db.query(tableNotes,
        columns: NoteFields.values,
        where: '${NoteFields.id}=?',
        whereArgs: [id]);

    if (map.isNotEmpty) {
      return Note.fromMap(map.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

// Read All of data
  Future<List<Note>> readAllNote() async {
    final db = await instance.database;
    final orderby = '${NoteFields.time} ASC';
    final result = await db.query(tableNotes, orderBy: orderby);
    return result.map((json) => Note.fromMap(json)).toList();
  }

  // Search
  Future<List<Note>> searchNote(String keyword) async {
    final db = await instance.database;
    final result = await db.query(tableNotes,
        where: '${NoteFields.title} LIKE ?', whereArgs: ['%$keyword%']);
    return result.map((json) => Note.fromMap(json)).toList();
  }

  // update data

  Future<int> update(Note note) async {
    final db = await instance.database;
    return db.update(tableNotes, note.tomap(),
        where: '${NoteFields.id}=?', whereArgs: [note.id]);
  }

  // delete data

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableNotes, where: '${NoteFields.id}=?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
