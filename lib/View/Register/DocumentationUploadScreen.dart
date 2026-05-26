import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Model/RegistrationData.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/Settings/PrivacyPolicy.dart';
import 'package:waaada_nurseapp/View/Settings/TermsAndConditions.dart';
import 'package:waaada_nurseapp/Widget/AgreeWithTermsWidget.dart';
import 'package:waaada_nurseapp/Widget/AppbarWithoutElevation.dart';
import 'package:waaada_nurseapp/Widget/CustomRadioTile.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/UploadRecordWidget.dart';
import 'package:waaada_nurseapp/Widget/UploadedFilesListView.dart';
import 'package:waaada_nurseapp/Widget/TextInputWidget.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';

class DocumentationUploadScreen extends StatefulWidget {
  const DocumentationUploadScreen({
    super.key,
    required this.image,
    required this.fullName,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.qualification,
    required this.languages,
    required this.password,
    required this.confirmPassword,
    required this.otp,
  });
  final XFile image;
  final String fullName;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String dateOfBirth;
  final String gender;
  final String qualification;
  final List<String> languages;
  final String password;
  final String confirmPassword;
  final String otp;
  @override
  State<DocumentationUploadScreen> createState() =>
      _DocumentationUploadScreenState();
}

class _DocumentationUploadScreenState extends State<DocumentationUploadScreen> {
  final formKey = GlobalKey<FormState>();
  bool _showTermsError = false;
  bool _isTermsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWithoutElevation(),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: RegistrationController(),
          didChangeDependencies: (state) {
            state.controller?.getRegistrationFee();
          },
          builder:
              (controller) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    TextStyleInterWithPadding(
                      text: Strings.idProof,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 16.0,
                    ),
                    SizedBox(height: 5),
                    TextStyleInterWithPadding(
                      text: Strings.documentFormats,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 12.0,
                    ),
                    SizedBox(height: 10),
                    UploadRecordWidget(
                      onTap: () {
                        controller.showImageOptions(
                          context,
                          isIdProof: true,
                          imagesList: controller.idProofImages,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    controller.idProofImages.isNotEmpty
                        ? UploadedFilesListView(
                          onRemove: (index) {
                            controller.idProofImages.removeAt(index);
                            controller.update();
                          },
                          uploadedFiles: controller.idProofImages,
                        )
                        : SizedBox.shrink(),
                    SizedBox(height: 15),
                    SizedBox(height: 10),
                    TextStyleInterWithPadding(
                      text: Strings.certificates,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 16.0,
                    ),
                    SizedBox(height: 5),
                    TextStyleInterWithPadding(
                      text: Strings.documentFormats,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 12.0,
                    ),
                    SizedBox(height: 10),
                    UploadRecordWidget(
                      onTap: () {
                        controller.showImageOptions(
                          context,
                          isCertificates: true,
                          imagesList: controller.certificatesImages,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    controller.certificatesImages.isNotEmpty
                        ? UploadedFilesListView(
                          onRemove: (index) {
                            controller.certificatesImages.removeAt(index);
                            controller.update();
                          },
                          uploadedFiles: controller.certificatesImages,
                        )
                        : SizedBox.shrink(),
                    SizedBox(height: 15),
                    TextStyleInterWithPadding(
                      text: Strings.employeeType,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 16.0,
                    ),
                    SizedBox(height: 10),
                    CustomRadioTile(
                      label: Strings.salariedEmployee,
                      value: Strings.salariedEmployee,
                      groupValue: controller.selectedType,
                      onChanged: (value) {
                        controller.selectedType = value;
                        controller.update();
                      },
                    ),
                    SizedBox(height: 15),
                     CustomRadioTile(
                      label: Strings.perDayCharge,
                      value: Strings.perDayCharge,
                      groupValue: controller.selectedType,
                      onChanged: (value) {
                        controller.selectedType = value;
                        debugPrint("selectedType: ${controller.selectedType}");
                        controller.update();
                      },
                    ),
                    SizedBox(height: 20),
                    TextStyleInterWithPadding(
                      text: "Expected Salary",
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      size: 16.0,
                    ),
                    SizedBox(height: 10),
                    TextInputWidget(
                      controller: controller.expectedSalaryController,
                      label: "Enter Expected Salary*",
                      type: TextInputType.number,
                      height: 50,
                      validatorText: "Expected salary is required",
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextStyleInterWithPadding(
                          text: Strings.registrationFeeForFirstTimeUsers,
                          color: greyTextColour,
                          fontWeight: FontWeight.w600,
                          size: 13.0,
                        ),
                        TextStyleInterWithPadding(
                          text:
                              controller.registrationFee > 0
                                  ? "₹${controller.registrationFee.toStringAsFixed(0)}"
                                  : "₹0",
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          size: 13.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AgreeWithTermsWidget(
                      onTermsAndConditionsTap: () {
                        Get.to(() => TermsAndConditions());
                      },
                      onPrivacyPolicyTap: () {
                        Get.to(() => PrivacyPolicy());
                      },
                      onCheckedChanged: (isChecked) {
                        setState(() {
                          _isTermsChecked = isChecked;
                          if (isChecked) {
                            _showTermsError = false;
                          }
                        });
                      },
                      showError: _showTermsError,
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: SubmitButtonWidget(
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            return;
                          }

                          if (controller.expectedSalaryController.text.trim().isEmpty) {
                            showToast("Expected salary is required", isError: true);
                            return;
                          }

                          // Validate privacy policy checkbox
                          if (!_isTermsChecked) {
                            setState(() {
                              _showTermsError = true;
                            });
                            return;
                          }
                          final registrationData = RegistrationData(
                            fullname: widget.fullName,
                            countryCode: widget.countryCode,
                            mobile: widget.phoneNumber,
                            email: widget.email,
                            dob: widget.dateOfBirth,
                            gender: widget.gender,
                            qualification: widget.qualification,
                            password: widget.password,
                            passwordConfirmation: widget.confirmPassword,
                            image: widget.image,
                            languages: widget.languages,
                            idProof: controller.idProofImages,
                            certificates: controller.certificatesImages,
                            salaryType: controller.selectedType,
                            salary: controller.expectedSalaryController.text.trim(),
                            otp: widget.otp,
                          );
                          controller.validateRegister(registrationData);
                        },
                        text:
                            controller.registrationFee > 0
                                ? "Pay ₹${controller.registrationFee.toStringAsFixed(0)}"
                                : "Pay ₹0",
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
