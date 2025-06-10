

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

class BankAccountsWidget extends StatelessWidget {
  const BankAccountsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(color: boxGradient,borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset("lib/Assets/Images/BankIcon.svg"),
            SizedBox(width: 10),
            TextStyleInterWithoutPadding(
              text: Strings.bankAccounts,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              size: 16.00,
            ),
          ],
        ),
      ),
    );
  }
}