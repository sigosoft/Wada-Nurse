import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Utils/CheckNetworkConnectivity.dart';
import 'package:waaada_nurseapp/Utils/HandleDioExceptions.dart';
import 'package:waaada_nurseapp/Utils/LoggingInterceptor.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
import 'package:waaada_nurseapp/Utils/utils.dart' hide showToast;
import 'package:flutter/foundation.dart';
import 'package:waaada_nurseapp/Model/CountryCodeModel.dart';
import 'package:waaada_nurseapp/Controller/RegistrationController.dart';
import 'package:waaada_nurseapp/View/Home/Home.dart';
import 'package:waaada_nurseapp/View/OtpVerification/Otpverification.dart';
import 'package:waaada_nurseapp/View/CreateNewPassword/CreateNewPassword.dart';
import 'package:waaada_nurseapp/View/Login/Login.dart';

import 'package:waaada_nurseapp/View/Register/DocumentationUploadScreen.dart';
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController {
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());
  bool isLoading = false;
  int? selectedCountryCodeId;
  List<CountryCode> countryCodes = [];
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerCreatePassword1 =
      TextEditingController();
  TextEditingController passwordControllerCreatePassword2 =
      TextEditingController();
  bool isObscured = true;
  bool isObscuredForCreateNewPassword1 = true;
  bool isObscuredForCreateNewPassword2 = true;

  @override
  void onInit() {
    super.onInit();
    print("LoginController initialized");
  }

  @override
  void onClose() {
    print("LoginController disposed");
    super.onClose();
  }

  Future<void> checkUserStatusAndNavigate({bool showLoading = false}) async {
    if (showLoading) {
      isLoading = true;
      update();
    }
    try {
      var token = await getSavedObject("token");
      String profileUrl = ApiConfigs.baseUrl + APIEndpoints.profile;
      final Dio checkDio = Dio();
      checkDio.options.headers["Authorization"] = "Bearer $token";
      final profileResponse = await checkDio.get(profileUrl);

      if (profileResponse.statusCode == 200) {
        final resData = profileResponse.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final nurseData = resData['data']?['nurse'];
          if (nurseData != null) {
            final idProof = nurseData['id_proof_url'];
            final regPaymentId = nurseData['reg_payment_id'];
            final nId = nurseData['id']?.toString();
            if (nId != null) {
              saveObject("nurse_id", nId);
            }

            // Fetch registration fee
            double regFee = 0.0;
            try {
              String feeUrl =
                  ApiConfigs.baseUrl + APIEndpoints.getRegistrationFee;
              final feeResponse = await checkDio.get(feeUrl);
              if (feeResponse.statusCode == 200) {
                final fee =
                    feeResponse.data['data']?['nurse_reg_fee'] ??
                    feeResponse.data['data']?['registration_fee'];
                if (fee != null) {
                  regFee = double.tryParse(fee.toString()) ?? 0.0;
                }
              }
            } catch (e) {
              debugPrint("Error fetching registration fee: $e");
            }

            // Check if documents are uploaded and payment completed (if fee > 0)
            bool needsDocuments =
                (idProof == null || idProof.toString().trim().isEmpty);
            bool needsPayment =
                (regFee > 0 &&
                    (regPaymentId == null ||
                        regPaymentId.toString().trim().isEmpty));

            if (needsDocuments || needsPayment) {
              Get.offAll(
                () => DocumentationUploadScreen(
                  image: XFile(nurseData['image']?.toString() ?? ""),
                  fullName: nurseData['name']?.toString() ?? "",
                  countryCode: nurseData['country_code']?.toString() ?? "",
                  phoneNumber: nurseData['mobile']?.toString() ?? "",
                  email: nurseData['email']?.toString() ?? "",
                  dateOfBirth: nurseData['dob']?.toString() ?? "",
                  gender: nurseData['gender']?.toString() ?? "",
                  qualification: nurseData['qualification']?.toString() ?? "",
                  languages: const [],
                  password: "",
                  confirmPassword: "",
                  otp: "",
                  isAfterLogin: true,
                ),
              );
              return;
            }
          }
        }
      }
      Get.offAll(() => Home());
    } catch (e) {
      debugPrint("Error in checkUserStatusAndNavigate: $e");
      Get.offAll(() => Home());
    } finally {
      if (showLoading) {
        isLoading = false;
        update();
      }
    }
  }

  Future<void> getCountryCodes() async {
    isLoading = true;
    update();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.getCountryCodes;
      debugPrint("=== HTTP REQUEST (Isolate) ===");
      debugPrint("URL: $url");
      debugPrint("Method: GET");
      debugPrint("====================\n");
      countryCodes = await compute(fetchCountryCodesInIsolate, url);
      debugPrint("=== HTTP RESPONSE (Isolate) ===");
      debugPrint("URL: $url");
      debugPrint(
        "Response Body: ${countryCodes.map((e) => e.toJson()).toList()}",
      );
      debugPrint("=====================\n");
      if (countryCodes.isNotEmpty) {
        CountryCode? defaultCode;
        for (var code in countryCodes) {
          if (code.countryCode == "+91") {
            defaultCode = code;
            break;
          }
        }
        if (defaultCode != null) {
          selectedCountryCodeId = defaultCode.id;
        } else {
          selectedCountryCodeId = countryCodes.first.id;
        }
      }
    } catch (e) {
      debugPrint("Error fetching country codes: $e");
      countryCodes = [];
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> login() async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.login;
      final response = await dio.post(
        url,
        data: {
          "country_code_id": selectedCountryCodeId?.toString() ?? "1",
          "mobile": phoneNumberController.text,
          "password": passwordController.text,
          "fcm": "",
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true" || data['status'] == true) {
          final token = data['data']?['token'];
          if (token != null) {
            saveObject("token", token);
            debugPrint("Token saved successfully!");
          }
          final message = data['message'] ?? "Logged in successfully";
          showToast(message);
          await checkUserStatusAndNavigate(showLoading: true);
        } else {
          final message = data['message'] ?? "Login failed";
          showToast(message, isError: true);
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
      showToast("Something went wrong. Please try again.", isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> sendForgotOtp({
    required String mobile,
    required String countryCodeId,
  }) async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.sendForgotOtp;
      final Map<String, dynamic> requestBody = {
        "country_code": countryCodeId,
        "mobile": mobile,
      };

      debugPrint("=== API REQUEST: send_forgot_otp ===");
      debugPrint("URL: $url");
      debugPrint("Method: POST");
      debugPrint("Request Body: $requestBody");
      debugPrint("=================================");

      final response = await dio.post(url, data: requestBody);

      debugPrint("=== API RESPONSE: send_forgot_otp ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("==================================");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true" || data['status'] == true) {
          showToast(data['message'] ?? "OTP sent successfully.");
          Get.to(
            () => OtpVerification(
              isForgotPassword: true,
              mobile: mobile,
              countryCode: countryCodeId,
            ),
          );
        } else {
          showToast(data['data'] ?? "User not found", isError: true);
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      debugPrint("Unexpected Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> verifyForgotOtp({
    required String mobile,
    required String countryCodeId,
    required String otp,
  }) async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.verifyForgotOtp;
      final Map<String, dynamic> requestBody = {
        "country_code": countryCodeId,
        "mobile": mobile,
        "otp": otp,
      };

      debugPrint("=== API REQUEST: verify_forgot_otp ===");
      debugPrint("URL: $url");
      debugPrint("Method: POST");
      debugPrint("Request Body: $requestBody");
      debugPrint("=================================");

      final response = await dio.post(url, data: requestBody);

      debugPrint("=== API RESPONSE: verify_forgot_otp ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("==================================");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true" || data['status'] == true) {
          showToast(data['message'] ?? "OTP verified successfully.");
          Get.off(() => const CreateNewPassword());
        } else {
          showToast(data['message'] ?? "Invalid OTP", isError: true);
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      debugPrint("Unexpected Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> resetPassword() async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.resetPassword;
      final Map<String, dynamic> requestBody = {
        "country_code": selectedCountryCodeId?.toString() ?? "1",
        "mobile": phoneNumberController.text,
        "password": passwordControllerCreatePassword1.text,
        "password_confirmation": passwordControllerCreatePassword2.text,
      };

      debugPrint("=== API REQUEST: resetPassword ===");
      debugPrint("URL: $url");
      debugPrint("Method: POST");
      debugPrint("Request Body: $requestBody");
      debugPrint("================================");

      final response = await dio.post(url, data: requestBody);

      debugPrint("=== API RESPONSE: resetPassword ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("=================================");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == "true" || data['status'] == true) {
          showToast(data['message'] ?? "Password reset successfully.");
          // Clear controllers
          passwordControllerCreatePassword1.clear();
          passwordControllerCreatePassword2.clear();
          phoneNumberController.clear();
          // Navigate to Login page
          Get.offAll(() => const LoginScreen());
        } else {
          showToast(data['message'] ?? "Password reset failed", isError: true);
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      debugPrint("Unexpected Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
