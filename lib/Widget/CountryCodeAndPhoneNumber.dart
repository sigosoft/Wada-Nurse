import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Model/CountryCodeModel.dart';

import '../Resource/Colors.dart';

class CountryCodeAndPhoneNUmber extends StatefulWidget {
  const CountryCodeAndPhoneNUmber({
    super.key,
    required this.name,
    required this.countrycodes,
    required this.controller,
    required this.validatorText,
    this.countryCodeValidatorText,
    this.onCountryCodeSelected,
    this.initialCountryCodeId,
  });
  final String name;
  final List<CountryCode> countrycodes;
  final TextEditingController controller;
  final String validatorText;
  final String? countryCodeValidatorText;
  final Function(int?)? onCountryCodeSelected;
  final int? initialCountryCodeId;

  @override
  State<CountryCodeAndPhoneNUmber> createState() =>
      _CountryCodeAndPhoneNUmberState();
}

class _CountryCodeAndPhoneNUmberState extends State<CountryCodeAndPhoneNUmber> {
  CountryCode? _selectedCountryCode;

  @override
  void initState() {
    super.initState();
    _initSelectedCountryCode();
  }

  @override
  void didUpdateWidget(covariant CountryCodeAndPhoneNUmber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCountryCodeId != oldWidget.initialCountryCodeId ||
        widget.countrycodes != oldWidget.countrycodes) {
      _initSelectedCountryCode();
    }
  }

  void _initSelectedCountryCode() {
    if (widget.initialCountryCodeId != null && widget.countrycodes.isNotEmpty) {
      try {
        _selectedCountryCode = widget.countrycodes.firstWhere(
          (code) => code.id == widget.initialCountryCodeId,
        );
      } catch (_) {
        _selectedCountryCode = null;
      }
    } else {
      _selectedCountryCode = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FormField<Map<String, String>>(
        key: ValueKey('countryCodeAndPhone_${_selectedCountryCode?.id}'),
        initialValue: {
          'countryCode': _selectedCountryCode?.countryCode ?? '',
          'phoneNumber': widget.controller.text,
        },
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value) {
          final countryCode = value?['countryCode'] ?? '';
          final phoneNumber = value?['phoneNumber'] ?? '';

          final isCountryCodeEmpty = countryCode.isEmpty;
          final isPhoneNumberEmpty = phoneNumber.isEmpty;

          if (isCountryCodeEmpty && isPhoneNumberEmpty) {
            return "Both country code and phone number is required";
          }

          if (isCountryCodeEmpty && widget.countryCodeValidatorText != null) {
            return widget.countryCodeValidatorText;
          }

          if (isPhoneNumberEmpty) {
            return widget.validatorText;
          }

          return null;
        },
        builder: (FormFieldState<Map<String, String>> field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: _selectedCountryCode != null ? 22 : 10,
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<CountryCode>(
                                menuMaxHeight:
                                    MediaQuery.of(context).size.height * 0.3,
                                icon: SizedBox.shrink(),
                                isExpanded: true,
                                value: _selectedCountryCode,
                                hint:
                                    _selectedCountryCode == null
                                        ? Text(
                                          Strings.countryCode,
                                          style: GoogleFonts.inter(
                                            textStyle:
                                                Theme.of(
                                                  context,
                                                ).textTheme.displayLarge,
                                            color: blackTextColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        )
                                        : null,
                                items:
                                    widget.countrycodes.map((code) {
                                      return DropdownMenuItem<CountryCode>(
                                        value: code,
                                        child: Text(
                                          code.countryCode,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCountryCode = value;
                                  });
                                  widget.onCountryCodeSelected?.call(value?.id);
                                  field.didChange({
                                    'countryCode': value?.countryCode ?? '',
                                    'phoneNumber': widget.controller.text,
                                  });
                                },
                              ),
                            ),
                          ),
                          if (_selectedCountryCode != null)
                            Positioned(
                              top: 6,
                              left: 10,
                              child: Text(
                                Strings.countryCode,
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextField(
                            controller: widget.controller,
                            keyboardType: TextInputType.phone,
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              labelText: widget.name,
                              labelStyle: GoogleFonts.inter(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
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
                              if (value.length > 10) {
                                value = value.substring(0, 10);
                              }
                              field.didChange({
                                'countryCode': _selectedCountryCode?.countryCode ?? '',
                                'phoneNumber': value,
                              });
                            },
                          ),
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
