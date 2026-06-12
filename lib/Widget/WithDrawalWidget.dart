import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

class WithDrawalWidget extends StatelessWidget {
  final String balance;
  final String nextWithdrawalDate;
  final String minWithdrawalAmount;
  final VoidCallback onWithdrawPressed;

  const WithDrawalWidget({
    Key? key,
    required this.balance,
    required this.nextWithdrawalDate,
    required this.minWithdrawalAmount,
    required this.onWithdrawPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [colorPrimary, darkBlueGradient1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextStyleInterWithoutPadding(
            text: '₹$balance',
            color: Colors.white,
            fontWeight: FontWeight.w800,
            size: 25.00,
          ),
          const SizedBox(height: 8),
          TextStyleInterWithoutPadding(
            text: Strings.balance,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 14.00,
          ),
          const SizedBox(height: 16),
          TextStyleInterWithoutPadding(
            text: Strings.youCanWithdrawOncePerMonth,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            size: 14.00,
          ),
          const SizedBox(height: 8),
          if (nextWithdrawalDate.isNotEmpty) ...[
            TextStyleInterWithoutPadding(
              text: '${Strings.nextWithdrawalOn} $nextWithdrawalDate',
              color: Colors.white,
              fontWeight: FontWeight.w400,
              size: 14.00,
            ),
            const SizedBox(height: 8),
          ],
          TextStyleInterWithoutPadding(
            text: '${Strings.minimumWithdrawalAmount} ₹$minWithdrawalAmount',
            color: Colors.white,
            fontWeight: FontWeight.w400,
            size: 14.00,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: colorPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onWithdrawPressed,
              child: TextStyleInterWithoutPadding(
                text: Strings.withDraw,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                size: 16.00,
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
