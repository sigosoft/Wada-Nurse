import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/UploadRecordWidget.dart';
import 'package:waaada_nurseapp/Widget/UploadedFilesListView.dart';

class DeclinedDocumentWidget extends StatelessWidget {
  final RegistrationController controller;
  const DeclinedDocumentWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: greyBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                text: Strings.declined,
                color: redColorText,
                fontWeight: FontWeight.w700,
                size: 16.0,
              ),
            ],
          ),
          SizedBox(height: 30),
          UploadedFilesListView(
            uploadedFiles: controller.declinedIdProofImages,
            onRemove: (index) {},
          ),
          SizedBox(height: 10),
          TextStyleInterWithPadding(
            text: Strings.reUpload,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            size: 16.0,
          ),
          TextStyleInterWithPadding(
            text: Strings.documentFormats,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            size: 14.0,
          ),
          SizedBox(height: 10),
          UploadRecordWidget(
            onTap: () {
              controller.showImageOptions(
                context,
                isCertificates: true,
                isReupload: true,
              );
            },
          ),
          SizedBox(height: 20),
          UploadedFilesListView(
            uploadedFiles: controller.reuploadCertificates,
            onRemove: (index) {
              controller.reuploadCertificates.removeAt(index);
              controller.update();
            },
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SubmitButtonWidget(
              onTap: () {
                controller.uploadDocuments();
              },
              text: Strings.submit,
            ),
          ),
        ],
      ),
    );
  }
}
