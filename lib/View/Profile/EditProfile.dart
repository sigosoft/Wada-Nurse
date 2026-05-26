import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/CountryCodeAndPhoneNumber.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/DateofBirthField.dart';
import 'package:waaada_nurseapp/Widget/GenderDropDownField.dart';
import 'package:waaada_nurseapp/Widget/LanguageChip.dart';
import 'package:waaada_nurseapp/Widget/ProfilePhotoWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextInputWidget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  final RegistrationController controller = Get.put(RegistrationController());
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
      appBar: CustomAppBar(
        label: Strings.editProfile,
        onTap: () {
          Get.back();
        },
      ),
      body: GetBuilder<RegistrationController>(
        init: controller,
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
                        const SizedBox(height: 20),
                        Center(child: ProfilePhotoWidget()),
                        const SizedBox(height: 20),
                        TextInputWidget(
                          label: Strings.fullName,
                          type: TextInputType.text,
                          height: 50,
                        ),
                        const SizedBox(height: 15),
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
                        const SizedBox(height: 15),
                        TextInputWidget(
                          label: Strings.email,
                          type: TextInputType.emailAddress,
                          height: 50,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Expanded(child: DateOfBirthField()),
                            Expanded(
                              child: GenderDropdownField(name: Strings.gender),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextInputWidget(
                          label: Strings.qualification,
                          type: TextInputType.text,
                          height: 50,
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height:
                              controller.selectedLanguages.isNotEmpty ? 15 : 0,
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
                                    padding: const EdgeInsets.only(
                                      right: 8,
                                    ), // spacing between chips
                                    child: LanguageChip(
                                      label:
                                          controller.selectedLanguages[index],
                                      onDeleted: () {
                                        setState(() {
                                          controller.selectedLanguages.removeAt(
                                            index,
                                          );
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: SubmitButtonWidget(
                            onTap: () {
                              if (formKey.currentState?.validate() ?? false) {
                                // Form submission logic
                              }
                            },
                            text: Strings.next,
                          ),
                        ),
                        const SizedBox(height: 15),
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
