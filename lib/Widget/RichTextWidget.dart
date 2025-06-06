import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resource/Colors.dart' show blackTextColor, colorPrimary;

class RichTextWidget extends StatelessWidget {
  final dynamic onTap;
  final dynamic text1;
  final dynamic text2;

  const RichTextWidget({super.key,this.onTap,this.text1,this.text2});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap:onTap ,
        child: RichText(
          text: TextSpan(
            text: text1,
            style: GoogleFonts.inter(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 14,
              color: blackTextColor,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
            children: [
              TextSpan(
                text: text2,
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 14,
                  color: colorPrimary,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
