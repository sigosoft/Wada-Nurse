import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../ApiConfigs/ApiConfigs.dart';
import '../Utils/CheckNetworkConnectivity.dart';
import '../Utils/HandleDioExceptions.dart';
import '../Utils/LoggingInterceptor.dart';
import '../Utils/utils.dart';


class BookingsController extends GetxController {
  bool isLoading = false;
  bool isUpcomingLoading = false;
  bool isOngoingLoading = false;
  bool isCompletedLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());
  List<dynamic> bookingRequests = [];
  List<dynamic> upcomingBookings = [];
  List<dynamic> ongoingBookings = [];
  List<dynamic> completedBookings = [];

  Future<void> getBookingRequests() async {
    isLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = "${ApiConfigs.baseUrl}${APIEndpoints.bookingRequests}?limit=10";
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            bookingRequests = data['data'] is List ? data['data'] : [];
          }
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
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getPendingBookings() async {
    isUpcomingLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = "${ApiConfigs.baseUrl}${APIEndpoints.pendingBookings}?limit=10";
      debugPrint("Request GET: $url");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      debugPrint("Response GET pendingBookings: ${response.statusCode} -> ${response.data}");
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            upcomingBookings = data['data'] is List ? data['data'] : [];
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint("Dio Exception response: ${e.response?.data}");
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      isUpcomingLoading = false;
      update();
    }
  }

  Future<void> getOngoingBookings() async {
    isOngoingLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = "${ApiConfigs.baseUrl}${APIEndpoints.ongoingBookings}?limit=10";
      debugPrint("Request GET: $url");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      debugPrint("Response GET ongoingBookings: ${response.statusCode} -> ${response.data}");
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            ongoingBookings = data['data'] is List ? data['data'] : [];
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint("Dio Exception response: ${e.response?.data}");
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      isOngoingLoading = false;
      update();
    }
  }

  Future<void> getCompletedBookings() async {
    isCompletedLoading = true;
    update();
    checkNetworkAndRedirectOffAll();
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = "${ApiConfigs.baseUrl}${APIEndpoints.completedBookings}?limit=10";
      debugPrint("Request GET: $url");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      debugPrint("Response GET completedBookings: ${response.statusCode} -> ${response.data}");
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            completedBookings = data['data'] is List ? data['data'] : [];
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint("Dio Exception response: ${e.response?.data}");
        handleDioException(e);
      } else {
        debugPrint("Dio Exception without response: ${e.message}");
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      isCompletedLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("BookingsController initialized");
  }

  @override
  void onClose() {
    print("BookingsController disposed");
    super.onClose();
  }

}