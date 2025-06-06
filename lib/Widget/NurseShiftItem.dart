import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/View/Shift/ShiftDetails.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';

import '../../Resource/Strings.dart';
import '../../Widget/HomeShiftCardWidget.dart';

class NurseShiftItem extends StatelessWidget {
  final bool showLocationText;
  final String bookingType;

  const NurseShiftItem({
    super.key,
    this.showLocationText = false,
    this.bookingType = ""
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Get.to(ShiftDetails(bookingType: bookingType));
      },
      child: Container(
        height: showLocationText?240:bookingType=="upcoming"?270:220,
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: boxBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  "David Thomas",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Age: 75 | Gender: M",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'lib/Assets/Images/locations.svg',
                          width: 13,
                          height: 13,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Raipur, Chhattisgarh",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: "08 Feb 2025",
                      type: Strings.checkindate,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: "09:00 AM",
                      type: Strings.checkintime,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: "08 Feb 2025",
                      type: Strings.checkoutdate,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: "09:00 AM",
                      type: Strings.checkouttime,
                    ),
                  ),
                ],
              ),
              showLocationText||bookingType=="upcoming"?
              SizedBox(height: 8):SizedBox(),
              showLocationText?
              Text(
                "Waiting for location share",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ):SizedBox(),
              bookingType=="upcoming"?
                  SubmitButtonWidget(text: Strings.checkin,):Container()
            ],
          ),
        ),
      ),
    );
  }
}
