import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Widget/CustomCliprect.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

import '../../Resource/Colors.dart' show blackTextColor2, boxGradient, colorPrimary, grayText, profileText2;

class DoctorDetailsWidget extends StatelessWidget {
  final dynamic premiumMembership;
  final dynamic onTapEdit;

  const DoctorDetailsWidget({
    super.key,this.onTapEdit,
    this.premiumMembership = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      decoration: BoxDecoration(
        color: boxGradient,
        borderRadius:BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomClipRRect(
                    borderRadius: 60,
                    imagePath:
                    "lib/Assets/Images/profileImageDummy.png",
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyleInterWithPadding(
                        text: "John Jacob",
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        size: 18.00,
                      ),
                      const SizedBox(height: 5),
                      TextStyleInterWithPadding(
                        text: "+91 987654321",
                        color: grayText,
                        fontWeight: FontWeight.w400,
                        size: 12.00,
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              TextStyleInterWithoutPadding(
                                text: "Salaried Employee",
                                color: grayText,
                                fontWeight: FontWeight.w500,
                                size: 12.00,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.13),
                              InkWell(
                                onTap: onTapEdit,
                                child: TextStyleInterWithoutPadding(
                                  text: "Edit Profile >",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  size: 12.00,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}