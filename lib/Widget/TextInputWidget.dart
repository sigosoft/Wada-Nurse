import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class TextInputWidget extends StatelessWidget {
  final String label;
  final TextInputType type;
  final double height;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? validatorText;

  const TextInputWidget({
    super.key,
    required this.label,
    required this.type,
    required this.height,
    this.onTap,
    this.controller,
    this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: FormField<String>(
        initialValue: controller?.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorText;
          }
          return null;
        },
        builder: (FormFieldState<String> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height,
                width: double.infinity,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
                      controller: controller,
                      onTap: onTap,
                      keyboardType: type,
                      maxLines: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(30),
                      ],
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        labelText: label,
                        labelStyle: GoogleFonts.inter(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          color: blackTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF3F3F3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                      ),
                      onChanged: (value) {
                        field.didChange(value);
                      },
                    ),
                  ),
                ),
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: Text(
                    field.errorText ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
