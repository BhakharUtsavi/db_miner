// import 'package:db_miner/controller/homeController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   HomeController homeController=Get.put(HomeController());
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//     //   Scaffold(
//     //   appBar: AppBar(
//     //     actions: [
//     //       IconButton(
//     //           onPressed: () {
//     //             Get.toNamed('wishlist');
//     //           },
//     //           icon: Icon(Icons.favorite)),
//     //
//     //       IconButton(
//     //           onPressed: () {
//     //             Get.changeThemeMode(
//     //                 Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
//     //           },
//     //           icon: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light)),
//     //     ],
//     //   ),
//     //   body: Obx(() {
//     //     return ListView.builder(
//     //       itemCount: homeController.quotesList.length,
//     //         itemBuilder: (context, index) {
//     //         final qm = homeController.quotesList[index];
//     //        // QuoteModel qm=QuoteModel.fromJson(homeController.quotesList[index]);
//     //       return GestureDetector(
//     //         onTap: (){
//     //           Get.toNamed("detailpage",arguments: qm);
//     //         },
//     //         child: Container(
//     //           height: 100,
//     //           width: double.infinity,
//     //           decoration: BoxDecoration(
//     //             borderRadius: BorderRadius.circular(10),
//     //           ),
//     //           child: Text(qm.content ?? ""),
//     //         ),
//     //       );
//     //     });
//     //   }),
//     // );
//       Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Get.toNamed('wishlist');
//                 },
//                 icon: Icon(Icons.favorite)),
//             IconButton(
//                 onPressed: () {
//                   Get.changeThemeMode(
//                       Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
//                 },
//                 icon: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light)),
//           ],
//         ),
//         body: Obx(() {
//           // Ensure quotesList is used properly
//           return ListView.builder(
//             itemCount: homeController.quotesList.length,
//             itemBuilder: (context, index) {
//               final qm = homeController.quotesList[index];
//               return GestureDetector(
//                 onTap: () {
//                   Get.toNamed("detailpage", arguments: qm);
//                 },
//                 child: Container(
//                   height: 100,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(qm.content ?? ""),
//                 ),
//               );
//             },
//           );
//         }),
//       );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/homeController.dart';
//
// class HomePage extends StatelessWidget {
//   final HomeController homeController = Get.put(HomeController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Quotes List"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.changeThemeMode(
//                 Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
//               );
//             },
//             icon: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light_mode),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (homeController.quotesList.isEmpty) {
//           return Center(child: Text("No quotes available."));
//         }
//         return ListView.builder(
//           itemCount: homeController.quotesList.length,
//           itemBuilder: (context, index) {
//             final quote = homeController.quotesList[index];
//             return Card(
//               margin: EdgeInsets.all(8),
//               child: ListTile(
//                 onTap: () {
//                   Get.toNamed("detailpage", arguments: quote);
//                 },
//                 title: Text(
//                   quote.content ?? "No content",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(quote.author ?? "Unknown author"),
//                 trailing: Icon(Icons.arrow_forward),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/homeController.dart';

class HomeScreen extends StatelessWidget {
  final QuoteController controller = Get.put(QuoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quotes',style: GoogleFonts.raleway(),),
          actions: [
          IconButton(
              onPressed: () {
                 Get.toNamed('/wishlist');
              },
              icon: Icon(Icons.favorite)),

          IconButton(
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
              icon: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light)),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.quotes.isEmpty) {
          return Center(child: Text('No quotes available.'));
        } else {
          return ListView.separated(
            separatorBuilder: (context,index){
              return Divider();
            },
            itemCount: controller.quotes.length,
            itemBuilder: (context, index) {
              final item = controller.quotes[index];
              return GestureDetector(
                onTap: (){
                  Get.toNamed("detailpage",arguments: item);
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item.quote ?? "",style: GoogleFonts.raleway(),),
                              SizedBox(height: 10,),
                              Text("- ${item.author ?? ""}",style: GoogleFonts.raleway(),),
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        Icon(Icons.arrow_forward_ios,size: 20,)
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
