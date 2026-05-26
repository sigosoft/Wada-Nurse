import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waaada_nurseapp/Utils/utils.dart';
import 'package:waaada_nurseapp/View/Home/Home.dart';
import 'package:waaada_nurseapp/View/Splash/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final token = getSavedObject("token");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token != null ? Home() : const SplashScreen(),
    );
  }
}
