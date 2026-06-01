import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../ApiConfigs/ApiConfigs.dart';
import '../Utils/CheckNetworkConnectivity.dart';
import '../Utils/HandleDioExceptions.dart';
import '../Utils/LoggingInterceptor.dart';
import '../Utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../Model/ProfileModel.dart';
import '../View/Settings/Maintenance.dart';
import '../View/Settings/NeedAnUpdate.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());

  Map<String, dynamic>? homeData;
  List<dynamic> ongoingRequests = [];
  List<dynamic> upcomingRequests = [];
  List<dynamic> pendingRequests = [];
  List<dynamic> recentRequests = [];
  String profileImage = "";

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

  Future<bool> checkMaintenanceAndUpdates() async {
    try {
      String url = ApiConfigs.baseUrl + APIEndpoints.settings;
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            // 1. Check Maintenance
            bool isMaintenance = false;
            String? reason;
            if (Platform.isAndroid) {
              final maintenance = data['android_nurse_maintenance'];
              isMaintenance = (maintenance == 1 || maintenance == "1");
              reason = data['android_nurse_maintenance_reason']?.toString();
            } else if (Platform.isIOS) {
              final maintenance = data['ios_nurse_maintenance'];
              isMaintenance = (maintenance == 1 || maintenance == "1");
              reason = data['ios_nurse_maintenance_reason']?.toString();
            }
            if (isMaintenance) {
              Get.offAll(() => Maintenance(serverDownReason: reason));
              return true;
            }

            // 2. Check Force Update
            try {
              final packageInfo = await PackageInfo.fromPlatform();
              final currentVersion = packageInfo.version;

              String latestVersion = "0.0.0";
              dynamic updateType = 0;

              if (Platform.isAndroid) {
                latestVersion =
                    data['android_nurse_version']?.toString() ?? "0.0.0";
                updateType = data['android_nurse_update'];
              } else if (Platform.isIOS) {
                latestVersion =
                    data['ios_nurse_version']?.toString() ?? "0.0.0";
                updateType = data['ios_nurse_update'];
              }

              if ((updateType == 2 || updateType == "2") &&
                  isVersionLessThan(currentVersion, latestVersion)) {
                Get.offAll(() => const NeedAnUpdate());
                return true;
              }
            } catch (e) {
              debugPrint("Error processing update logic: $e");
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Error checking maintenance/update settings: $e");
    }
    return false;
  }

  bool isVersionLessThan(String current, String latest) {
    try {
      List<int> currentParts =
          current.split('+').first.split('.').map(int.parse).toList();
      List<int> latestParts =
          latest.split('+').first.split('.').map(int.parse).toList();

      int length =
          currentParts.length > latestParts.length
              ? currentParts.length
              : latestParts.length;
      for (int i = 0; i < length; i++) {
        int currentPart = i < currentParts.length ? currentParts[i] : 0;
        int latestPart = i < latestParts.length ? latestParts[i] : 0;
        if (currentPart < latestPart) return true;
        if (currentPart > latestPart) return false;
      }
    } catch (e) {
      debugPrint("Error comparing versions: $e");
    }
    return false;
  }

  Future<void> getHome({bool silent = false}) async {
    if (!silent) {
      isLoading = true;
      update();
      checkNetworkAndRedirectOffAll();
    }
    final blockHomeScreen = await checkMaintenanceAndUpdates();
    if (blockHomeScreen) {
      if (!silent) {
        isLoading = false;
        update();
      }
      return;
    }
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");

      // Fetch profile image from Profile API
      try {
        String profileUrl = ApiConfigs.baseUrl + APIEndpoints.profile;
        dio.options.headers["Authorization"] = "Bearer $token";
        final profileResponse = await dio.get(profileUrl);
        if (profileResponse.statusCode == 200) {
          final resBody = profileResponse.data;
          if (resBody is Map) {
            final nurseImage = resBody['data']?['nurse']?['image'];
            if (nurseImage != null &&
                nurseImage.toString().isNotEmpty &&
                nurseImage.toString() != 'null') {
              profileImage = nurseImage.toString();
              debugPrint(
                "HomeController profileImage updated from Profile API: $profileImage",
              );
            }
          }
        }
      } catch (e) {
        debugPrint("Error fetching profile image from Profile API: $e");
      }

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
