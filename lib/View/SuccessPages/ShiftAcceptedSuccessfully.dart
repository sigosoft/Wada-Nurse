import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

import '../../../Resource/Strings.dart';
import '../../../Resource/Colors.dart';
import '../../../ApiConfigs/ApiConfigs.dart';
import '../../../Utils/utils.dart';
import '../../../Utils/LoggingInterceptor.dart';
import '../../Widget/NurseShiftItem.dart';
import '../../Widget/SubmitButtonWidget.dart';
import '../Home/Home.dart';

class ShiftAcceptedSuccessfully extends StatefulWidget {
  const ShiftAcceptedSuccessfully({
    super.key,
    required this.title,
    required this.message,
    required this.bookingId,
  });
  final String title;
  final String message;
  final int bookingId;

  @override
  State<ShiftAcceptedSuccessfully> createState() =>
      _ShiftAcceptedSuccessfullyState();
}

class _ShiftAcceptedSuccessfullyState extends State<ShiftAcceptedSuccessfully> {
  bool _isLoading = true;
  Map<String, dynamic>? _booking;
  final Dio _dio = Dio()..interceptors.add(LoggingInterceptor());

  @override
  void initState() {
    super.initState();
    _fetchShiftDetails();
  }

  Future<void> _fetchShiftDetails() async {
    try {
      var token = await getSavedObject("token");
      String url =
          "${ApiConfigs.baseUrl}${APIEndpoints.shiftDetails}?booking_id=${widget.bookingId}";
      _dio.options.headers["Authorization"] = "Bearer $token";
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            setState(() {
              _booking = data['booking'];
              _isLoading = false;
            });
            return;
          }
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching shift details: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                      _isLoading
                          ? Center(
                            child: CircularProgressIndicator(
                              color: colorPrimary,
                            ),
                          )
                          : NurseShiftItem(
                            request: _booking,
                            bookingType: "upcoming",
                          ),
                    ],
                  ),
                ),
              ),

              SubmitButtonWidget(
                onTap: () {
                  Get.offAll(Home());
                },
                text: Strings.home,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
