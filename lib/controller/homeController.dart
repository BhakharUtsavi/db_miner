// import 'dart:convert';
// import 'package:db_miner/util/dbhelper.dart';
// import 'package:get/get.dart';
// import '../model/quoteModel.dart';
// import 'package:http/http.dart';
//
// class HomeController extends GetxController {
//   List<QuoteModel> quotesList = [];
//   RxList<Map<String, Object?>> likedQuotes = <Map<String, Object?>>[].obs;
//
//   //bool isLoading = false;
//   //int page = 1;
//
//   void onInit() {
//     super.onInit();
//     getQuote();
//   }
//
//   Future<void> getQuote() async {
//     List<Map<String, Object?>> quote = await DbHelper.dbHelper.getQuoteFromDb();
//     likedQuotes.value = quote;
//   }
//
//   Future<void> fetchQuotes() async {
//     //if (isLoading) return;
//     //isLoading = true;
//     final url = Uri.parse('https://dummyjson.com/quotes/');
//     try {
//       final response = await get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         // final fetchedQuotes = data['results']
//         //     .map<QuoteModel>((json) => QuoteModel.fromJson(json))
//         //     .toList();
//         // quotes.addAll(fetchedQuotes);
//         // page++;
//       }
//     } catch (e) {
//       print('Error fetching quotes: $e');
//     }
//     // finally {
//     //   isLoading = false;
//     // }
//   }
// // Future<void> likeQuote(QuoteModel quote) async {
// //   //final prefs = await SharedPreferences.getInstance();
// //   final dateTime = DateTime.now().toIso8601String();
// //   final likedQuote = {
// //     'id': quote.id,
// //     'content': quote.content,
// //     'author': quote.author,
// //     'likedAt': dateTime
// //   };
// //
// //   likedQuotes.add(likedQuote);
// //   // prefs.setStringList('likedQuotes', likedQuotes.map(json.encode).toList());
// // }
// }

// import 'dart:convert';
// import 'package:db_miner/util/dbhelper.dart';
// import 'package:get/get.dart';
// import '../model/quoteModel.dart';
// import 'package:http/http.dart';
//
// class HomeController extends GetxController {
//   RxList<QuoteModel> quotesList = <QuoteModel>[].obs;
//   RxList<Map<String, Object?>> likedQuotes = <Map<String, Object?>>[].obs;
//  // late Future<QuoteModel> futureQuotes;
//
//   @override
//   void onInit() {
//     super.onInit();
//    // futureQuotes = fetchQuotes();
//     fetchQuotes();
//     getQuote();
//   }
//
//   Future<void> getQuote() async {
//     List<Map<String, Object?>> quote = await DbHelper.dbHelper.getQuoteFromDb();
//     likedQuotes.value = quote;
//   }
//
//   Future<void> addQuote(String content, String author)async{
//     await DbHelper.dbHelper.addQuoteWithModel(QuoteModel(
//       author: author,
//       content: content,
//     ));
//     getQuote();
//     print("Added");
//   }
//
//   // Future<void> fetchQuotes() async {
//   //   final url = Uri.parse('https://dummyjson.com/quotes/');
//   //   try {
//   //     final response = await get(url);
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //       final fetchedQuotes = (data['quotes'] as List)
//   //           .map<QuoteModel>((json) => QuoteModel.fromJson(json))
//   //           .toList();
//   //       quotesList.addAll(fetchedQuotes);
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching quotes: $e');
//   //   }
//   // }
//
//   Future<QuoteModel> fetchQuotes() async {
//     final url = Uri.parse('https://dummyjson.com/quotes/');
//     try {
//       final response = await get(url);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         return QuoteModel.fromJson(json);
//       } else {
//         throw Exception('Failed to load user: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching user data: $e');
//     }
//   }
// }


//sharepref
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/quoteModel.dart';
import '../util/dbhelper.dart';

class QuoteController extends GetxController {
  var quotes = <QuoteModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var wishlist = <QuoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuotes();
    loadWishlist();
  }

  void addToWishlist(QuoteModel quote) async {
    wishlist.add(quote);
    await DbHelper.dbHelper.addToWishlistDb(quote);
    saveWishlist();
  }

  Future<void> loadWishlist() async {
    final dbWishlist = await DbHelper.dbHelper.getWishlistFromDb();
    wishlist(dbWishlist);
  }

  void removeFromWishlist(int index) async {
    final quote = wishlist[index];
    wishlist.removeAt(index);
    await DbHelper.dbHelper.removeFromWishlistDb(quote.id!);
    saveWishlist();
  }

Future<void> saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = wishlist.map((quote) => quote.toJson()).toList();
    await prefs.setString('wishlist', jsonEncode(wishlistJson));
  }
  //
  // Future<void> loadWishlist() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final wishlistString = prefs.getString('wishlist');
  //   if (wishlistString != null) {
  //     final wishlistData = jsonDecode(wishlistString) as List;
  //     wishlist(wishlistData.map((json) => QuoteModel.fromJson(json)).toList());
  //   }
  // }
  //
  // void removeFromWishlist(int index) {
  //   wishlist.removeAt(index);
  //   saveWishlist();
  // }
  //
  // void addToWishlist(QuoteModel quote) {
  //   wishlist.add(quote);
  //   saveWishlist();
  // }
  //
  Future<void> fetchQuotes() async {
    final url = Uri.parse('https://dummyjson.com/quotes');
    try {
      isLoading(true);
      final response = await get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['quotes'] as List;
        quotes(data.map((json) => QuoteModel.fromJson(json)).toList());
      } else {
        errorMessage('Failed to load quotes: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('Error fetching quotes: $e');
    } finally {
      isLoading(false);
    }
  }
}


//db
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model/quoteModel.dart';
// import '../util/dbhelper.dart';
//
// class QuoteController extends GetxController {
//   var quotes = <QuoteModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchQuotes();
//     loadWishlistFromDb();
//   }
//
//   var wishlist = <QuoteModel>[].obs;
//
//   void addToWishlist(QuoteModel quote) async {
//     await DbHelper.dbHelper.addQuoteWithModel(quote);
//     wishlist.add(quote);
//   }
//
//   Future<void> loadWishlistFromDb() async {
//     var dbQuotes = await DbHelper.dbHelper.getQuotesFromDb();
//     wishlist.assignAll(dbQuotes);
//   }
//
//   Future<void> removeFromWishlist(QuoteModel quote) async {
//     await DbHelper.dbHelper.removeQuoteById(quote.id ?? 0);
//     wishlist.remove(quote);
//   }
//
//   Future<void> fetchQuotes() async {
//     final url = Uri.parse('https://dummyjson.com/quotes');
//     try {
//       isLoading(true);
//       final response = await get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)['quotes'] as List;
//         quotes(data.map((json) => QuoteModel.fromJson(json)).toList());
//       } else {
//         errorMessage('Failed to load quotes: ${response.statusCode}');
//       }
//     } catch (e) {
//       errorMessage('Error fetching quotes: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

// Future<void> saveWishlist() async {
//   final prefs = await SharedPreferences.getInstance();
//   final wishlistJson = wishlist.map((quote) => quote.toJson()).toList();
//   await prefs.setString('wishlist', jsonEncode(wishlistJson));
// }

//}





//
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import '../model/quoteModel.dart';
// import '../util/dbhelper.dart';
//
// class QuoteController extends GetxController {
//   var quotes = <QuoteModel>[].obs;
//   var wishlist = <QuoteModel>[].obs;
//   var isLoading = true.obs;
//   var errorMessage = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchQuotes();
//     loadWishlistFromDb(); // Load wishlist from SQLite when app starts
//   }
//
//   // Load wishlist data from SQLite database
//   Future<void> loadWishlistFromDb() async {
//     var dbQuotes = await DbHelper.dbHelper.getQuotesFromDb();
//     wishlist.assignAll(dbQuotes);  // Update the reactive list with data from DB
//   }
//
//   // Add a quote to the wishlist and database
//   Future<void> addToWishlist(QuoteModel quote) async {
//     await DbHelper.dbHelper.addQuoteWithModel(quote);
//     wishlist.add(quote);
//   }
//
//   // Remove a quote from the wishlist and database
//   Future<void> removeFromWishlist(QuoteModel quote) async {
//     await DbHelper.dbHelper.removeQuoteById(quote.id ?? 0);
//     wishlist.remove(quote);
//   }
//
//   // Fetch quotes from API
//   Future<void> fetchQuotes() async {
//     final url = Uri.parse('https://dummyjson.com/quotes');
//     try {
//       isLoading(true);
//       final response = await get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)['quotes'] as List;
//         quotes(data.map((json) => QuoteModel.fromJson(json)).toList());
//       } else {
//         errorMessage('Failed to load quotes: ${response.statusCode}');
//       }
//     } catch (e) {
//       errorMessage('Error fetching quotes: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
// }
