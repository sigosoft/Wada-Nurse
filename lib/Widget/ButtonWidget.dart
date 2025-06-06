import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

import '../../Resource/Colors.dart' show colorPrimary;

class ButtonWidget extends StatelessWidget {
  final dynamic text;
  final dynamic onTap;

  const ButtonWidget({
    super.key,this.text,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap:onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: TextStyleInterWithPadding(
            text: text,
            color: colorPrimary,
            fontWeight: FontWeight.w600,
            size: 18.00,
          ),
        ),
      ),
    );
  }
}
