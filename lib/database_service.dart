import 'dart:developer';
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
            'reflection TEXT, emotion TEXT)');
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
        'INSERT INTO Journals(id, date, title, reflection, emotion) VALUES(?,?,?,?,?)',
        [journal.id, journal.date, journal.title, journal.reflection, journal.emotion]);
    log('inserted $data');
  }
  Future<void> editJournal(JournalModel journal) async {
    final db = await _databaseService.database;
    var data = await db.rawUpdate(
        'UPDATE Journals SET title=?,reflection=?,emotion=? WHERE ID=?',
        [journal.title, journal.reflection, journal.emotion, journal.id]);
    log('updated $data');
  }
  Future<void> deleteJournal(String id) async {
    final db = await _databaseService.database;
    var data = await db.rawDelete('DELETE from Journals WHERE id=?', [id]);
    log('deleted $data');
  }
}