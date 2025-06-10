import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

class BankAccountListingCard extends StatelessWidget {
  final String bankName;
  final String accountNumber;
  final String accountHolder;
  final VoidCallback? onDelete;

  const BankAccountListingCard({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FB), // light blue background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextStyleInterWithoutPadding(
                  text: bankName,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 16.00,
                ),
                TextStyleInterWithoutPadding(
                  text: accountNumber,
                  color: greyTextColour,
                  fontWeight: FontWeight.w500,
                  size: 13.00,
                ),
                TextStyleInterWithoutPadding(
                  text: accountHolder,
                  color: greyTextColour,
                  fontWeight: FontWeight.w500,
                  size: 13.00,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              IconButton(
                onPressed: onDelete,
                icon: SvgPicture.asset("lib/Assets/Images/deleteRedIcon.svg")
              ),
            ],
          ),
        ],
      ),
    );
  }
}
