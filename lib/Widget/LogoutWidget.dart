import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

import '../Resource/Colors.dart';

class LogoutWidget extends StatelessWidget {
  final dynamic onTap;

  const LogoutWidget({
    super.key,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: boxGradient,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50,
          child: Row(
            children: [
              SvgPicture.asset(
                "lib/Assets/Images/logoutIcon.svg",
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(width: 8.0),
              TextStyleInterWithPadding(
                text:  Strings.logout,
                color: logoutTextColor,
                fontWeight: FontWeight.w400,
                size: 14.00,
              ),
            ],
          ),
        ),
      ),
    );
  }
}