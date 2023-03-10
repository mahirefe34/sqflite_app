import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/bp_model.dart';

class BPDatabase {
  static final BPDatabase instance = BPDatabase._init();

  static Database? _database;

  BPDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('bp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    //const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableBP ( 
  ${BPModelFields.id} $idType, 
  ${BPModelFields.status} $integerType,
  ${BPModelFields.systolic} $textType,
  ${BPModelFields.diastolic} $textType,
  ${BPModelFields.pulse} $textType,
  ${BPModelFields.description} $textType,
  ${BPModelFields.time} $textType
  )
''');
  }

  Future<BPModel> create(BPModel model) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableBP, model.toJson());
    return model.copy(id: id);
  }

  Future<BPModel> readSingle(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBP,
      columns: BPModelFields.values,
      where: '${BPModelFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BPModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<BPModel>> readAll() async {
    final db = await instance.database;

    const orderBy = '${BPModelFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableBP, orderBy: orderBy);

    return result.map((json) => BPModel.fromJson(json)).toList();
  }

  Future<int> update(BPModel model) async {
    final db = await instance.database;

    return db.update(
      tableBP,
      model.toJson(),
      where: '${BPModelFields.id} = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBP,
      where: '${BPModelFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
