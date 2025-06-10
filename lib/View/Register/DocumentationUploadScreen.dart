import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/AgreeWithTermsWidget.dart';
import 'package:waaada_nurseapp/Widget/AppbarWithoutElevation.dart';
import 'package:waaada_nurseapp/Widget/CustomRadioTile.dart';
import 'package:waaada_nurseapp/Widget/MemberDropDownField.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWithBorderColor.dart';
import 'package:waaada_nurseapp/Widget/TextInputWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/UploadRecordWidget.dart';
import 'package:waaada_nurseapp/Widget/UploadedFilesListView.dart';

class DocumentationUploadScreen extends StatefulWidget {
  const DocumentationUploadScreen({super.key});

  @override
  State<DocumentationUploadScreen> createState() =>
      _DocumentationUploadScreenState();
}

class _DocumentationUploadScreenState extends State<DocumentationUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWithoutElevation(),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: RegistrationController(),
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
                    UploadRecordWidget(),
                    SizedBox(height: 20),
                    UploadedFilesListView(),
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
                    UploadRecordWidget(),
                    SizedBox(height: 20),
                    UploadedFilesListView(),
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
                       controller.update();
                      },
                    ),
                    SizedBox(height: 20),
                   Row(
                     mainAxisAlignment:MainAxisAlignment.spaceBetween,
                     children: [
                       TextStyleInterWithPadding(
                         text: Strings.registrationFeeForFirstTimeUsers,
                         color: greyTextColour,
                         fontWeight: FontWeight.w600,
                         size: 13.0,
                       ),
                       TextStyleInterWithPadding(
                         text: "₹999",
                         color: Colors.black,
                         fontWeight: FontWeight.w600,
                         size: 13.0,
                       ),
                     ],
                   ),
                    SizedBox(height: 10),
                    AgreeWithTermsWidget(),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SubmitButtonWidget(onTap: () {}, text: "₹999")),
                    SizedBox(height: 15),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
