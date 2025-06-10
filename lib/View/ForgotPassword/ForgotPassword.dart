import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/LoginController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/OtpVerification/Otpverification.dart';
import 'package:waaada_nurseapp/Widget/AppbarWithoutElevation.dart';
import 'package:waaada_nurseapp/Widget/CountryCodeAndPhoneNumber.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWithoutElevation(),
      body: GetBuilder(
        init: LoginController(),
        builder:
            (controller) => SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                TextStyleInterWithPadding(
                  text: Strings.forgotPasswordHeading,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 22.00,
                ),
                SizedBox(height: 20),
                TextStyleInterWithPadding(
                  text: Strings.enterPhoneNumberLinkedWithYourNumber,
                  color: blackTextColor,
                  fontWeight: FontWeight.w500,
                  size: 14.00,
                ),
                SizedBox(height: 20),
                CountryCodeAndPhoneNUmber(name: Strings.phoneNumber),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: SubmitButtonWidget(onTap: () {
                    Get.off(OtpVerification());
                  }, text: Strings.submit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

