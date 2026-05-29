import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widget/SubmitButtonWidget.dart';
import '../Home/Home.dart';

class NeedAnUpdate extends StatelessWidget {
  const NeedAnUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Center(
              child: SvgPicture.asset(
                "lib/Assets/Images/waadaLogo.svg",
                height: 200,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.08),

            Text(
              Strings.needsAnUpdate,
              style: GoogleFonts.rubik(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                Strings.aNewUpdateIsAvailableForThisAppPleaseDownload,
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: SubmitButtonWidget(
                text: Strings.update, // Use your "Update" key
                onTap: () async {
                  try {
                    final packageInfo = await PackageInfo.fromPlatform();
                    final String packageName = packageInfo.packageName;
                    final Uri url = Platform.isAndroid
                        ? Uri.parse("https://play.google.com/store/apps/details?id=" + packageName)
                        : Uri.parse("https://apps.apple.com/app/id1234567895");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication).then((value) {
                        Get.offAll(Home());
                      });
                    } else {
                      debugPrint('Could not launch $url');
                    }
                  } catch (e) {
                    debugPrint('Error launching update: $e');
                  }
                },
              ),
            ),

            const SizedBox(height: 25),

            Image.asset(
              Platform.isAndroid
                  ? "lib/Assets/Images/google_play.png"
                  : "lib/Assets/Images/appstore.png",
              height: 20,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
