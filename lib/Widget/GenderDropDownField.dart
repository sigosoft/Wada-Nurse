import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class GenderDropdownField extends StatefulWidget {
  const GenderDropdownField({
    super.key,
    required this.name,
    this.validatorText,
    this.onGenderSelected,
  });
  final String name;
  final String? validatorText;
  final Function(String?)? onGenderSelected;

  @override
  State<GenderDropdownField> createState() => _GenderDropdownFieldState();
}

class _GenderDropdownFieldState extends State<GenderDropdownField> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: FormField<String>(
        initialValue: null,
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.validatorText;
          }
          return null;
        },
        builder: (FormFieldState<String> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: _selectedGender != null ? 22 : 10,
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedGender,
                            items:
                                ['Male', 'Female', 'Other']
                                    .map(
                                      (gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(
                                          gender,
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
                              setState(() {
                                _selectedGender = value;
                              });
                              widget.onGenderSelected?.call(value);
                              field.didChange(value);
                            },
                            hint:
                                _selectedGender == null
                                    ? Text(
                                      widget.name,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: blackTextColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                    : null,
                            isExpanded: true,
                            isDense: true,
                            icon: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: greyBg,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black,
                                  size: 18,
                                ),
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
                    if (_selectedGender != null)
                      Positioned(
                        top: 6,
                        left: 10,
                        child: Text(
                          widget.name,
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            color: blackTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
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
