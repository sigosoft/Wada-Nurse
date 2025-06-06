import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

import '../../Resource/Strings.dart';
import '../../Widget/CheckboxWdget.dart';
import '../../Widget/ShiftDetailsWidget.dart';
import '../SuccessPages/ShiftAcceptedSuccessfully.dart';
import 'CameraScreen.dart';
import 'ShiftDetailsListing.dart';

class ShiftDetails extends StatefulWidget {
  const ShiftDetails({super.key, this.bookingType = ""});

  final String bookingType;

  @override
  State<ShiftDetails> createState() => _ShiftDetailsState();
}

class _ShiftDetailsState extends State<ShiftDetails> {
  void _showInfoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              SvgPicture.asset(
                "lib/Assets/Images/info.svg",
                // Replace with your SVG path
                width: 40,
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                Strings.pending,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.documentsPending,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    Strings.ok,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showAcceptBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              SvgPicture.asset(
                "lib/Assets/Images/question.svg",
                // Replace with your SVG path
                width: 40,
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                Strings.confirm,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.acceptMsg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE7F4FD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.no,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorPrimaryDark,
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
                          Get.to(ShiftAcceptedSuccessfully(title: Strings.accepted,message: Strings.acceptedmsg,));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          Strings.yes,
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
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showCantCheckinBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              SvgPicture.asset(
                "lib/Assets/Images/checkin_info.svg",
                // Replace with your SVG path
                width: 40,
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                Strings.cant_checkin,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.cant_checkin_msg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    openCameraBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    Strings.ok,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void openCameraBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              SvgPicture.asset(
                "lib/Assets/Images/camera.svg",
                width: 40,
                height: 40,
              ),
              SizedBox(height: 5),
              Text(
                Strings.openCamera,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                Strings.openCamera_msg,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Fetch available cameras
                    final cameras = await availableCameras();
                    final frontCamera = cameras.firstWhere(
                          (camera) => camera.lensDirection == CameraLensDirection.front,
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CameraScreen(),
                    //   ),
                    // );
                   Get.to(CameraScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    Strings.ok,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
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
      CustomAppBar(label: widget.bookingType=="completed"?Strings.completed:widget.bookingType=="cancelled"?Strings.cancelled:Strings.shiftdetails, showCloseIcon: false),
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
                    _showCantCheckinBottomSheet(context);

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
                            _showInfoBottomSheet(context);
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
                            _showAcceptBottomSheet(context);
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
}
