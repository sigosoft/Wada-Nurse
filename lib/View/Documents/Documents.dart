import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';

import 'package:waaada_nurseapp/Resource/Strings.dart';

import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';

import 'package:waaada_nurseapp/Widget/DeclinedDocumetWidget.dart';
import 'package:waaada_nurseapp/Widget/DocumentWidget.dart';

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
      appBar: CustomAppBar(
        label: Strings.documents,
        showBackButton: true,
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: RegistrationController(),
          builder:
              (controller) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    DocumentWidget(
                      onRemove: (index) {},
                      status: "Pending",
                      uploadedFiles: List<XFile>.empty(),
                    ),
                    SizedBox(height: 20),
                    DocumentWidget(
                      onRemove: (index) {},
                      status: "Verified",
                      uploadedFiles: List<XFile>.empty(),
                    ),
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
