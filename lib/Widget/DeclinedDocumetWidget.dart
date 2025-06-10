import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/UploadRecordWidget.dart';
import 'package:waaada_nurseapp/Widget/UploadedFilesListView.dart';

class DeclinedDocumentWidget extends StatelessWidget {
  const DeclinedDocumentWidget({
    super.key,
  });

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
          UploadedFilesListView(),
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
          UploadRecordWidget(),
          SizedBox(height: 20),
          UploadedFilesListView(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SubmitButtonWidget(
              text: Strings.submit,
            ),
          )
        ],
      ),
    );
  }
}