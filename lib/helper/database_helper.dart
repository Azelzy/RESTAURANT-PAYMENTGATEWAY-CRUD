import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
      },
    );
  }

  Future<int> insertName(String name) async {
    final client = await db;
    return client.insert('contacts', {'name': name});
  }

  Future<List<Map<String, dynamic>>> getNames() async {
    final client = await db;
    return client.query('contacts', orderBy: 'id DESC');
  }

  Future<int> updateName(int id, String name) async {
    final client = await db;
    return client.update(
      'contacts',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteName(int id) async {
    final client = await db;
    return client.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}