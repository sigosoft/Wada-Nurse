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
      appBar: CustomAppBar(label: Strings.documents,showBackButton: true),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: RegistrationController(),
          builder:
              (controller) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:greyBorder,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextStyleInterWithPadding(
                                text: Strings.idProof,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                size: 16.0,
                              ),
                              TextStyleInterWithPadding(
                                text: Strings.pending,
                                color: redColorText,
                                fontWeight: FontWeight.w700,
                                size: 16.0,
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          UploadedFilesListView(),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
        ),
      ),
    );
  }
}
