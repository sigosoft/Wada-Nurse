import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Controller/ProfileController.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Model/CountryCodeModel.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
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

        // 1. Fetch country codes and map selected country code id
        controller.getCountryCodes().then((_) {
          if (Get.isRegistered<ProfileController>()) {
            final profileCtrl = Get.find<ProfileController>();
            final nurse = profileCtrl.profileModel?.data.nurse;
            if (nurse != null && nurse.countryCode != null) {
              CountryCode? matchedCc;
              for (var cc in controller.countryCodes) {
                if (cc.countryCode == nurse.countryCode.toString()) {
                  matchedCc = cc;
                  break;
                }
              }
              if (matchedCc != null) {
                controller.selectedCountryCodeId = matchedCc.id;
                controller.update();
              }
            }
          }
        });

        // 2. Fetch languages and map selected language names
        controller.getLanguages().then((_) {
          if (Get.isRegistered<ProfileController>()) {
            final profileCtrl = Get.find<ProfileController>();
            final nurse = profileCtrl.profileModel?.data.nurse;
            if (nurse != null && nurse.nurseLanguages != null) {
              final List<String> mappedLangs = [];
              for (var nl in nurse.nurseLanguages) {
                if (controller.languages?.data?.languages != null) {
                  for (var l in controller.languages!.data!.languages!) {
                    if (l.id == nl.languageId && l.language != null) {
                      mappedLangs.add(l.language!);
                      break;
                    }
                  }
                }
              }
              controller.selectedLanguages = mappedLangs;
              controller.update();
            }
          }
        });

        // 3. Map immediately available fields
        if (Get.isRegistered<ProfileController>()) {
          final profileCtrl = Get.find<ProfileController>();
          final nurse = profileCtrl.profileModel?.data.nurse;
          if (nurse != null) {
            controller.fullNameController.text = nurse.name?.toString() ?? "";
            controller.emailController.text = nurse.email?.toString() ?? "";
            controller.qualificationController.text =
                nurse.qualification?.toString() ?? "";
            controller.phoneNumberController.text =
                nurse.mobile?.toString() ?? "";

            if (nurse.dob != null) {
              controller.selectedDateOfBirth =
                  nurse.dob is DateTime
                      ? nurse.dob
                      : DateTime.tryParse(nurse.dob.toString());
            } else {
              controller.selectedDateOfBirth = null;
            }

            if (nurse.gender != null) {
              if (nurse.gender == 1) {
                controller.selectedGender = 'Male';
              } else if (nurse.gender == 2) {
                controller.selectedGender = 'Female';
              } else {
                controller.selectedGender = 'Other';
              }
            } else {
              controller.selectedGender = null;
            }

            if (nurse.image != null &&
                nurse.image.toString().isNotEmpty &&
                nurse.image.toString() != "null") {
              controller.pickedImage =
                  ApiConfigs.Image_URL + nurse.image.toString();
            } else {
              controller.pickedImage = null;
            }

            controller.update();
          }
        }
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
                        Center(
                          child: ProfilePhotoWidget(
                            image: controller.pickedImage,
                            onTap: () {
                              controller.showImageOptions(context);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextInputWidget(
                          label: Strings.fullName,
                          type: TextInputType.text,
                          height: 50,
                          controller: controller.fullNameController,
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
                          controller: controller.emailController,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: DateOfBirthField(
                                selectedDateOfBirth:
                                    controller.selectedDateOfBirth,
                                onDateSelected: controller.onDateSelected,
                              ),
                            ),
                            Expanded(
                              child: GenderDropdownField(
                                name: Strings.gender,
                                initialGender: controller.selectedGender,
                                onGenderSelected: (gender) {
                                  controller.selectedGender = gender;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextInputWidget(
                          label: Strings.qualification,
                          type: TextInputType.text,
                          height: 50,
                          controller: controller.qualificationController,
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
                                if (controller.selectedCountryCodeId == null) {
                                  showToast("Please select country code", isError: true);
                                  return;
                                }
                                if (controller.selectedGender == null) {
                                  showToast("Please select gender", isError: true);
                                  return;
                                }
                                if (controller.selectedDateOfBirth == null) {
                                  showToast("Please select date of birth", isError: true);
                                  return;
                                }

                                // Map selected languages to their database IDs
                                List<String> languageIds = [];
                                if (controller.languages?.data?.languages != null) {
                                  for (var name in controller.selectedLanguages) {
                                    for (var lang in controller.languages!.data!.languages!) {
                                      if (lang.language?.toLowerCase().trim() == name.toLowerCase().trim()) {
                                        if (lang.id != null) {
                                          languageIds.add(lang.id.toString());
                                        }
                                        break;
                                      }
                                    }
                                  }
                                }
                                if (languageIds.isEmpty && controller.selectedLanguages.isNotEmpty) {
                                  languageIds = controller.selectedLanguages;
                                }

                                // Format DOB to string YYYY-MM-DD
                                final dobString = "${controller.selectedDateOfBirth!.toLocal()}".split(' ')[0];

                                if (Get.isRegistered<ProfileController>()) {
                                  final profileCtrl = Get.find<ProfileController>();
                                  profileCtrl.updateProfile(
                                    name: controller.fullNameController.text,
                                    countryCode: controller.selectedCountryCodeId.toString(),
                                    mobile: controller.phoneNumberController.text,
                                    email: controller.emailController.text,
                                    dob: dobString,
                                    gender: controller.selectedGender!,
                                    qualification: controller.qualificationController.text,
                                    languages: languageIds,
                                    pickedImagePath: controller.pickedImage,
                                  ).then((success) {
                                    if (success) {
                                      Get.back(); // Go back to profile screen on success
                                    }
                                  });
                                }
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
