//sharepref
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

  // Future<void> addQuoteDb(String content, String author) async {
  //   await db.insert(quoteTable, {
  //     "content": content,
  //     "author": author,
  //   });
  // }
  //
  // Future<void> addQuoteWithModel(QuoteModel model) async {
  //   await db.insert(quoteTable, model.toJson());
  // }
  //
  // // Future<List<Map<String, Object?>>> getQuoteFromDb() async {
  // //   List<Map<String, Object?>> quoteList = await db.query(quoteTable);
  // //   return quoteList;
  // // }
  //
  // Future<List<QuoteModel>> getQuoteFromDb() async {
  //   List<Map<String, Object?>> quoteList = await db.query(quoteTable);
  //   return quoteList.map((json) => QuoteModel.fromJson(json)).toList();
  // }

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


//db
// import 'package:sqflite/sqflite.dart';
// import '../model/quoteModel.dart';
//
// class DbHelper {
//   static DbHelper dbHelper = DbHelper._();
//
//   DbHelper._();
//
//   late Database db;
//   String quoteTable = "quote";
//
//   Future<void> initDb() async {
//     String dbPath = await getDatabasesPath();
//     db = await openDatabase(
//       "quote.db",
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(
//             "CREATE TABLE $quoteTable (id	INTEGER UNIQUE,quoteName	TEXT,author	TEXT,PRIMARY KEY(id AUTOINCREMENT));");
//       },
//     );
//   }
//
//   // Future<void> addQuoteDb(String content, String author) async {
//   //   await db.insert(quoteTable, {
//   //     "content": content,
//   //     "author": author,
//   //   });
//   // }
//
//   Future<void> addQuoteWithModel(QuoteModel model) async {
//     await db.insert(quoteTable, model.toJson());
//   }
//
//   // Future<List<Map<String, Object?>>> getQuoteFromDb() async {
//   //   List<Map<String, Object?>> quoteList = await db.query(quoteTable);
//   //   return quoteList;
//   // }
//   Future<List<QuoteModel>> getQuotesFromDb() async {
//     List<Map<String, dynamic>> quoteList = await db.query(quoteTable);
//     return quoteList.map((json) => QuoteModel.fromJson(json)).toList();
//   }
//
//   Future<void> removeQuoteById(int id) async {
//     await db.delete(quoteTable, where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<void> clearWishlist() async {
//     await db.delete(quoteTable);
//   }
// }






//
// import 'package:sqflite/sqflite.dart';
// import '../model/quoteModel.dart';
//
// class DbHelper {
//   static final DbHelper dbHelper = DbHelper._();
//
//   DbHelper._();
//
//   late Database db;
//   final String quoteTable = "quote";
//
//   // Initialize the database
//   Future<void> initDb() async {
//     String dbPath = await getDatabasesPath();
//     db = await openDatabase(
//       "$dbPath/quote.db",
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(
//           "CREATE TABLE $quoteTable (id INTEGER PRIMARY KEY AUTOINCREMENT, quoteName TEXT, author TEXT)",
//         );
//       },
//     );
//   }
//
//   // Add a quote to the database
//   Future<void> addQuoteWithModel(QuoteModel model) async {
//     await db.insert(quoteTable, model.toJson());
//   }
//
//   // Get all quotes from the database
//   Future<List<QuoteModel>> getQuotesFromDb() async {
//     List<Map<String, dynamic>> quoteList = await db.query(quoteTable);
//     return quoteList.map((json) => QuoteModel.fromJson(json)).toList();
//   }
//
//   // Remove a quote from the database by its ID
//   Future<void> removeQuoteById(int id) async {
//     await db.delete(quoteTable, where: 'id = ?', whereArgs: [id]);
//   }
// }
