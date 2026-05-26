import 'package:flutter/material.dart';
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
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
import '../Home/Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    children: [
                      const SizedBox(height: 100),
                      TextStyleInterWithPadding(
                        text: Strings.logInWithPhoneNumber,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        size: 22.00,
                      ),
                      const SizedBox(height: 20),
                      TextStyleInterWithPadding(
                        text: Strings.enterYourPhoneNumber,
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
                      PasswordTextField(
                        passwordController: controller.passwordController,
                        isObscured: controller.isObscured,
                        suffixIcon: IconButton(
                          icon:
                              controller.isObscured
                                  ? const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  )
                                  : const Icon(
                                    Icons.visibility_outlined,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                          onPressed: () {
                            controller.isObscured = !controller.isObscured;
                            controller.update();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => const ForgotPassword());
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
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: SubmitButtonWidget(
                          onTap:
                              controller.isLoading
                                  ? null
                                  : () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      if (controller.passwordController.text
                                          .trim()
                                          .isEmpty) {
                                        showToast(
                                          "Password is required",
                                          isError: true,
                                        );
                                        return;
                                      }
                                      controller.login();
                                    }
                                  },
                          text: Strings.next,
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichTextWidget(
                        text1: Strings.dontHaveAnAccount,
                        text2: Strings.signUp,
                        onTap: () {
                          Get.to(() => const Register());
                        },
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
