import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("LoginController initialized");
  }

  @override
  void onClose() {
    print("LoginController disposed");
    super.onClose();
  }

  bool isObscured = true;
  bool isObscuredForCreateNewPassword1 = true;
  bool isObscuredForCreateNewPassword2 = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerCreatePassword1 = TextEditingController();
  TextEditingController passwordControllerCreatePassword2 = TextEditingController();
}
