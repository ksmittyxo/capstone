import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'journalmodel.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }
  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = getDirectory.path + '/journals.db';
    log(path);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }
  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Journals(id TEXT PRIMARY KEY, title TEXT, date TEXT, '
            'reflection TEXT, emotion TEXT, face TEXT)');
    log('TABLE CREATED');
  }
  Future<List<JournalModel>> getJournals() async {
    final db = await _databaseService.database;
    var data = await db.rawQuery('SELECT * FROM Journals');
    List<JournalModel> journals =
    List.generate(data.length, (index) => JournalModel.fromJson(data[index]));
    print(journals.length);
    return journals;
  }
  Future<void> insertJournal(JournalModel journal) async {
    final db = await _databaseService.database;
    var data = await db.rawInsert(
        'INSERT INTO Journals(id, date, title, reflection, emotion, face) VALUES(?,?,?,?,?,?)',
        [journal.id, journal.date, journal.title, journal.reflection, journal.emotion, journal.face]);
    log('inserted $data');
  }
  Future<void> editJournal(JournalModel journal) async {
    final db = await _databaseService.database;
    var data = await db.rawUpdate(
        'UPDATE Journals SET title=?,reflection=?,emotion=?,face=? WHERE ID=?',
        [journal.title, journal.reflection, journal.emotion, journal.face, journal.id]);
    log('updated $data');
  }
  Future<void> deleteJournal(String id) async {
    final db = await _databaseService.database;
    var data = await db.rawDelete('DELETE from Journals WHERE id=?', [id]);
    log('deleted $data');
  }
  Future<int> countEmotionUse(String emotion) async {
    final db = await _databaseService.database;
    var data = await db.rawQuery(
      'SELECT COUNT(?) FROM Journals WHERE emotion =?',
      [emotion, emotion]);
    var count = Sqflite.firstIntValue(data);
    if (count != null) {
      return count;
    } else {
      return 0;
    }
  }
  Future<List<Iterable<String>>> datesEmotionUsed(String emotion) async {
    final db = await _databaseService.database;
    var data = await db.rawQuery('SELECT date FROM Journals WHERE emotion =?', [emotion]);
    print(data);
    return List.generate(data.length, (index) => data[index].keys);
  }
}