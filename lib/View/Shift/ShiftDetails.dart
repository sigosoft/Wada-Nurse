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
  const ShiftDetails({
    super.key,
    this.bookingType = "",
    required this.bookingId,
  });

  final String bookingType;
  final int bookingId;

  @override
  State<ShiftDetails> createState() => _ShiftDetailsState();
}

class _ShiftDetailsState extends State<ShiftDetails> {
  final ShiftDetailsController controller = Get.put(ShiftDetailsController());
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        _isInitialized = true;
        controller.getShiftDetails(widget.bookingId);
      }
    });
  }

  int calculateAge(String dobString) {
    if (dobString.isEmpty) return 0;
    try {
      DateTime dob = DateTime.parse(dobString);
      DateTime today = DateTime.now();
      int age = today.year - dob.year;
      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
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
      List<String> months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
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
    return GetBuilder<ShiftDetailsController>(
      init: controller,
      builder: (controller) {
        final booking = controller.booking;
        final patientName =
            booking?['patient']?['name'] ??
            booking?['user']?['name'] ??
            "Patient";
        final dob =
            booking?['patient']?['dob'] ?? booking?['user']?['dob'] ?? "";
        final age = calculateAge(dob);
        final genderNum =
            booking?['patient']?['gender'] ?? booking?['user']?['gender'];
        final gender = genderNum == 1 ? "M" : (genderNum == 2 ? "F" : "O");

        final checkinDate = formatDate(booking?['from_date'] ?? "");
        final checkinTime = formatTime(booking?['checkin_time'] ?? "");
        final checkoutDate = formatDate(booking?['to_date'] ?? "");
        final checkoutTime = formatTime(booking?['checkout_time'] ?? "");

        int totalDaysVal = 0;
        if (booking?['from_date'] != null && booking?['to_date'] != null) {
          try {
            DateTime from = DateTime.parse(booking!['from_date']);
            DateTime to = DateTime.parse(booking['to_date']);
            totalDaysVal = to.difference(from).inDays + 1;
          } catch (_) {}
        }
        final totalDays =
            booking?['total_days']?.toString() ??
            (totalDaysVal > 0 ? totalDaysVal.toString() : "0");

        final rawShiftType = booking?['shift_type'];
        String shiftType = "4 Hours";
        if (rawShiftType != null) {
          final valStr = rawShiftType.toString();
          if (RegExp(r'^\d+$').hasMatch(valStr)) {
            shiftType = "$valStr Hours";
          } else {
            shiftType = valStr;
          }
        }

        List<String> servicesList = [];
        if (booking != null) {
          final categoryName = booking['category_name'];
          if (categoryName != null &&
              categoryName.toString().trim().isNotEmpty) {
            final categoryNameStr = categoryName.toString();
            if (categoryNameStr.contains(',')) {
              servicesList.addAll(
                categoryNameStr
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty),
              );
            } else {
              servicesList.add(categoryNameStr.trim());
            }
          }

          if (servicesList.isEmpty) {
            String? getServiceName(dynamic item) {
              if (item == null) return null;
              if (item is String) return item;
              if (item is Map) {
                return item['category_name']?.toString() ??
                    item['category']?['name']?.toString() ??
                    item['name']?.toString() ??
                    item['service_name']?.toString() ??
                    item['service']?['name']?.toString();
              }
              return null;
            }

            final bookingServices =
                booking['booking_services'] ??
                booking['bookingServices'] ??
                booking['services'];
            if (bookingServices is List) {
              for (var item in bookingServices) {
                final name = getServiceName(item);
                if (name != null && name.isNotEmpty) {
                  servicesList.add(name);
                }
              }
            }

            if (servicesList.isEmpty) {
              final singleService = booking['service'];
              if (singleService is List) {
                for (var item in singleService) {
                  final name = getServiceName(item);
                  if (name != null && name.isNotEmpty) {
                    servicesList.add(name);
                  }
                }
              } else {
                final name = getServiceName(singleService);
                if (name != null && name.isNotEmpty) {
                  servicesList.add(name);
                }
              }
            }
          }
        }

        if (servicesList.isEmpty) {
          servicesList.add("Wound Care and Dressing");
        }
        servicesList = servicesList.toSet().toList();
        final notes =
            booking?['notes'] ??
            booking?['note'] ??
            booking?['remarks'] ??
            Strings.dummy;

        final rawFee =
            booking?['total'] ??
            booking?['amount'] ??
            booking?['fee'] ??
            booking?['price'];
        String nurseFee = "₹512";
        if (rawFee != null) {
          final valStr = rawFee.toString();
          if (valStr.startsWith('₹')) {
            nurseFee = valStr;
          } else {
            nurseFee = "₹$valStr";
          }
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar:
              widget.bookingType == "ongoing"
                  ? AppBar(
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
                          itemBuilder:
                              (context) => [
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
                  )
                  : CustomAppBar(
                    label:
                        widget.bookingType == "completed"
                            ? Strings.completed
                            : widget.bookingType == "cancelled"
                            ? Strings.cancelled
                            : Strings.shiftdetails,
                    showCloseIcon: false,
                    onTap: Get.back,
                  ),
          body: SafeArea(
            child:
                controller.isLoading
                    ? Center(
                      child: CircularProgressIndicator(color: colorPrimary),
                    )
                    : controller.booking == null
                    ? const Center(child: Text("No booking details found"))
                    : Column(
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
                                      patientName,
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
                                            "Age: $age | Gender: $gender",
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
                                                  (booking?['booking_status']?.toString() == "1" || booking?['bookingStatus']?.toString() == "1")
                                                      ? "Waiting for payment"
                                                      : "Waiting for location share",
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
                                    SizedBox(
                                      height:
                                          widget.bookingType == "ongoing" ||
                                                  widget.bookingType ==
                                                      "completed"
                                              ? 15
                                              : 0,
                                    ),
                                    widget.bookingType == "ongoing" ||
                                            widget.bookingType == "completed"
                                        ? InkWell(
                                          onTap: () {
                                            Get.to(ShiftDetailsListing());
                                          },
                                          child: SubmitButtonWidget(
                                            text: Strings.shiftdetails,
                                          ),
                                        )
                                        : Container(),
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
                                            text1: checkinDate,
                                            text2: Strings.checkindate,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: ShiftDetailsWidget(
                                            text1: checkinTime,
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
                                            text1: checkoutDate,
                                            text2: Strings.checkoutdate,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: ShiftDetailsWidget(
                                            text1: checkoutTime,
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
                                            text1: totalDays,
                                            text2: Strings.totalDays,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: ShiftDetailsWidget(
                                            text1: shiftType,
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
                                    ...servicesList.map((serviceName) {
                                      return CheckboxWdget(
                                        content: serviceName,
                                        size: 13,
                                        color: Colors.black,
                                        isChecked: true,
                                      );
                                    }).toList(),
                                    SizedBox(height: 10),
                                    TextStyleInterWithoutPadding(
                                      text: Strings.notes,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      size: 14.00,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      notes,
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
                                              text: nurseFee,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              size: 14.00,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    widget.bookingType == "completed"
                                        ? Text(
                                          Strings.downloadSalarySlip,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        widget.bookingType == "upcoming" ||
                                widget.bookingType == "ongoing"
                            ? Container(
                              padding: EdgeInsets.only(
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (widget.bookingType == "ongoing") {
                                    controller.openCameraBottomSheet(
                                      context,
                                      "checkout",
                                    );
                                  } else {
                                    controller.showCantCheckinBottomSheet(
                                      context,
                                    );
                                  }
                                },
                                child: SubmitButtonWidget(
                                  text:
                                      widget.bookingType == "ongoing"
                                          ? Strings.checkout
                                          : Strings.checkin,
                                ),
                              ),
                            )
                            : widget.bookingType == "requests"
                            ? Container(
                              padding: EdgeInsets.only(
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              child: (booking?['booking_status']?.toString() == "1" || booking?['bookingStatus']?.toString() == "1")
                                  ? Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Waiting for payment",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 45,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                controller.showInfoBottomSheet(
                                                  context,
                                                  widget.bookingId,
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFFFC3C4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                    10,
                                                  ),
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
                                                controller.showAcceptBottomSheet(
                                                  context,
                                                  widget.bookingId,
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFF039300),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                    10,
                                                  ),
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
                            )
                            : Container(),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
