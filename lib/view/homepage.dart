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
