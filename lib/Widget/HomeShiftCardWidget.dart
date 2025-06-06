import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

import 'TextStyleInterWithoutPadding.dart';

class HomeShiftCardWidget extends StatelessWidget {
  final dynamic date;
  final dynamic type;
  final dynamic color;
  final VoidCallback? onTap;

  const HomeShiftCardWidget({super.key, this.date, this.type,this.color,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:color ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Center the texts vertically
          children: [
            TextStyleInterWithoutPadding(
              textAlign: TextAlign.center,
              text: date,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: 12.00,
            ),
            SizedBox(height: 6),
            TextStyleInterWithoutPadding(
              textAlign: TextAlign.center,
              text: type,
              color: greyTextColour,
              fontWeight: FontWeight.w400,
              size: 12.00,
            ),
          ],
        ),
      ),
    );
  }
}