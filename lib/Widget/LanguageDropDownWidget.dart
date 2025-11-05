import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Model/LanguageModel.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class LanguageDropDownWidget extends StatefulWidget {
  const LanguageDropDownWidget({
    super.key,
    required this.name,
    required this.onChanged,
    required this.selectedLanguage,
    required this.languageList,
    this.validatorText,
  });
  final String name;
  final Function(Language?)? onChanged;
  final Language? selectedLanguage;
  final List<Language> languageList;
  final String? validatorText;

  @override
  State<LanguageDropDownWidget> createState() => _LanguageDropDownWidgetState();
}

class _LanguageDropDownWidgetState extends State<LanguageDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: FormField<Language>(
        initialValue: widget.selectedLanguage,
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value) {
          if (value == null) {
            return widget.validatorText;
          }
          return null;
        },
        builder: (FormFieldState<Language> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Language>(
                        value: widget.selectedLanguage,
                        items:
                            widget.languageList
                                .map(
                                  (language) => DropdownMenuItem<Language>(
                                    value: language,
                                    child: Text(
                                      language.language ?? '',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          // Call the original onChanged callback
                          widget.onChanged?.call(value);
                          // Update FormField state for validation
                          field.didChange(value);
                        },
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.name,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: blackTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        isDense: true,
                        icon: Container(
                          margin: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD9D9D9),
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        dropdownColor: Colors.white,
                      ),
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
