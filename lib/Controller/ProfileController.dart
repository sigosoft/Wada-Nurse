import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

import '../ApiConfigs/ApiConfigs.dart';
import '../Model/ProfileModel.dart';
import '../Resource/Colors.dart';
import '../Utils/CheckNetworkConnectivity.dart';
import '../Utils/HandleDioExceptions.dart';
import '../Utils/LoggingInterceptor.dart';
import '../Utils/ShowToast.dart';
import '../Utils/utils.dart' hide showToast;
import '../View/Login/Login.dart';
import 'HomeController.dart';

class ProfileController extends GetxController {
  bool premiumMembership = true;
  bool isLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());
  ProfileModel? profileModel;
  String name = "";
  String mobile = "";
  String salaried_or_not = "";
  String image = "";

  @override
  void onInit() {
    super.onInit();
    debugPrint("ProfileController initialized");
  }

  @override
  void onClose() {
    debugPrint("ProfileController disposed");
    super.onClose();
  }

  Future<void> getProfile() async {
    isLoading = true;
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.profile;
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      debugPrint("Response: ${response.data}");
      if (response.statusCode == 200) {
        profileModel = ProfileModel.fromJson(response.data);
        name = profileModel?.data.nurse.name?.toString() ?? "";
        mobile =
            (profileModel?.data.nurse.countryCode?.toString() ?? "") +
            " " +
            (profileModel?.data.nurse.mobile?.toString() ?? "");
        salaried_or_not =
            profileModel?.data.nurse.salaryType == 2
                ? "Salaried Employee"
                : "Hourly Employee";
        image = profileModel?.data.nurse.image?.toString() ?? "";
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().profileImage = image;
          Get.find<HomeController>().update();
        }
        update();
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String countryCode,
    required String mobile,
    required String email,
    required String dob,
    required String gender,
    required String qualification,
    required List<String> languages,
    String? pickedImagePath,
  }) async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.updateProfile;
      dio.options.headers["Authorization"] = "Bearer $token";

      int genderInt = 1;
      if (gender == 'Female') {
        genderInt = 2;
      } else if (gender == 'Other') {
        genderInt = 3;
      }

      Map<String, dynamic> formMap = {
        "name": name,
        "country_code": countryCode,
        "mobile": mobile,
        "email": email,
        "dob": dob,
        "gender": genderInt,
        "qualification": qualification,
        "languages": "[${languages.join(',')}]",
      };

      FormData formData = FormData.fromMap(formMap);

      if (pickedImagePath != null &&
          pickedImagePath.isNotEmpty &&
          !pickedImagePath.startsWith('http')) {
        String fileNameFromPath(String path) {
          var normalized = path.replaceAll('\\\\', '/');
          var parts = normalized.split('/');
          return parts.isNotEmpty ? parts.last : "";
        }

        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              pickedImagePath,
              filename: fileNameFromPath(pickedImagePath),
            ),
          ),
        );
      }

      debugPrint("=== API REQUEST: updateProfile ===");
      debugPrint("URL: $url");
      debugPrint("Body: $formMap");
      debugPrint("==================================");

      final response = await dio.post(url, data: formData);

      debugPrint("=== API RESPONSE: updateProfile ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("===================================");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          showToast(resData['message'] ?? "Profile updated successfully.");
          await getProfile();
          return true;
        } else {
          showToast(
            resData['message'] ?? "Failed to update profile",
            isError: true,
          );
          return false;
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
      return false;
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  void showCustomPopup(
    BuildContext context,
    String imagePath,
    String qrCodeId,
  ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.asset(
                        imagePath,
                        height: MediaQuery.of(context).size.height * 0.18,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextStyleInterWithPadding(
                      text: qrCodeId,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 12.00,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    isLoading = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting Logout ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.logout;
      debugPrint("URL: $url");
      debugPrint("Method: GET");

      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }

      final response = await dio.get(url);

      debugPrint("=== Response for Logout ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true" || data['status'] == true) {
          showToast(data['message'] ?? "Logged out successfully.");
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception during logout: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error during logout: $e");
    } finally {
      await removename("token");
      isLoading = false;
      update();
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<void> deleteAccount() async {
    isLoading = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting Delete Account ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.deleteAccount;
      debugPrint("URL: $url");
      debugPrint("Method: POST");

      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }

      final response = await dio.post(url);

      debugPrint("=== Response for Delete Account ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true" || data['status'] == true) {
          showToast(data['message'] ?? "Account deleted successfully.");
        } else {
          showToast(
            data['message'] ?? "Failed to delete account.",
            isError: true,
          );
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception during delete account: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error during delete account: $e");
    } finally {
      await removename("token");
      isLoading = false;
      update();
      Get.offAll(() => const LoginScreen());
    }
  }

  void showLogoutShiftBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                SvgPicture.asset(
                  "lib/Assets/Images/logout.svg",
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 5),
                Text(
                  Strings.logout,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Strings.logoutmsg,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
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
                            await logout();
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

  void showDeleteAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                SvgPicture.asset(
                  "lib/Assets/Images/deleteAccountIcon.svg",
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 5),
                Text(
                  Strings.deleteAccount,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Strings.deleteAccountMessage,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Strings.thisActionCantBeUndone,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: redColorText2,
                  ),
                ),
                SizedBox(height: 20),
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
                            backgroundColor: redBox,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            Strings.no,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: redColorText2,
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
                            await deleteAccount();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: redColorText2,
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
}
