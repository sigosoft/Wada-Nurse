import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/LoginController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/ForgotPassword/ForgotPassword.dart';
import 'package:waaada_nurseapp/View/Register/Registration.dart';
import 'package:waaada_nurseapp/Widget/CountryCodeAndPhoneNumber.dart';
import 'package:waaada_nurseapp/Widget/PasswordTextField.dart';
import 'package:waaada_nurseapp/Widget/RichTextWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import '../Home/Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      text: Strings.logInWithPhoneNumber,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 22.00,
                    ),
                    SizedBox(height: 20),
                    TextStyleInterWithPadding(
                      text: Strings.enterYourPhoneNumber,
                      color: blackTextColor,
                      fontWeight: FontWeight.w500,
                      size: 14.00,
                    ),
                    SizedBox(height: 20),
                    CountryCodeAndPhoneNUmber(name: Strings.phoneNumber),
                    SizedBox(height: 20),
                    PasswordTextField(
                      passwordController: controller.passwordController,
                      isObscured: controller.isObscured,
                      suffixIcon:  IconButton(
                        icon:
                        controller.isObscured
                            ? Icon(Icons.visibility_off_outlined,
                            size: 18,
                            color: Colors.grey)
                            :Icon(Icons.visibility_outlined,
                            size: 18,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                           controller.isObscured = !controller.isObscured;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => ForgotPassword());
                          },
                          child: TextStyleInterWithPadding(
                            text: Strings.forgotPassword,
                            color: blackTextColor,
                            fontWeight: FontWeight.w600,
                            size: 12.00,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SubmitButtonWidget(onTap: () {Get.to(Home());}, text: Strings.next)),
                    SizedBox(height: 15),
                    RichTextWidget(
                      text1: Strings.dontHaveAnAccount,
                      text2: Strings.signUp,
                      onTap: () {
                        Get.to(Register());
                      },
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

