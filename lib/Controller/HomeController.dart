import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../ApiConfigs/ApiConfigs.dart';
import '../Utils/CheckNetworkConnectivity.dart';
import '../Utils/HandleDioExceptions.dart';
import '../Utils/LoggingInterceptor.dart';
import '../Utils/utils.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());

  Map<String, dynamic>? homeData;
  List<dynamic> ongoingRequests = [];
  List<dynamic> upcomingRequests = [];
  List<dynamic> pendingRequests = [];
  List<dynamic> recentRequests = [];

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startAutoUpdate();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startAutoUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      getHome(silent: true);
    });
  }

  Future<void> getHome({bool silent = false}) async {
    if (!silent) {
      isLoading = true;
      update();
      checkNetworkAndRedirectOffAll();
    }
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.home;
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            homeData = data;
            ongoingRequests = [];
            upcomingRequests = data['upcoming'] is List ? data['upcoming'] : [];
            pendingRequests = data['requests'] is List ? data['requests'] : [];
            recentRequests = data['recent'] is List ? data['recent'] : [];
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (!silent) {
        if (e.response != null) {
          handleDioException(e);
        } else {
          debugPrint("Dio Exception without response: ${e.message}");
        }
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      if (!silent) {
        isLoading = false;
      }
      update();
    }
  }
}
