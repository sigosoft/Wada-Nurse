import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint("SplashController initialized");
  }

  @override
  void onClose() {
    debugPrint("SplashController disposed");
    super.onClose();
  }
  
  
  }