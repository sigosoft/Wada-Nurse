import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../ApiConfigs/ApiConfigs.dart';
import '../Utils/CheckNetworkConnectivity.dart';
import '../Utils/HandleDioExceptions.dart';

class HomeController extends GetxController {

  bool isLoading = false;
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }



  // Future<void> getHome() async {
  //   isLoading = true;
  //   checkNetworkAndRedirectOffAll();
  //   try {
  //     var token = await getSavedObject("token");
  //     debugPrint("Token: $token");
  //     String url = ApiConfigs.baseUrl + APIEndpoints.home;
  //     dio.options.headers["Authorization"] = "Bearer $token";
  //     final response = await dio.get(url);
  //     debugPrint("Response: ${response.data}");
  //     if (response.statusCode == 200) {
  //       languages = LanguageModel.fromJson(response.data);
  //       update();
  //     } else {
  //       throw Exception("Unexpected status code: ${response.statusCode}");
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       handleDioException(e);
  //     } else {
  //       debugPrint("Dio Exception without response: ${e.message}");
  //     }
  //   } catch (e) {
  //     debugPrint("Unexpected Error: $e");
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
