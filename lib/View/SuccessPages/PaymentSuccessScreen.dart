import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/View/Login/Login.dart';

import 'package:waaada_nurseapp/View/Home/Home.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final double amount;
  final String paymentId;
  final String email;
  final String contact;
  final bool isAfterLogin;

  const PaymentSuccessScreen({
    super.key,
    required this.amount,
    required this.paymentId,
    required this.email,
    required this.contact,
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
                        SvgPicture.asset(
                          "lib/Assets/Images/request_success.svg",
                          width: 140,
                          height: 140,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Payment Successful!",
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Your registration payment has been successfully processed.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: greyTextColour,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: boxBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: greyBorder),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(
                                "Paid For",
                                "Nurse Registration Fee",
                              ),
                              const Divider(color: greyBorder, height: 24),
                              _buildDetailRow(
                                "Amount",
                                "₹${amount.toStringAsFixed(2)}",
                              ),
                              const Divider(color: greyBorder, height: 24),
                              _buildDetailRow("Payment ID", paymentId),
                              if (email.isNotEmpty) ...[
                                const Divider(color: greyBorder, height: 24),
                                _buildDetailRow("Email", email),
                              ],
                              if (contact.isNotEmpty) ...[
                                const Divider(color: greyBorder, height: 24),
                                _buildDetailRow("Contact", contact),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Note: Our team will verify your uploaded documents and activate your account shortly.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: SubmitButtonWidget(
                onTap: () {
                  if (isAfterLogin) {
                    Get.offAll(() => Home());
                  } else {
                    Get.offAll(() => const LoginScreen());
                  }
                },
                text: isAfterLogin ? "Go to Home" : "Go to Login",
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: greyTextColour,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
