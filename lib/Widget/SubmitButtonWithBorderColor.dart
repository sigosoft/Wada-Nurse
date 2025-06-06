import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';


class SubmitButtonWithBorderColor extends StatelessWidget {
  final dynamic text;
  final dynamic onTap;

  const SubmitButtonWithBorderColor({
    super.key,this.text,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorPrimary,
                width: 1.0,
              ),
            ),
            height: 60,
            alignment: Alignment.center,
            child:  TextStyleInterWithoutPadding(
              textAlign: TextAlign.center,
              text: text,
              color: colorPrimary,
              fontWeight: FontWeight.w600,
              size: 17.00,
            ),
          ),
        ),
      ),
    );
  }
}