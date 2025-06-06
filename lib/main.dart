import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/View/Splash/Splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintSizeEnabled=false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen()
    );
  }
}