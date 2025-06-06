import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';


class UploadRecordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [15, 5],
          strokeWidth: 1,
          color: colorPrimary,
          radius: Radius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: 130,
          color: Color(0xFFEAF3FA),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/Assets/Images/uploadPlaceHolder.svg',
                fit: BoxFit.scaleDown,
              ),
              SizedBox(height: 10),
              Text(
                Strings.selectFile,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: blackTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}