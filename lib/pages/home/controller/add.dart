import 'package:expense/services/database.dart';
import 'package:sqflite/sqflite.dart';

class AddController {
  insert({
    required String nama,
    required String jenis,
    required DateTime tanggal,
    required double nominal,
  }) {
    db.instance.insert(
      'expense',
      {
        'namaPengeluaran': nama,
        'jenisPengeluaran': jenis,
        'tanggal': tanggal.toIso8601String(),
        'nominal': nominal.toInt(),
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
