import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Utils/CheckNetworkConnectivity.dart';
import 'package:waaada_nurseapp/Utils/HandleDioExceptions.dart';
import 'package:waaada_nurseapp/Utils/LoggingInterceptor.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
import 'package:waaada_nurseapp/Utils/utils.dart' hide showToast;

class ChangePasswordController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("ChangePasswordController initialized");
  }

  @override
  void onClose() {
    print("ChangePasswordController disposed");
    super.onClose();
  }

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool isObscuredCurrentPassword = true;
  bool isObscuredNewPassword = true;
  bool isObscuredConfirmNewPassword = true;

  bool isLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.changePassword;
      dio.options.headers["Authorization"] = "Bearer $token";

      dio.options.queryParameters = {
        "current_password": currentPassword,
        "password": newPassword,
        "password_confirmation": confirmPassword,
      };

      debugPrint("=== API REQUEST: changePassword ===");
      debugPrint("URL: $url");
      debugPrint("Query Params: ${dio.options.queryParameters}");
      debugPrint("===================================");

      final response = await dio.get(url);

      debugPrint("=== API RESPONSE: changePassword ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("====================================");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          showToast(resData['message'] ?? "Password changed successfully.");
          return true;
        } else {
          showToast(
            resData['message'] ?? "Failed to change password",
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
}
