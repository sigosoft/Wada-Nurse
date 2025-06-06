import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Resource/Colors.dart';

class BookingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("BookingsController initialized");
  }

  @override
  void onClose() {
    print("BookingsController disposed");
    super.onClose();
  }
  Color boxColor1 =colorPrimary;
  Color textColor1 =Colors.white;
  Color boxColor2 =colorPrimaryWith25Opacity;
  Color textColor2 =colorPrimary;
  bool switchValue=true;
  double sizedBoxHeight = 150.00;

  List<String>attatchmentList = [
    'lib/Assets/Images/attatchmentDummy.png',
    'lib/Assets/Images/attatchmentDummy.png',
    'lib/Assets/Images/attatchmentDummy.png',
  ];

  void swapColors() {
    final tempBoxColor = boxColor1;
    final tempTextColor = textColor1;
    boxColor1 = boxColor2;
    textColor1 = textColor2;
    boxColor2 = tempBoxColor;
    textColor2 = tempTextColor;
    switchValue=!switchValue;
    update();
  }


  List<String> itemList=[
    "All",
    "George Jacob",
    "Merlin Thomas ",
    "Thomas James",
    "John Doe",
  ];
}