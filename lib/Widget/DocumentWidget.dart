import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/UploadedFilesListView.dart';

import '../Resource/Colors.dart' show greenText, greyBorder, redColorText;

class DocumentWidget extends StatelessWidget {
  final dynamic status;
  final List<XFile> uploadedFiles;
  final Function(int) onRemove;

  const DocumentWidget({
    super.key,required this.status, required this.uploadedFiles, required this.onRemove
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                text:status=="Pending"? Strings.idProof:Strings.certificates,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 16.0,
              ),
              TextStyleInterWithPadding(
                text:status=="Pending"? Strings.pending:Strings.verified,
                color:status=="Pending"? redColorText: greenText,
                fontWeight: FontWeight.w700,
                size: 16.0,
              ),
            ],
          ),
          SizedBox(height: 30),
          UploadedFilesListView(uploadedFiles: uploadedFiles, onRemove: onRemove),
        ],
      ),
    );
  }
}