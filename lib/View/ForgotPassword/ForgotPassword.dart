import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/LoginController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/AppbarWithoutElevation.dart';
import 'package:waaada_nurseapp/Widget/CountryCodeAndPhoneNumber.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        _isInitialized = true;
        controller.getCountryCodes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarWithoutElevation(),
      body: GetBuilder<LoginController>(
        init: controller,
        builder:
            (controller) => SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextStyleInterWithPadding(
                        text: Strings.forgotPasswordHeading,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        size: 22.00,
                      ),
                      const SizedBox(height: 20),
                      TextStyleInterWithPadding(
                        text: Strings.enterPhoneNumberLinkedWithYourNumber,
                        color: blackTextColor,
                        fontWeight: FontWeight.w500,
                        size: 14.00,
                      ),
                      const SizedBox(height: 20),
                      CountryCodeAndPhoneNUmber(
                        validatorText: "Phone Number is required",
                        controller: controller.phoneNumberController,
                        name: Strings.phoneNumber,
                        countrycodes: controller.countryCodes,
                        onCountryCodeSelected: (id) {
                          controller.selectedCountryCodeId = id;
                          controller.update();
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: SubmitButtonWidget(
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.sendForgotOtp(
                                mobile: controller.phoneNumberController.text,
                                countryCodeId: controller.selectedCountryCodeId?.toString() ?? "1",
                              );
                            }
                          },
                          text: Strings.submit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
