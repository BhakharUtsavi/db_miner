// import 'package:animated_react_button/animated_react_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/detailcontroller.dart';
// import '../model/quote.dart';
//
// class DetailPage extends StatefulWidget {
//   const DetailPage({super.key});
//
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   //DetailController detailController = Get.put(DetailController());
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final QuoteModel newQuote = Get.arguments as QuoteModel;
//     //detailController.setQuote(quote);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           AnimatedReactButton(
//             defaultColor: Colors.grey,
//             reactColor: Colors.red,
//             onPressed: () async {
//               await Future.delayed(Duration(seconds: 1));
//               // detailController.addToWishlist(detailController.quote.value);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Added to wishlist!")),
//               );
//               // detailController.likedQuotes.add((args));
//               // detailController.likeQuote(quote);
//               // if (detailController.quote!= null) {
//               //   await detailController.likedQuotes?(
//               //     QuoteModel(
//               //       id: detailController.quote?.id,
//               //       content: detailController.quote?.content,
//               //       author: detailController.quote?.author,
//               //     ),
//               //   );
//               // }
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(newQuote.content ?? ""),
//                 SizedBox(height: 10),
//                 Text("- ${newQuote.author ?? ""}"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:db_miner/controller/detailcontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../model/quoteModel.dart';
//
// class DetailPage extends StatelessWidget {
//   DetailController detailController = DetailController();
//
//   @override
//   Widget build(BuildContext context) {
//     final QuoteModel args = Get.arguments as QuoteModel;
//
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               detailController.addToWishlist(args);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Added to wishlist!")),
//               );
//               Get.back();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "${args.quote ?? ""}",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10),
//             Text(
//               "- ${args.author}",
//               style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:animated_react_button/animated_react_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/homeController.dart';
import '../model/quoteModel.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final QuoteController quoteController = Get.put(QuoteController());
  @override
  Widget build(BuildContext context) {
    final QuoteModel args = Get.arguments as QuoteModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes Detail',style: GoogleFonts.raleway(),),
        actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AnimatedReactButton(
              defaultColor: Colors.grey,
               reactColor: Colors.red,
              onPressed: (){
                quoteController.addToWishlist(args);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Added to wishlist!",style: GoogleFonts.raleway(),)),
            );
          }),
        )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              args.quote ?? "",style: GoogleFonts.raleway(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "- ${args.author}",style: GoogleFonts.raleway(),
            ),
          ],
        ),
      ),
    );
  }
}

