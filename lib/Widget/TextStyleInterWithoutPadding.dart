
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleInterWithoutPadding extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final double size;
  final dynamic textAlign;
  final dynamic height;
  final int? maxLines;

  const TextStyleInterWithoutPadding({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.color,
    required this.size,
    this.textAlign,
    this.height,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal,
        height: height ?? 0.00,
      ),
    );
  }
}
