import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/Register/DocumentationUploadScreen.dart';
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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: RegistrationController(),
        didChangeDependencies: (state) {
          debugPrint("didChangeDependencies");
          state.controller?.getCountryCodes();
          state.controller?.getLanguages();
        },
        builder:
            (controller) => SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: media.size.height * 0.02),
                        TextStyleInterWithPadding(
                          text: Strings.register,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          size: 22.00,
                        ),
                        SizedBox(height: media.size.height * 0.02),
                        TextStyleInterWithPadding(
                          text: Strings.createAccount,
                          color: blackTextColor,
                          fontWeight: FontWeight.w500,
                          size: 14.00,
                        ),
                        SizedBox(height: media.size.height * 0.02),
                        Center(
                          child: ProfilePhotoWidget(
                            image: controller.pickedImage,
                            onTap: () {
                              controller.showImageOptions(
                                context,
                                controller.selectedImage,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: media.size.height * 0.02),
                        TextInputWidget(
                          controller: controller.fullNameController,
                          label: Strings.fullName,
                          type: TextInputType.text,
                          height: 50,
                          validatorText: "Full Name is required",
                        ),
                        SizedBox(height: media.size.height * 0.015),
                        CountryCodeAndPhoneNUmber(
                          controller: controller.phoneNumberController,
                          name: Strings.phoneNumber,
                          countrycodes: controller.countryCodes,
                        ),
                        SizedBox(height: media.size.height * 0.015),
                        TextInputWidget(
                          controller: controller.emailController,
                          label: Strings.email,
                          type: TextInputType.emailAddress,
                          height: 50,
                        ),
                        SizedBox(height: media.size.height * 0.015),
                        Row(
                          children: [
                            Expanded(child: DateOfBirthField()),
                            Expanded(
                              child: GenderDropdownField(name: Strings.gender),
                            ),
                          ],
                        ),
                        SizedBox(height: media.size.height * 0.015),
                        TextInputWidget(
                          controller: controller.qualificationController,
                          label: Strings.qualification,
                          type: TextInputType.text,
                          height: 50,
                        ),
                        SizedBox(height: media.size.height * 0.015),
                        LanguageDropDownWidget(
                          selectedLanguage: controller.selectedLanguage,
                          languageList:
                              controller.languages?.data?.languages ?? [],
                          name: Strings.language,
                          onChanged: (value) {
                            setState(() {
                              controller.selectedLanguage = value;
                              if (value != null &&
                                  !controller.selectedLanguages.contains(
                                    value.language ?? '',
                                  )) {
                                controller.selectedLanguages.add(
                                  value.language ?? '',
                                );
                              }
                              controller.selectedLanguage = null;
                              controller.update();
                            });
                          },
                        ),
                        SizedBox(
                          height:
                              controller.selectedLanguages.isNotEmpty
                                  ? media.size.height * 0.015
                                  : 0,
                        ),
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
                                    padding: const EdgeInsets.only(right: 8),
                                    child: LanguageChip(
                                      label:
                                          controller.selectedLanguages[index],
                                      onDeleted: () {
                                        setState(() {
                                          controller.selectedLanguages.removeAt(
                                            index,
                                          );
                                          controller.update();
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: media.size.height * 0.015),
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
                        SizedBox(height: media.size.height * 0.015),
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
                        SizedBox(height: media.size.height * 0.05),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: SubmitButtonWidget(
                            onTap: () {
                              if (formKey.currentState?.validate() ?? false) {
                                Get.off(DocumentationUploadScreen());
                              }
                            },
                            text: Strings.next,
                          ),
                        ),

                        SizedBox(height: media.size.height * 0.015),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
