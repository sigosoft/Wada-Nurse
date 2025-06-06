import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

class TransactionTile extends StatelessWidget {
  final String date;
  final String title;
  final String status;
  final String amount;
  final bool isCredited;

  const TransactionTile({
    Key? key,
    required this.date,
    required this.title,
    required this.status,
    required this.amount,
    this.isCredited = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusColor = isCredited ? Colors.green : Colors.red;
    final statusText = isCredited ? 'Credited' : 'Debited';


    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: boxGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleInterWithoutPadding(
                text: date,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                size: 12.00,
              ),
              const SizedBox(height: 8),
              TextStyleInterWithoutPadding(
                text: title,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                size: 16.00,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    isCredited? "lib/Assets/Images/creditIcon.svg":"lib/Assets/Images/debitIcon.svg",
                  ),
                  const SizedBox(width: 4),
                  TextStyleInterWithoutPadding(
                    text: statusText,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    size: 12.00,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextStyleInterWithoutPadding(
                text:  '₹$amount',
                color: statusColor,
                fontWeight: FontWeight.w700,
                size: 18.00,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
