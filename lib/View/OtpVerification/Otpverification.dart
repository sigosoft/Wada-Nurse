import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/LoginController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/CreateNewPassword/CreateNewPassword.dart';
import 'package:waaada_nurseapp/Widget/PinputWidget.dart';
import 'package:waaada_nurseapp/Widget/RichTextWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpScreen2State();
}

class _OtpScreen2State extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: LoginController(),
            builder:(controller) =>  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                TextStyleInterWithPadding(
                  text: Strings.otpVerification,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 22.00,
                ),
                SizedBox(height: 20),
                TextStyleInterWithPadding(
                  text: Strings.enterVerificationCodeSendToYourNumber,
                  color: blackTextColor,
                  fontWeight: FontWeight.w500,
                  size: 14.00,
                ),
                SizedBox(height: 30),
                PinPutWidget(),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: SubmitButtonWidget(
                    text: Strings.verify,
                    onTap: (){
                    Get.off(CreateNewPassword());
                    },
                  ),
                ),
                SizedBox(height: 20),
                RichTextWidget(
                  text1:Strings.didNotReceiveCode,
                  text2: Strings.resend,
                  onTap:(){

                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


