import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Utils/CheckNetworkConnectivity.dart';
import 'package:waaada_nurseapp/Utils/HandleDioExceptions.dart';
import 'package:waaada_nurseapp/Utils/LoggingInterceptor.dart';
import 'package:waaada_nurseapp/Utils/utils.dart' hide showToast;

class NotificationsController extends GetxController {
  bool isLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());
  List<dynamic> notifications = [];

  @override
  void onInit() {
    super.onInit();
    debugPrint("NotificationsController initialized");
    getNotifications();
  }

  @override
  void onClose() {
    debugPrint("NotificationsController disposed");
    super.onClose();
  }

  Future<void> getNotifications() async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url =
          "${ApiConfigs.baseUrl}${APIEndpoints.notifications}?limit=10";
      dio.options.headers["Authorization"] = "Bearer $token";

      debugPrint("=== API REQUEST: notifications ===");
      debugPrint("URL: $url");
      debugPrint("================================");

      final response = await dio.get(url);

      debugPrint("=== API RESPONSE: notifications ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");
      debugPrint("=================================");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final dataMap = resData['data'];
          if (dataMap is Map<String, dynamic>) {
            final notificationDate = dataMap['notification_date'];
            if (notificationDate is Map<String, dynamic>) {
              notifications =
                  notificationDate['data'] is List
                      ? notificationDate['data']
                      : [];
            }
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
}
