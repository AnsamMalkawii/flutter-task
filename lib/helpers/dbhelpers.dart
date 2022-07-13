import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import '../constants.dart';
import '../models/alphabets.dart';
import '../models/user.dart';

class DatabaseHelper {
  static final User _user = User(
      birthdate: DateTime.parse("1993-11-12").millisecondsSinceEpoch,
      email: 'ansamamalkawi@gmail.com',
      id: 1,
      name: 'Ansam Malkawi',
      password: 'password');

  static final List<Alphabets> _alphabets = [
    Alphabets(id: 1, arabicAlpha: 'ا', example: "أسد"),
    Alphabets(id: 1, arabicAlpha: 'ب', example: "بطة"),
    Alphabets(id: 1, arabicAlpha: 'ت', example: "تفاحة"),
    Alphabets(id: 1, arabicAlpha: 'ث', example: "ثعبان"),
    Alphabets(id: 1, arabicAlpha: 'ج', example: "جمل"),
    Alphabets(id: 1, arabicAlpha: 'ح', example: "حصان"),
    Alphabets(id: 1, arabicAlpha: 'خ', example: "خروف"),
    Alphabets(id: 1, arabicAlpha: 'د', example: "دب"),
    Alphabets(id: 1, arabicAlpha: 'ذ', example: "ذيل"),
    Alphabets(id: 1, arabicAlpha: 'ر', example: "رمان"),
    Alphabets(id: 1, arabicAlpha: 'ز', example: "زرافة"),
    Alphabets(id: 1, arabicAlpha: 'س', example: "سمكة"),
    Alphabets(id: 1, arabicAlpha: 'ش', example: "شجرة"),
    Alphabets(id: 1, arabicAlpha: 'ص', example: "صندوق"),
  ];

  static Database? _database;

  static Future<Database?> get database async {
    if (_database == null) {
      _database = await initDb();
      return _database;
    } else {
      return _database;
    }
  }

  static Future<sql.Database> initDb() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'CartProduct.db'),
        version: 1, onCreate: _onCreate);
  }

  static _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE $userTableName (
      $cId INTEGER NOT NULL,
      $cUserName TEXT NOT NULL,
      $cEmail TEXT NOT NULL,
      $cPassword TEXT NOT NULL,
      $cBirthdate DATETIME NOT NULL

    )''');

    await db.execute(''' CREATE TABLE $alphaTableName (
      $cId INTEGER NOT NULL,
      $cArabicAlphabet TEXT NOT NULL,
      $cExample TEXT NOT NULL
    )
''');

    await _insertDataIntoAlphabets(db);
    await _insertIntoUser(db);
  }

  static Future<void> _insertIntoUser(Database db) async {
    await db.insert(userTableName, _user.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('data was added to user');
  }

  static Future<void> _insertDataIntoAlphabets(Database db) async {
    var alphabets = _alphabets;
    for (var i in alphabets) {
      await db.insert(alphaTableName, i.toJson(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    }
  }

  static Future<List<Map<String, dynamic>>> getUserData() async {
    final db = await DatabaseHelper.database;
    return db!.query(userTableName);
  }

  static Future<List<Map<String, dynamic>>> getAlphabetsData() async {
    final db = await DatabaseHelper.database;
    return db!.query(alphaTableName);
  }

  static Future<List<Map<String, dynamic>>> queryDatabase(
      String email, String password) async {
    final db = await DatabaseHelper.database;

    var res = db!.rawQuery(
        'SELECT * FROM $userTableName WHERE $cEmail = ? and $cPassword = ?',
        [email, password]);

    return res;
  }
}
