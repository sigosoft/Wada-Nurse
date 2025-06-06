import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class LanguageChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;
  final bool isSelected;

  const LanguageChip({
    super.key,
    required this.label,
    required this.onDeleted,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      onDeleted: onDeleted,
      labelStyle:GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
      backgroundColor:profilePicColor20 ,
      side: BorderSide(
        color: profilePicColor,
        width: 1,
        style: BorderStyle.solid,
      ),
      deleteIcon: CircleAvatar(
        radius: 15,
        backgroundColor: profilePicColor,
          child: Center(child: Icon(Icons.close, size: 16, color: Colors.white))),
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
