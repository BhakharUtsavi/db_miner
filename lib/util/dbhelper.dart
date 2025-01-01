import 'package:sqflite/sqflite.dart';
import '../model/quoteModel.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  late Database db;
  String quoteTable = "quote";

  Future<void> initDb() async {
    String dbPath = await getDatabasesPath();
    db = await openDatabase(
      "quote.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE $quoteTable (id	INTEGER UNIQUE,quoteName	TEXT,author	TEXT,PRIMARY KEY(id AUTOINCREMENT));");
      },
    );
  }
  Future<void> addToWishlistDb(QuoteModel quote) async {
    await db.insert("wishlist", quote.toJson());
  }

  Future<List<QuoteModel>> getWishlistFromDb() async {
    List<Map<String, dynamic>> wishlistData = await db.query("wishlist");
    return wishlistData.map((json) => QuoteModel.fromJson(json)).toList();
  }

  Future<void> removeFromWishlistDb(int id) async {
    await db.delete("wishlist", where: "id = ?", whereArgs: [id]);
  }

}