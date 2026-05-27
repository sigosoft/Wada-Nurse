import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/ChangePasswordController.dart';
import 'package:waaada_nurseapp/Controller/LoginController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/PasswordTextField.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: Strings.changePassword,
        onTap: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: ChangePasswordController(),
        builder:
            (controller) => SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          PasswordTextField(
                            label: Strings.currentPassword,
                            passwordController:
                                controller.currentPasswordController,
                            isObscured: controller.isObscuredCurrentPassword,
                            suffixIcon: IconButton(
                              icon:
                                  controller.isObscuredCurrentPassword
                                      ? Icon(Icons.visibility_off_outlined,
                                      size: 18,
                                      color: Colors.grey)
                                      :Icon(Icons.visibility_outlined,
                                      size: 18,
                                      color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  controller.isObscuredCurrentPassword =
                                      !controller.isObscuredCurrentPassword;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          PasswordTextField(
                            label: Strings.newPassword,
                            passwordController:
                                controller.newPasswordController,
                            isObscured: controller.isObscuredNewPassword,
                            suffixIcon: IconButton(
                              icon:
                                  controller.isObscuredNewPassword
                                      ? Icon(Icons.visibility_off_outlined,
                                      size: 18,
                                      color: Colors.grey)
                                      :Icon(Icons.visibility_outlined,
                                      size: 18,
                                      color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  controller.isObscuredNewPassword =
                                      !controller.isObscuredNewPassword;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          PasswordTextField(
                            label: Strings.confirmNewPassword,
                            passwordController:
                                controller.confirmNewPasswordController,
                            isObscured: controller.isObscuredConfirmNewPassword,
                            suffixIcon: IconButton(
                              icon:
                                  controller.isObscuredConfirmNewPassword
                                      ? Icon(Icons.visibility_off_outlined,
                                      size: 18,
                                      color: Colors.grey)
                                      :Icon(Icons.visibility_outlined,
                                      size: 18,
                                      color: Colors.grey),
                              onPressed: () {
                                setState(() {
                                  controller.isObscuredConfirmNewPassword =
                                      !controller.isObscuredConfirmNewPassword;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: SubmitButtonWidget(
                        onTap: () {
                          final currentPass = controller.currentPasswordController.text.trim();
                          final newPass = controller.newPasswordController.text.trim();
                          final confirmPass = controller.confirmNewPasswordController.text.trim();

                          if (currentPass.isEmpty) {
                            showToast("Please enter current password", isError: true);
                            return;
                          }
                          if (newPass.isEmpty) {
                            showToast("Please enter new password", isError: true);
                            return;
                          }
                          if (newPass.length < 8) {
                            showToast("New password must be at least 8 characters long", isError: true);
                            return;
                          }
                          if (confirmPass.isEmpty) {
                            showToast("Please confirm your new password", isError: true);
                            return;
                          }
                          if (newPass != confirmPass) {
                            showToast("New passwords do not match", isError: true);
                            return;
                          }

                          controller.changePassword(
                            currentPassword: currentPass,
                            newPassword: newPass,
                            confirmPassword: confirmPass,
                          ).then((success) {
                            if (success) {
                              Get.back(); // Go back on success
                            }
                          });
                        },
                        text: Strings.save,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
