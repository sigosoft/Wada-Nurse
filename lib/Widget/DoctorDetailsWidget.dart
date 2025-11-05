import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Widget/CustomCliprect.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

import '../../Resource/Colors.dart' show blackTextColor2, boxGradient, colorPrimary, grayText, profileText2;

class DoctorDetailsWidget extends StatelessWidget {
  final dynamic premiumMembership;
  final dynamic onTapEdit;
  final dynamic name;
  final dynamic mobile;
  final dynamic salaried_or_not;
  final dynamic image;

  const DoctorDetailsWidget({
    super.key,this.onTapEdit,
    this.premiumMembership = false,
    this.name,
    this.mobile,
    this.salaried_or_not,
    this.image
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: CustomClipRRect(
                borderRadius: 60,
                imagePath:
                image,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleInterWithPadding(
                    text: name.toString(),
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    size: 18.00,
                  ),
                  const SizedBox(height: 5),
                  TextStyleInterWithPadding(
                    text: mobile.toString(),
                    color: grayText,
                    fontWeight: FontWeight.w400,
                    size: 12.00,
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextStyleInterWithoutPadding(
                            text: "Salaried Employee",
                            color: grayText,
                            fontWeight: FontWeight.w500,
                            size: 12.00,
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: onTapEdit,
                            child: TextStyleInterWithoutPadding(
                              text: "Edit Profile >",
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              size: 12.00,
                            ),
                          ),
                        ),
                      ],
                    ),
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