import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("ChangePasswordController initialized");
  }

  @override
  void onClose() {
    print("ChangePasswordController disposed");
    super.onClose();
  }

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool isObscuredCurrentPassword = true;
  bool isObscuredNewPassword = true;
  bool isObscuredConfirmNewPassword = true;
}