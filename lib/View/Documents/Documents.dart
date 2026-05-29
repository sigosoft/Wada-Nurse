import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';

import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

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
      body: GetBuilder<RegistrationController>(
        init: RegistrationController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.controller?.getDocuments();
          });
        },
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  DocumentWidget(
                    onRemove: (index) {},
                    status: "Pending",
                    uploadedFiles: controller.idProofImages,
                  ),
                  SizedBox(height: 20),
                  DocumentWidget(
                    onRemove: (index) {},
                    status: "Verified",
                    uploadedFiles: controller.certificatesImages,
                  ),
                  SizedBox(height: 20),
                  DeclinedDocumentWidget(controller: controller),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
