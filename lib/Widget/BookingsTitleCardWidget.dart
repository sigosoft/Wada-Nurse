import 'package:flutter/material.dart';

import 'TextStyleInterWithoutPadding.dart';

class BookingsTitleCardWidget extends StatelessWidget {
  final dynamic color;
  final dynamic text;
  final dynamic textColor;
  final VoidCallback? onTap;

  const BookingsTitleCardWidget({
    super.key,this.color,this.text,this.textColor,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: TextStyleInterWithoutPadding(
          textAlign: TextAlign.center,
          text: text,
          color: textColor,
          fontWeight: FontWeight.w600,
          size: 14.00,
        ),
      ),
    );
  }
}