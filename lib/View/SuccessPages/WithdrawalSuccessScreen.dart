import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import '../../../Resource/Strings.dart';
import '../Home/Home.dart';

class WithdrawalSuccess extends StatelessWidget {
  const WithdrawalSuccess({super.key});

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: circleAvatarFillColor,
                      child: SvgPicture.asset(
                        "lib/Assets/Images/successIcon.svg",
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                     Strings.withdrawalRequestSend,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        Strings.weHaveReceivedYourRequest,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SubmitButtonWidget(
                onTap:(){
                  Get.offAll(Home());
                },
                text:Strings.home
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}