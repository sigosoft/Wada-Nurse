import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/SettingsController.dart';
import '../../Resource/Strings.dart';
import '../../Resource/colors.dart';
import '../../Widget/CustomAppBar.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        label: Strings.termsAndConditions,
        onTap: Get.back,
        showCloseIcon: false,
      ),
      body: GetBuilder<SettingsController>(
        init: SettingsController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.controller?.fetchTerms();
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
                controller.termsContent,
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
