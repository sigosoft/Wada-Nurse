import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/AgreeWithTermsWidget.dart';
import 'package:waaada_nurseapp/Widget/AppbarWithoutElevation.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/CustomRadioTile.dart';
import 'package:waaada_nurseapp/Widget/DeclinedDocumetWidget.dart';
import 'package:waaada_nurseapp/Widget/DocumentWidget.dart';
import 'package:waaada_nurseapp/Widget/MemberDropDownField.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWithBorderColor.dart';
import 'package:waaada_nurseapp/Widget/TextInputWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/UploadRecordWidget.dart';
import 'package:waaada_nurseapp/Widget/UploadedFilesListView.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.documents, showBackButton: true,onTap: () {
        Get.back();
      },),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: RegistrationController(),
          builder:
              (controller) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    DocumentWidget(status: "Pending"),
                    SizedBox(height: 20),
                    DocumentWidget(status: "Verified"),
                    SizedBox(height: 20),
                    DeclinedDocumentWidget(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}


