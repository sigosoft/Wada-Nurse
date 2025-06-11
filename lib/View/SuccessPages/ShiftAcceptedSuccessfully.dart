import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Resource/Strings.dart';
import '../../Widget/NurseShiftItem.dart';
import '../../Widget/SubmitButtonWidget.dart';
import '../Home/Home.dart';


class ShiftAcceptedSuccessfully extends StatefulWidget {
  const ShiftAcceptedSuccessfully({super.key,required this.title, required this.message});
  final String title;
  final String message;

  @override
  State<ShiftAcceptedSuccessfully> createState() => _ShiftAcceptedSuccessfullyState();
}

class _ShiftAcceptedSuccessfullyState extends State<ShiftAcceptedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "lib/Assets/Images/request_success.svg",
                        width: 140,
                        height: 140,
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.title,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.message,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      NurseShiftItem()
                    ],
                  ),
                ),
              ),
        
              SubmitButtonWidget(
                onTap:(){
                  Get.offAll(Home());
                },
                text:Strings.home,
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}