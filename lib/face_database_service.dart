import 'dart:developer';
import 'package:capstone/store_faces.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FaceDatabaseService {
  static final FaceDatabaseService _faceDatabaseService = FaceDatabaseService._internal();
  factory FaceDatabaseService() => _faceDatabaseService;
  FaceDatabaseService._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = getDirectory.path + '/faces.db';
    log(path);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Faces(id TEXT PRIMARY KEY, svg TEXT, emotion TEXT)');
    log('TABLE CREATED');
  }

  Future<List<StoreFaces>> getFaces() async {
    final db = await _faceDatabaseService.database;
    var data = await db.rawQuery('SELECT * FROM Faces');
    List<StoreFaces> faces = List.generate(data.length, (index) => StoreFaces.fromJson(data[index]));
    print(faces.length);
    return faces;
  }

  Future<void> insertFace(StoreFaces face) async {
    final db = await _faceDatabaseService.database;
    var data = await db.rawInsert(
        'INSERT INTO Faces(id, svg, emotion) VALUES(?,?,?)',
        [face.id, face.svg, face.emotion]);
    log('inserted $data');
  }

  Future<void> editJournal(StoreFaces face) async {
    final db = await _faceDatabaseService.database;
    var data = await db.rawUpdate(
        'UPDATE Faces SET svg=?,emotion=? WHERE ID=?',
        [face.svg, face.emotion,face.id]);
    log('updated $data');
  }

  Future<void> deleteJournal(String id) async {
    final db = await _faceDatabaseService.database;
    var data = await db.rawDelete('DELETE from Faces WHERE id=?', [id]);
    log('deleted $data');
  }
}