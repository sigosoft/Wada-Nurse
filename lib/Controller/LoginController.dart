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
          Get.offAll(() => Home());
        } else {
          final message = data['message'] ?? "Login failed";
          showToast(message, isError: true);
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
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception: ${e.message}");
      }
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
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception: ${e.message}");
      }
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
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
