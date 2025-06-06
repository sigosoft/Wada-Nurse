import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/Register/DocumentationUploadScreen.dart';
import 'package:waaada_nurseapp/Widget/AgreeWithTermsWidget.dart';
import 'package:waaada_nurseapp/Widget/AppbarWithoutElevation.dart';
import 'package:waaada_nurseapp/Widget/CountryCodeAndPhoneNumber.dart';
import 'package:waaada_nurseapp/Widget/DateofBirthField.dart';
import 'package:waaada_nurseapp/Widget/GenderDropDownField.dart';
import 'package:waaada_nurseapp/Widget/LanguageChip.dart';
import 'package:waaada_nurseapp/Widget/LanguageDropDownWidget.dart';
import 'package:waaada_nurseapp/Widget/PasswordTextField.dart';
import 'package:waaada_nurseapp/Widget/ProfilePhotoWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextInputWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: RegistrationController(),
        builder:
            (controller) => SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      TextStyleInterWithPadding(
                        text: Strings.register,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        size: 22.00,
                      ),
                      SizedBox(height: 20),
                      TextStyleInterWithPadding(
                        text: Strings.createAccount,
                        color: blackTextColor,
                        fontWeight: FontWeight.w500,
                        size: 14.00,
                      ),
                      SizedBox(height: 20),
                      Center(child: ProfilePhotoWidget()),
                      SizedBox(height: 20),
                      TextInputWidget(
                        label: Strings.fullName,
                        type: TextInputType.text,
                        height: 50,
                      ),
                      SizedBox(height: 15),
                      CountryCodeAndPhoneNUmber(name: Strings.phoneNumber),
                      SizedBox(height: 15),
                      TextInputWidget(
                        label: Strings.email,
                        type: TextInputType.emailAddress,
                        height: 50,
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(child: DateOfBirthField()),
                          Expanded(
                            child: GenderDropdownField(name: Strings.gender),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      TextInputWidget(
                        label: Strings.qualification,
                        type: TextInputType.text,
                        height: 50,
                      ),
                      SizedBox(height: 15),
                      LanguageDropDownWidget(
                        selectedGender: controller.selectedGender,
                        name: Strings.language,onChanged:  (value) {
                        setState(() {
                          controller.selectedGender = value;
                          if (!controller.selectedLanguages.contains(value)) {
                            controller.selectedLanguages.add(value);
                          }
                        });
                      },),
                      SizedBox(height:controller.selectedLanguages.isNotEmpty?15:0),
                      Visibility(
                        visible: controller.selectedLanguages.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.selectedLanguages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8), // spacing between chips
                                  child: LanguageChip(
                                    label: controller.selectedLanguages[index],
                                    onDeleted: () {
                                      setState(() {
                                        controller.selectedLanguages.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      PasswordTextField(
                        label: Strings.newPassword,
                        passwordController: controller.newPasswordController,
                        isObscured: controller.isObscureNewPassword,
                        suffixIcon: IconButton(
                          icon:
                              controller.isObscureNewPassword
                                  ? SvgPicture.asset(
                                    'lib/Assets/Images/eyeOpened.svg',
                                  )
                                  : SvgPicture.asset(
                                    'lib/Assets/Images/eyeOpened.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                          onPressed: () {
                            setState(() {
                              controller.isObscureNewPassword =
                                  !controller.isObscureNewPassword;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      PasswordTextField(
                        label: Strings.confirmNewPassword,
                        passwordController:
                            controller.confirmPasswordController,
                        isObscured: controller.isObscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon:
                              controller.isObscureConfirmPassword
                                  ? SvgPicture.asset(
                                    'lib/Assets/Images/eyeOpened.svg',
                                  )
                                  : SvgPicture.asset(
                                    'lib/Assets/Images/eyeOpened.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                          onPressed: () {
                            setState(() {
                              controller.isObscureConfirmPassword =
                                  !controller.isObscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SubmitButtonWidget(onTap: () {
                          Get.off(DocumentationUploadScreen());
                        }, text: Strings.next),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
