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
                                      ? SvgPicture.asset(
                                        'lib/Assets/Images/eyeOpened.svg',
                                      )
                                      : SvgPicture.asset(
                                        'lib/Assets/Images/eyeOpened.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
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
                                      ? SvgPicture.asset(
                                        'lib/Assets/Images/eyeOpened.svg',
                                      )
                                      : SvgPicture.asset(
                                        'lib/Assets/Images/eyeOpened.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
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
                                      ? SvgPicture.asset(
                                        'lib/Assets/Images/eyeOpened.svg',
                                      )
                                      : SvgPicture.asset(
                                        'lib/Assets/Images/eyeOpened.svg',
                                        fit: BoxFit.scaleDown,
                                      ),
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
                        onTap: () {},
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
