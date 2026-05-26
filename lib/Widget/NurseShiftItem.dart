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
  final dynamic request;

  const NurseShiftItem({
    super.key,
    this.showLocationText = false,
    this.bookingType = "",
    this.request,
  });

  int calculateAge(String dobString) {
    if (dobString.isEmpty) return 0;
    try {
      DateTime dob = DateTime.parse(dobString);
      DateTime today = DateTime.now();
      int age = today.year - dob.year;
      if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

  String formatDate(String dateString) {
    if (dateString.isEmpty) return "";
    try {
      DateTime date = DateTime.parse(dateString);
      List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      return "${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}";
    } catch (e) {
      return dateString;
    }
  }

  String formatTime(String timeString) {
    if (timeString.isEmpty) return "";
    try {
      List<String> parts = timeString.split(':');
      if (parts.length >= 2) {
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
        String period = hour >= 12 ? "PM" : "AM";
        int displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return "${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period";
      }
      return timeString;
    } catch (e) {
      return timeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientName = request?['patient']?['name'] ?? request?['user']?['name'] ?? "Patient";
    final dob = request?['patient']?['dob'] ?? request?['user']?['dob'] ?? "";
    final age = calculateAge(dob);
    final genderNum = request?['patient']?['gender'] ?? request?['user']?['gender'];
    final gender = genderNum == 1 ? "M" : (genderNum == 2 ? "F" : "O");
    final location = request?['location'] ?? "Raipur, Chhattisgarh"; // Fallback to रायपुर if null
    final checkinDate = formatDate(request?['from_date'] ?? "");
    final checkinTime = formatTime(request?['checkin_time'] ?? "");
    final checkoutDate = formatDate(request?['to_date'] ?? "");
    final checkoutTime = formatTime(request?['checkout_time'] ?? "");

    return InkWell(
      onTap: () {
        Get.to(ShiftDetails(bookingType: bookingType, bookingId: request?['id'] ?? 0));
      },
      child: Container(
        height: showLocationText?MediaQuery.of(context).size.height * 0.3:bookingType=="upcoming"||bookingType=="ongoing"?MediaQuery.of(context).size.height * 0.35:MediaQuery.of(context).size.height * 0.28,
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
                      patientName,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Age: $age | Gender: $gender",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'lib/Assets/Images/locations.svg',
                          width: 13,
                          height: 13,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          location,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: checkinDate,
                      type: Strings.checkindate,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: checkinTime,
                      type: Strings.checkintime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: checkoutDate,
                      type: Strings.checkoutdate,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: HomeShiftCardWidget(
                      date: checkoutTime,
                      type: Strings.checkouttime,
                    ),
                  ),
                ],
              ),
              showLocationText||bookingType=="upcoming"||bookingType=="ongoing"?
              const SizedBox(height: 8):const SizedBox(),
              showLocationText?
              Text(
                "Waiting for location share",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ):const SizedBox(),
              bookingType=="upcoming"||bookingType=="ongoing"?
              SubmitButtonWidget(text: bookingType=="upcoming"?Strings.checkin:Strings.checkout,):Container()
            ],
          ),
        ),
      ),
    );
  }
}
