// import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../ApiConfigs/ApiConfigs.dart';
import '../Resource/Colors.dart';
import '../Resource/Strings.dart';
import '../Utils/CheckNetworkConnectivity.dart';
import '../Utils/HandleDioExceptions.dart';
import '../Utils/LoggingInterceptor.dart';
import '../Utils/utils.dart' hide showToast;
import '../Utils/ShowToast.dart';
import '../View/Map/ChooseLocation.dart';
import '../View/SuccessPages/LeaveShiftSuccessfully.dart';
import '../View/SuccessPages/ShiftAcceptedSuccessfully.dart';
import '../Widget/ReasonDropDownField.dart';
import '../Widget/TextInputWidget.dart';

class ShiftDetailsController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  bool isLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());
  Map<String, dynamic>? booking;
  List<dynamic> shifts = [];
  List<dynamic> upcomingLeaves = [];
  List<dynamic> leaveHistory = [];

  Future<void> getShiftDetails(int bookingId) async {
    booking = null;
    shifts = [];
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url =
          "${ApiConfigs.baseUrl}${APIEndpoints.bookingDetails}?booking_id=$bookingId";
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            booking = data['booking'] ?? data;
            shifts = data['shifts'] is List ? data['shifts'] : [];
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> updateAcceptStatus(int bookingId, int status) async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.updateAcceptStatus;
      dio.options.headers["Authorization"] = "Bearer $token";

      // Clear any global query parameters to avoid pollution
      dio.options.queryParameters = {};

      final queryParams = {"booking id": bookingId, "status": status};

      debugPrint("=== API REQUEST: updateAcceptStatus ===");
      debugPrint("URL: $url");
      debugPrint("Query Params: $queryParams");
      debugPrint("=======================================");

      final response = await dio.get(url, queryParameters: queryParams);

      debugPrint("=== API RESPONSE: updateAcceptStatus ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("====================================");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          showToast(resData['message'] ?? "Request accepted successfully.");
          return true;
        } else {
          showToast(
            resData['message'] ?? "Failed to accept request",
            isError: true,
          );
          return false;
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
      return false;
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("initialized");
  }

  @override
  void onClose() {
    print("disposed");
    super.onClose();
  }

  Future<void> openCamera(String shiftType) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      _image = photo;
      final int bId = int.tryParse(booking?['id']?.toString() ?? "") ?? 0;
      Get.to(ChooseLocation(shiftType: shiftType, bookingId: bId));
    }
  }

  XFile? get selfieImage => _image;

  Future<bool> checkIn(int bookingId, double latitude, double longitude) async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      String url = ApiConfigs.baseUrl + APIEndpoints.checkIn;
      dio.options.headers["Authorization"] = "Bearer $token";

      // Clear any global query parameters to avoid pollution
      dio.options.queryParameters = {};

      FormData requestBody = FormData.fromMap({
        "booking_id": bookingId,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      });

      if (_image != null) {
        String fileName = _image!.path.split('/').last;
        requestBody.files.add(
          MapEntry(
            "selfie",
            await MultipartFile.fromFile(_image!.path, filename: fileName),
          ),
        );
      }

      debugPrint("=== API REQUEST: checkIn ===");
      debugPrint("URL: $url");
      debugPrint("Fields: ${requestBody.fields}");
      debugPrint(
        "Files: ${requestBody.files.map((e) => "${e.key}: ${e.value.filename}")}",
      );
      debugPrint("============================");

      final response = await dio.post(url, data: requestBody);

      debugPrint("=== API RESPONSE: checkIn ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("=============================");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          showToast(resData['message'] ?? "Checked in successfully.");
          return true;
        } else {
          showToast(resData['message'] ?? "Failed to check in.", isError: true);
          return false;
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
      return false;
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  void showInfoBottomSheet(BuildContext context, int bookingId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
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
                    onPressed: () async {
                      Get.back();
                      bool success = await updateAcceptStatus(bookingId, 7);
                      if (success) {
                        Get.back();
                      }
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
          ),
        );
      },
    );
  }

  void showAcceptBottomSheet(BuildContext context, int bookingId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
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
                          onPressed: () async {
                            Get.back();
                            bool success = await updateAcceptStatus(
                              bookingId,
                              1,
                            );
                            if (success) {
                              Get.to(
                                ShiftAcceptedSuccessfully(
                                  title: Strings.accepted,
                                  message: Strings.acceptedmsg,
                                  bookingId: bookingId,
                                ),
                              );
                            }
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
          ),
        );
      },
    );
  }

  void showCantCheckinBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
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
                      openCameraBottomSheet(context, "checkin");
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
          ),
        );
      },
    );
  }

  void openCameraBottomSheet(BuildContext context, String shiftType) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
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
                      // final cameras = await availableCameras();
                      // final frontCamera = cameras.firstWhere(
                      //       (camera) => camera.lensDirection == CameraLensDirection.front,
                      // );
                      // Get.to(CameraScreen(shiftType: shiftType));
                      openCamera(shiftType);
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
          ),
        );
      },
    );
  }

  void addReasonForLeaveBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "lib/Assets/Images/leave.svg",
                        // Replace with your SVG path
                        width: 40,
                        height: 40,
                      ),

                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    Strings.reasonforLeaving,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ReasonDropdownField(),
                SizedBox(height: 10),
                TextInputWidget(
                  label: Strings.howlong,
                  type: TextInputType.text,
                  height: 50,
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _LeaveShiftBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        Strings.submit,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _LeaveShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
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
                  Strings.leaveShift,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Strings.leaveshiftMsg,
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
                          onPressed: () async {
                            Get.back(); // close confirm sheet
                            Get.back(); // close reason sheet
                            String fromDate = "";
                            String toDate = "";
                            if (booking != null) {
                              if (booking?['from_date'] != null) {
                                try {
                                  fromDate =
                                      booking?['from_date'].toString().split(
                                        ' ',
                                      )[0] ??
                                      "";
                                } catch (_) {}
                              }
                              if (booking?['to_date'] != null) {
                                try {
                                  toDate =
                                      booking?['to_date'].toString().split(
                                        ' ',
                                      )[0] ??
                                      "";
                                } catch (_) {}
                              }
                            }
                            if (fromDate.isEmpty) {
                              fromDate =
                                  "${DateTime.now().toLocal()}".split(' ')[0];
                            }
                            if (toDate.isEmpty) {
                              toDate =
                                  "${DateTime.now().toLocal()}".split(' ')[0];
                            }
                            bool success = await requestLeave(
                              fromDate: fromDate,
                              toDate: toDate,
                            );
                            if (success) {
                              Get.to(LeaveShiftSuccessfully());
                            }
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
          ),
        );
      },
    );
  }

  Future<bool> requestLeave({
    required String fromDate,
    required String toDate,
  }) async {
    isLoading = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting Leave ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.requestLeave;
      debugPrint("URL: $url");
      debugPrint("Method: POST");

      dio.options.headers["Authorization"] = "Bearer $token";

      FormData formData = FormData.fromMap({
        "from_date": fromDate,
        "to_date": toDate,
      });

      debugPrint("Request Body: from_date: $fromDate, to_date: $toDate");

      final response = await dio.post(url, data: formData);

      debugPrint("=== Response for Request Leave ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true" || data['status'] == true) {
          showToast(data['message'] ?? "Leave requested successfully.");
          await getNurseLeaves();
          return true;
        } else {
          showToast(
            data['message'] ?? "Failed to request leave.",
            isError: true,
          );
          return false;
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
      return false;
    } catch (e) {
      debugPrint("Unexpected Error requesting leave: $e");
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getNurseLeaves() async {
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting Nurse Leaves ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.nurseLeaves;
      debugPrint("URL: $url");
      debugPrint("Method: GET");

      dio.options.headers["Authorization"] = "Bearer $token";

      final response = await dio.get(url);

      debugPrint("=== Response for Nurse Leaves ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            upcomingLeaves =
                data['upcoming_leaves'] is List ? data['upcoming_leaves'] : [];
            leaveHistory =
                data['leave_history'] is List ? data['leave_history'] : [];
            update();
          }
        }
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      debugPrint("Unexpected Error fetching nurse leaves: $e");
    }
  }
}
