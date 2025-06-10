import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

import '../../Controller/ShiftDetailsController.dart';
import '../../Resource/Strings.dart';
import '../../Widget/CheckboxWdget.dart';
import '../../Widget/SiftDetailsWidget.dart';
import 'ShiftDetailsListing.dart';

class ShiftDetails extends StatefulWidget {
  const ShiftDetails({super.key, this.bookingType = ""});

  final String bookingType;

  @override
  State<ShiftDetails> createState() => _ShiftDetailsState();
}

class _ShiftDetailsState extends State<ShiftDetails> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShiftDetailsController>(
        init: ShiftDetailsController(),
        builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: widget.bookingType=="ongoing"?AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black.withOpacity(0.3),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                "lib/Assets/Images/BackButton.svg",
                fit: BoxFit.scaleDown,
                color: Colors.black,
              ),
            ),
            title: TextStyleInterWithoutPadding(
              text: Strings.ongoing,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              size: 20.00,
            ),
            titleSpacing: -10.0, // Adjust this value to reduce the gap
            toolbarHeight: 50,
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: PopupMenuButton<int>(
                  color: Colors.white,
                  icon: Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      "lib/Assets/Images/settings.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  onSelected: (value) {
                    if (value == 1) {
                      controller.addReasonForLeaveBottomSheet(context);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      height: 30,
                      child: Text(
                        Strings.takeLeave,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            elevation: 3,
            scrolledUnderElevation: 3.0,
          ):
          CustomAppBar(label: widget.bookingType=="completed"?Strings.completed:widget.bookingType=="cancelled"?Strings.cancelled:Strings.shiftdetails, showCloseIcon: false,onTap: Get.back ,),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Age: 75 | Gender: M",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              widget.bookingType == "requests"
                                  ? Expanded(
                                    child: Text(
                                      "Waiting for location share",
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  )
                                  : Container(),
                            ],
                          ),
                          SizedBox(height: widget.bookingType=="ongoing"||widget.bookingType=="completed"?15:0),
                          widget.bookingType=="ongoing"||widget.bookingType=="completed"?
                          InkWell(
                              onTap: (){
                                Get.to(ShiftDetailsListing());
                              },
                              child: SubmitButtonWidget(text: Strings.shiftdetails,)):Container(),
                          SizedBox(height: 15),
                          Text(
                            Strings.requestdetails,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ShiftDetailsWidget(
                                  text1: "08 Feb 2025",
                                  text2: Strings.checkindate,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ShiftDetailsWidget(
                                  text1: "09:30 AM",
                                  text2: Strings.checkintime,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ShiftDetailsWidget(
                                  text1: "08 Feb 2025",
                                  text2: Strings.checkoutdate,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ShiftDetailsWidget(
                                  text1: "05:00 PM",
                                  text2: Strings.checkouttime,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ShiftDetailsWidget(
                                  text1: "10",
                                  text2: Strings.totalDays,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ShiftDetailsWidget(
                                  text1: "4 Hours",
                                  text2: Strings.shiftType,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          TextStyleInterWithoutPadding(
                            text: Strings.serviceRequirement,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            size: 15.00,
                          ),
                          SizedBox(height: 5),
                          CheckboxWdget(
                            content: "Wound Care and Dressing",
                            size: 13,
                            color: Colors.black,
                            isChecked: true,
                          ),
                          SizedBox(height: 10),
                          TextStyleInterWithoutPadding(
                            text: Strings.notes,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            size: 14.00,
                          ),
                          SizedBox(height: 10),
                          Text(
                            Strings.dummy,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: greyishBlack,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextStyleInterWithoutPadding(
                                  text: Strings.nurseFee,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  size: 14.00,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: TextStyleInterWithoutPadding(
                                    text: "₹512",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    size: 14.00,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          widget.bookingType=="completed"?
                          Text(Strings.downloadSalarySlip,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ):Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
               widget.bookingType == "upcoming"||widget.bookingType=="ongoing"
                  ? Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        if(widget.bookingType=="ongoing"){
                          controller.openCameraBottomSheet(context, "checkout");
                        }else {
                          controller.showCantCheckinBottomSheet(context);
                        }

                      },
                        child: SubmitButtonWidget(text: widget.bookingType=="ongoing"?Strings.checkout:Strings.checkin)),
                  ):widget.bookingType == "requests"?
              Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.showInfoBottomSheet(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFC3C4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                Strings.reject,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.showAcceptBottomSheet(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF039300),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                Strings.accept,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):Container(),
            ],
          ),
        );
      }
    );
  }
}
