import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';

import '../Resource/Colors.dart';


class CountryCodeAndPhoneNUmber extends StatelessWidget {
  const CountryCodeAndPhoneNUmber({super.key,required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.30,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TextStyleInterForSplash(
                      //   text: Strings.countryCode,
                      //   color: blackTextColor,
                      //   fontWeight: FontWeight.w400,
                      //   size: 9,
                      // ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          icon: SizedBox.shrink(),
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: Strings.countryCode,
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          ),
                          items: ['+91', '+1', '+44', '+61'].map((code) {
                            return DropdownMenuItem<String>(
                              value: code,
                              child: Text(
                                code,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TextStyleInterForSplash(
                        //   text: Strings.phoneNumber,
                        //   color: blackTextColor,
                        //   fontWeight: FontWeight.w400,
                        //   size: 9,
                        // ),
                        Expanded(
                          child: TextFormField(
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
                              labelText: name,
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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            ),
                            onChanged: (value) {
                              if (value.length > 10) {
                                value = value.substring(0, 10);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}