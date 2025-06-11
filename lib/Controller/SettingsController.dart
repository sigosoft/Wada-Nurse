import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isLoading = false.obs;
  bool tabValue = false;
  List<bool> expanded = [false,false,false,false,false];
  List<Map<String, String>> faqData = [
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle': 'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle': 'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle': 'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle': 'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle': 'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

}