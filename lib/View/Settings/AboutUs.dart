import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/SettingsController.dart';
import '../../Resource/Strings.dart';
import '../../Resource/colors.dart';
import '../../Widget/CustomAppBar.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        label: Strings.aboutUs,
        showCloseIcon: false,
        onTap: Get.back,
      ),
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.controller?.fetchAbout();
          });
        },
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: 20,
              ),
              child: Text(
                controller.aboutContent,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: greyishBlack,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
