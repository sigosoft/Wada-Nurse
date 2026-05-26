import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
