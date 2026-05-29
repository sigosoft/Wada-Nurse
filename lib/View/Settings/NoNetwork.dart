import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Strings.dart';
import '../../Widget/SubmitButtonWidget.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 50),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "lib/Assets/Images/nonetwork.svg",
                    height: 180,
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  Strings.noInternetConnection,
                  style: GoogleFonts.rubik(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  Strings.pleaseCheckYourInternetConnectionAndTryAgain,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),

            Positioned(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: SubmitButtonWidget(
                    text: Strings.tryAgain,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
