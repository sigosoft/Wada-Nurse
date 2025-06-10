
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/LoginController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/ForgotPassword/ForgotPassword.dart';
import 'package:waaada_nurseapp/Widget/CountryCodeAndPhoneNumber.dart';
import 'package:waaada_nurseapp/Widget/PasswordTextField.dart';
import 'package:waaada_nurseapp/Widget/RichTextWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: LoginController(),
        builder:
            (controller) => SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    TextStyleInterWithPadding(
                      text: Strings.createNewPassword,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 22.00,
                    ),
                    SizedBox(height: 20),
                    TextStyleInterWithPadding(
                      text: Strings.yourPasswordMustUnique,
                      color: blackTextColor,
                      fontWeight: FontWeight.w500,
                      size: 14.00,
                    ),
                    SizedBox(height: 20),
                    PasswordTextField(
                      label: Strings.newPassword,
                      passwordController:
                          controller.passwordControllerCreatePassword1,
                      isObscured: controller.isObscuredForCreateNewPassword1,
                      suffixIcon: IconButton(
                        icon:
                        controller.isObscuredForCreateNewPassword2
                            ? SvgPicture.asset('lib/Assets/Images/eyeOpened.svg')
                            : SvgPicture.asset(
                          'lib/Assets/Images/eyeOpened.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        onPressed: () {
                          setState(() {
                            controller.isObscuredForCreateNewPassword1 =
                                !controller.isObscuredForCreateNewPassword1;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    PasswordTextField(
                      label: Strings.createNewPassword,
                      passwordController:
                          controller.passwordControllerCreatePassword2,
                      isObscured: controller.isObscuredForCreateNewPassword2,
                      suffixIcon: IconButton(
                        icon:
                        controller.isObscuredForCreateNewPassword2
                            ? SvgPicture.asset('lib/Assets/Images/eyeOpened.svg')
                            : SvgPicture.asset(
                          'lib/Assets/Images/eyeOpened.svg',
                          fit: BoxFit.scaleDown,
                        ),
                        onPressed: () {
                          setState(() {
                            controller.isObscuredForCreateNewPassword2 =
                                !controller.isObscuredForCreateNewPassword2;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SubmitButtonWidget(onTap: () {}, text: Strings.submit)),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
