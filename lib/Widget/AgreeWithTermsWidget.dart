import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';


class AgreeWithTermsWidget extends StatefulWidget {
  const AgreeWithTermsWidget({super.key});

  @override
  State<AgreeWithTermsWidget> createState() => _AgreeWithTermsWidgetState();
}

class _AgreeWithTermsWidgetState extends State<AgreeWithTermsWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Rounded corners
          ),
          activeColor: colorPrimary, // Primary color for the checkbox
        ),
        const SizedBox(width: 0),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: Strings.agreeWith,
              style: GoogleFonts.inter(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 12,
                color: greyTextColour,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              children: [
                TextSpan(
                  text: Strings.termsAndConditions,
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Terms & Conditions click
                    },
                ),
                TextSpan(
                  text: Strings.and,
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 12,
                    color: greyTextColour,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text: Strings.privacyPolicy,
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Privacy Policy click
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}