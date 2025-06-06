import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';


class LanguageDropDownWidget extends StatefulWidget {
  const LanguageDropDownWidget({super.key, required this.name,required this.onChanged,required this.selectedGender});
  final String name;
  final dynamic onChanged;
  final dynamic selectedGender;

  @override
  State<LanguageDropDownWidget> createState() => _LanguageDropDownWidgetState();
}

class _LanguageDropDownWidgetState extends State<LanguageDropDownWidget> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: DropdownButtonFormField<String>(
        value:widget.selectedGender,
        items: ['English', 'Malayalam', 'Hindi', 'Tamil', 'Telugu']
            .map((gender) => DropdownMenuItem(
          value: gender,
          child: Text(
            gender,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ))
            .toList(),
        onChanged:widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.name,
          labelStyle: GoogleFonts.inter(
            fontSize: 12,
            color: blackTextColor,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),

          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          suffixIcon: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD9D9D9),
            ),
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        style: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        isDense: true,
        icon: null,
        iconSize: 0,// Hides the default dropdown arrow
      ),
    );
  }
}