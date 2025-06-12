import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Resource/colors.dart';

void showToast(
  String message, {
  BuildContext? context,
  SnackBarAction? action,
  Duration? duration,
  bool isError = false,
}) {
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
        backgroundColor: isError ? Colors.red : colorPrimary,
        behavior: SnackBarBehavior.floating,
        action: action,
        margin: const EdgeInsets.all(16),
      ),
    );
  } else {
    Get.snackbar(
      isError ? 'Error' : 'Message',
      message,
      snackPosition: SnackPosition.TOP,
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : colorPrimary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
