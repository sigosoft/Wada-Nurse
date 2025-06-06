import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Resource/Strings.dart';
import '../../Controller/ShiftDetailsController.dart';
import '../../Resource/Colors.dart';


class LeaveShiftSuccessfully extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShiftDetailsController>(
        init: ShiftDetailsController(),
        builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
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
                        Strings.leaveSent,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        Strings.leaveRequestSent,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        Strings.checkoutAndleave,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child:  SvgPicture.asset(
                        "lib/Assets/Images/homebutton.svg",
                        width: 40,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      flex:4,
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                           controller.openCameraBottomSheet(context,"checkout");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimary1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            Strings.checkout,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        );
      }
    );
  }
}