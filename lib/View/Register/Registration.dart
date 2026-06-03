import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
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
import 'package:waaada_nurseapp/Utils/ShowToast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  late final RegistrationController controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = RegistrationController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        _isInitialized = true;
        controller.getCountryCodes();
        controller.getLanguages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final height002 = media.size.height * 0.02;
    final height0015 = media.size.height * 0.015;
    final height005 = media.size.height * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<RegistrationController>(
        init: controller,
        builder:
            (controller) => SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  width: screenWidth,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height002),
                        TextStyleInterWithPadding(
                          text: Strings.register,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          size: 22.00,
                        ),
                        SizedBox(height: height002),
                        TextStyleInterWithPadding(
                          text: Strings.createAccount,
                          color: blackTextColor,
                          fontWeight: FontWeight.w500,
                          size: 14.00,
                        ),
                        SizedBox(height: height002),
                        Center(
                          child: ProfilePhotoWidget(
                            image: controller.pickedImage,
                            onTap: () {
                              controller.showImageOptions(
                                context,
                                image: controller.selectedImage,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height002),
                        TextInputWidget(
                          controller: controller.fullNameController,
                          label: Strings.fullName,
                          type: TextInputType.text,
                          height: 50,
                          validatorText: Strings.fullNameIsRequired,
                        ),
                        SizedBox(height: height0015),
                        CountryCodeAndPhoneNUmber(
                          validatorText: Strings.phoneNumberIsRequired,
                          countryCodeValidatorText:
                              Strings.countryCodeIsRequired,
                          controller: controller.phoneNumberController,
                          name: Strings.phoneNumber,
                          countrycodes: controller.countryCodes,
                          onCountryCodeSelected: (id) {
                            controller.selectedCountryCodeId = id;
                            controller.update();
                          },
                        ),
                        SizedBox(height: height0015),
                        TextInputWidget(
                          controller: controller.emailController,
                          label: Strings.email,
                          type: TextInputType.emailAddress,
                          height: 50,
                          validatorText: Strings.emailIsRequired,
                        ),
                        SizedBox(height: height0015),
                        Row(
                          children: [
                            Expanded(
                              child: DateOfBirthField(
                                validatorText: Strings.dateOfBirthIsRequired,
                                selectedDateOfBirth:
                                    controller.selectedDateOfBirth,
                                onDateSelected: (date) {
                                  controller.onDateSelected(date);
                                },
                              ),
                            ),
                            Expanded(
                              child: GenderDropdownField(
                                name: Strings.gender,
                                validatorText: Strings.genderIsRequired,
                                onGenderSelected: (gender) {
                                  controller.selectedGender = gender;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height0015),
                        TextInputWidget(
                          controller: controller.qualificationController,
                          label: Strings.qualification,
                          type: TextInputType.text,
                          height: 50,
                          validatorText: Strings.qualificationIsRequired,
                        ),
                        SizedBox(height: height0015),
                        LanguageDropDownWidget(
                          selectedLanguage: controller.selectedLanguage,
                          languageList:
                              controller.languages?.data?.languages ?? const [],
                          name: Strings.language,
                          validatorText: Strings.languageIsRequired,
                          onChanged: (value) {
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
                          },
                        ),
                        SizedBox(
                          height:
                              controller.selectedLanguages.isNotEmpty
                                  ? height0015
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
                                key: const ValueKey('language_chips'),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    key: ValueKey('language_chip_$index'),
                                    padding: const EdgeInsets.only(right: 8),
                                    child: LanguageChip(
                                      label:
                                          controller.selectedLanguages[index],
                                      onDeleted: () {
                                        controller.selectedLanguages.removeAt(
                                          index,
                                        );
                                        controller.update();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height0015),
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
                              controller.isObscureNewPassword =
                                  !controller.isObscureNewPassword;
                              controller.update();
                            },
                          ),
                        ),
                        SizedBox(height: height0015),
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
                              controller.isObscureConfirmPassword =
                                  !controller.isObscureConfirmPassword;
                              controller.update();
                            },
                          ),
                        ),
                        SizedBox(height: height005),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: SubmitButtonWidget(
                            onTap: () {
                              debugPrint(
                                "slectedGender: ${controller.selectedGender}",
                              );
                              if (formKey.currentState?.validate() ?? false) {
                                controller.startRegistrationFlow(
                                  fullname: controller.fullNameController.text,
                                  countryCode:
                                      controller.selectedCountryCodeId
                                          ?.toString() ??
                                      '',
                                  mobile: controller.phoneNumberController.text,
                                  email: controller.emailController.text,
                                  dob:
                                      controller.selectedDateOfBirth != null
                                          ? "${controller.selectedDateOfBirth!.toLocal()}"
                                              .split(' ')[0]
                                          : '',
                                  gender:
                                      controller.selectedGender.toString() ==
                                              "Male"
                                          ? "1"
                                          : controller.selectedGender
                                                  .toString() ==
                                              "Female"
                                          ? "2"
                                          : "3",
                                  qualification:
                                      controller.qualificationController.text,
                                  password:
                                      controller.newPasswordController.text,
                                  passwordConfirmation:
                                      controller.confirmPasswordController.text,
                                  image: controller.pickedImage ?? '',
                                  languages: controller.selectedLanguages,
                                );
                              }
                            },
                            text: Strings.next,
                          ),
                        ),

                        SizedBox(height: height0015),
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
