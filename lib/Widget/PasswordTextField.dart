import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';

import '../Resource/Colors.dart';

class PasswordTextField extends StatelessWidget {
  final dynamic passwordController;
  final dynamic suffixIcon;
  final dynamic isObscured;
  final dynamic label;

  const PasswordTextField({
    super.key,
    required this.passwordController,
    this.suffixIcon,
    this.isObscured,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: greyBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: passwordController,
                  maxLines: 1,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    labelText: label?? Strings.password,
                    labelStyle: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      color: blackTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                    ),
                    suffixIcon: suffixIcon,
                    filled: true,
                    fillColor: greyBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                  obscureText: isObscured ? true : false,
                  obscuringCharacter: '*',
                  onChanged: (value) {
                    if (value.length > 10) {
                      passwordController.text = value.substring(0, 10);
                      passwordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: passwordController.text.length),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
