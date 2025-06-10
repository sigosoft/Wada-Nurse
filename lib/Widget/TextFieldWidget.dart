import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class AddBankAccountTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool enabled;

  const AddBankAccountTextFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: boxGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:GoogleFonts.inter(
            color: grayText,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          )
        ),
      ),
    );
  }
}
