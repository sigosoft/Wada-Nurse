import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/Register/DocumentationUploadScreen.dart';
import 'package:waaada_nurseapp/Widget/CountryCodeAndPhoneNumber.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/DateofBirthField.dart';
import 'package:waaada_nurseapp/Widget/GenderDropDownField.dart';
import 'package:waaada_nurseapp/Widget/LanguageChip.dart';
import 'package:waaada_nurseapp/Widget/LanguageDropDownWidget.dart';
import 'package:waaada_nurseapp/Widget/PasswordTextField.dart';
import 'package:waaada_nurseapp/Widget/ProfilePhotoWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextInputWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.editProfile, onTap: () {
        Get.back();
      }),
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
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: SubmitButtonWidget(onTap: () {

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
