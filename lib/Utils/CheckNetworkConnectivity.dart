import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/View/NoInternet/NoInternet.dart';




Future<bool> checkNetworkAndRedirect() async {
  try {
    List<ConnectivityResult> connectivityResult = 
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    }
    if (Get.context != null) {
      Get.to(() => const NoInternet());
    }
    return false;
  } on SocketException catch (_) {
    if (Get.context != null) {
      Get.to(() => const NoInternet());
    }
    return false;
  } catch (e) {
    // Any other error
    if (Get.context != null) {
      Get.to(() => const NoInternet());
    }
    return false;
  }
}

Future<bool> checkNetworkAndRedirectOffAll() async {
  try {
    List<ConnectivityResult> connectivityResult = 
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    }
    Get.offAll(() => const NoInternet());
    return false;
  } on SocketException catch (_) {
    Get.offAll(() => const NoInternet());
    return false;
  } catch (e) {
    Get.offAll(() => const NoInternet());
    return false;
  }
}

Future<bool> isNetworkAvailable() async {
  try {
    List<ConnectivityResult> connectivityResult = 
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      final result = await InternetAddress.lookup('google.com'); 
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    }
    return false;
  } on SocketException catch (_) {
    return false;
  } catch (e) {
    return false;
  }
}