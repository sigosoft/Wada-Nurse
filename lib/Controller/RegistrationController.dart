import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegistrationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("RegistrationController initialized");
  }

  @override
  void onClose() {
    print("RegistrationController disposed");
    super.onClose();
  }

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscureNewPassword = true;
  bool isObscureConfirmPassword = true;
  List<String> selectedLanguages = [];
  String? selectedGender;
  String selectedType = "";


}