import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberDropdownField extends StatefulWidget {
  const MemberDropdownField({super.key});

  @override
  State<MemberDropdownField> createState() => _MemberDropdownFieldState();
}

class _MemberDropdownFieldState extends State<MemberDropdownField> {
  String? selectedMember = "Merlin Joy";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: DropdownButtonFormField<String>(
        value: selectedMember,
        items: ['Merlin Joy', 'Joy', 'Cristina']
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
        onChanged: (value) {
          setState(() {
            selectedMember = value;
          });
        },

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
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