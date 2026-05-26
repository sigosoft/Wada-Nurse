import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Controller/LoginController.dart';
import 'package:waaada_nurseapp/Model/RegistrationData.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
import 'package:waaada_nurseapp/Widget/PinputWidget.dart';
import 'package:waaada_nurseapp/Widget/RichTextWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({
    super.key,
    this.registrationData,
    this.isForgotPassword = false,
    this.mobile,
    this.countryCode,
  });
  final RegistrationData? registrationData;
  final bool isForgotPassword;
  final String? mobile;
  final String? countryCode;

  @override
  State<OtpVerification> createState() => _OtpScreen2State();
}

class _OtpScreen2State extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: RegistrationController(),
            builder:
                (controller) => Column(
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
                    PinPutWidget(
                      length: 6,
                      onCompleted: (value) {
                        controller.otp = value;
                        controller.update();
                      },
                    ),
                    SizedBox(height: 30),
                    SubmitButtonWidget(
                      text: Strings.verify,
                      onTap: () {
                        if (controller.otp?.length != 6) {
                          showToast("Please enter a valid OTP", isError: true);
                          return;
                        } else {
                          if (widget.isForgotPassword) {
                            Get.find<LoginController>().verifyForgotOtp(
                              mobile: widget.mobile!,
                              countryCodeId: widget.countryCode!,
                              otp: controller.otp!,
                            );
                          } else {
                            controller.postRegistrationData(
                              widget.registrationData!,
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    RichTextWidget(
                      text1: Strings.didNotReceiveCode,
                      text2: Strings.resend,
                      onTap: () {
                        if (widget.isForgotPassword) {
                          Get.find<LoginController>().sendForgotOtp(
                            mobile: widget.mobile!,
                            countryCodeId: widget.countryCode!,
                          );
                        } else {
                          controller.sendRegisterOtp(
                            mobile: widget.registrationData!.mobile,
                            countryCode: widget.registrationData!.countryCode,
                            registrationData: widget.registrationData!,
                          );
                        }
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
