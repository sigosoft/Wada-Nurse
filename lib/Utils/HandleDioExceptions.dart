import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Utils/ShowToast.dart';
import 'package:waaada_nurseapp/View/Settings/ServerDown.dart';

String _extractMessage(dynamic value) {
  if (value == null) return "";
  if (value is String) return value;
  if (value is List) {
    if (value.isEmpty) return "";
    return _extractMessage(value.first);
  }
  if (value is Map) {
    if (value.containsKey('message') && value['message'] != null) {
      final msg = _extractMessage(value['message']);
      if (msg.isNotEmpty) return msg;
    }
    if (value.containsKey('error') && value['error'] != null) {
      final msg = _extractMessage(value['error']);
      if (msg.isNotEmpty) return msg;
    }
    if (value.containsKey('errors') && value['errors'] != null) {
      final msg = _extractMessage(value['errors']);
      if (msg.isNotEmpty) return msg;
    }
    for (var val in value.values) {
      final msg = _extractMessage(val);
      if (msg.isNotEmpty) return msg;
    }
  }
  return value.toString();
}

String getErrorMessage(dynamic data) {
  if (data == null) return "Something went wrong";
  final extracted = _extractMessage(data);
  final cleaned = extracted.replaceAll(RegExp(r'[{}[\]]'), '').trim();
  return cleaned.isNotEmpty ? cleaned : "Something went wrong";
}

void handleDioException(DioException e) {
  if (e.response != null) {
    switch (e.response?.statusCode) {
      case 400:
        debugPrint("Bad Request: ${e.response?.data}");
        showToast(getErrorMessage(e.response?.data));
        break;
      case 401:
        debugPrint("Unauthorized: ${e.response?.data}");
        showToast("Unauthorized: Please login again");
        break;
      case 403:
        debugPrint("Forbidden: ${e.response?.data}");
        showToast(getErrorMessage(e.response?.data));
        break;
      case 404:
        debugPrint("Not Found: ${e.response?.data}");
        showToast("Resource Not Found");
        break;
      case 422:
        debugPrint("Validation Error: ${e.response?.data}");
        showToast(getErrorMessage(e.response?.data));
        break;
      case 500:
        debugPrint("Server Error: ${e.response?.data}");
        Get.offAll(const ServerDown());
        break;
      case 502:
        debugPrint("Bad Gateway: ${e.response?.data}");
        showToast("Server temporarily unavailable");
        break;
      case 503:
        debugPrint("Service Unavailable: ${e.response?.data}");
        showToast("Service temporarily unavailable");
        break;
      default:
        debugPrint(
          "Dio Error: ${e.response?.statusCode} -> ${e.response?.data}",
        );
        showToast("An error occurred: ${e.response?.statusCode}");
    }
  } else {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        debugPrint("Connection Timeout: ${e.message}");
        showToast("Connection timed out. Please check your internet");
        break;
      case DioExceptionType.sendTimeout:
        debugPrint("Send Timeout: ${e.message}");
        showToast("Request timed out");
        break;
      case DioExceptionType.receiveTimeout:
        debugPrint("Receive Timeout: ${e.message}");
        showToast("Request timed out");
        break;
      case DioExceptionType.badResponse:
        debugPrint("Bad Response: ${e.message}");
        break;
      case DioExceptionType.cancel:
        debugPrint("Request Cancelled: ${e.message}");
        showToast("Request cancelled");
        break;
      case DioExceptionType.unknown:
        debugPrint("Dio Exception (Unknown): ${e.message}");
        showToast("No internet connection. Please check your network");
        break;
      default:
        debugPrint("Dio Exception: ${e.message}");
        showToast("Network error occurred");
    }
  }
}
