import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  late Database instance;
  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dot.db');

    instance = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE expense (id TEXT PRIMARY KEY, namaPengeluaran TEXT, jenisPengeluaran TEXT, tanggal TEXT, nominal INTEGER)');
    });
  }
}

DB db = DB();
