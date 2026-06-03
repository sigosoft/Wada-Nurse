import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/View/Login/Login.dart';

import 'package:waaada_nurseapp/Utils/utils.dart';

class PaymentFailedScreen extends StatelessWidget {
  final double amount;
  final String errorMessage;
  final VoidCallback? onRetry;
  final bool isAfterLogin;

  const PaymentFailedScreen({
    super.key,
    required this.amount,
    required this.errorMessage,
    this.onRetry,
    this.isAfterLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            color: redBox,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 70,
                            color: redColorText,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Payment Failed",
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          errorMessage.isNotEmpty
                              ? errorMessage
                              : "Your payment of ₹${amount.toStringAsFixed(2)} could not be processed. Please try again.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: greyTextColour,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "If the amount was debited from your account, it will be refunded within 3-4 working days.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: greyTextColour,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onRetry != null) ...[
                    SubmitButtonWidget(
                      onTap: onRetry!,
                      text: "Try Again",
                    ),
                    const SizedBox(height: 12),
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () async {
                        if (isAfterLogin) {
                          await removename("token");
                        }
                        Get.offAll(() => const LoginScreen());
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: colorPrimary, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Go to Login",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
