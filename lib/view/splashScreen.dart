import 'dart:async';
import 'package:flutter/material.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
                "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/9e/95/1e/9e951eff-4290-ee2f-fb6c-f58d9c105055/QuotaAppIcon-0-1x_U007emarketing-0-10-0-85-220.jpeg/1200x630wa.png"),
          )),
    );
  }
}
