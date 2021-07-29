import 'package:expense/services/database.dart';
import 'package:sqflite/sqflite.dart';

class HomeController {
  Future<Map<String, dynamic>> reloadDashboard() async {
    var today = await db.instance
        .query("expense", where: "substr(tanggal, 1, 10) = ?", whereArgs: [
      DateTime.now().toIso8601String().substring(0, 10),
    ]);

    var yesterday = await db.instance
        .query("expense", where: "substr(tanggal, 1, 10) = ?", whereArgs: [
      DateTime.now()
          .subtract(Duration(days: 1))
          .toIso8601String()
          .substring(0, 10),
    ]);

    var cat = await db.instance.rawQuery(
        "SELECT jenisPengeluaran as key, SUM(nominal) as nominal FROM expense GROUP BY jenisPengeluaran");

    var sumToday = Sqflite.firstIntValue(await db.instance.rawQuery(
        "SELECT SUM(nominal) as nominal FROM expense WHERE substr(tanggal, 1, 10) = ?",
        [
          DateTime.now().toIso8601String().substring(0, 10),
        ]));

    var sumMonth = Sqflite.firstIntValue(await db.instance.rawQuery(
        "SELECT SUM(nominal) as nominal FROM expense WHERE substr(tanggal, 1, 7) = ?",
        [
          DateTime.now().toIso8601String().substring(0, 7),
        ]));

    return {
      "sum_today": sumToday,
      "sum_month": sumMonth,
      "cat": cat,
      "today": today,
      "yesterday": yesterday,
    };
  }
}
