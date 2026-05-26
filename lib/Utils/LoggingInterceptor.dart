import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:waaada_nurseapp/Utils/utils.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("=== HTTP REQUEST ===");
    debugPrint("URL: ${options.uri}");
    debugPrint("Method: ${options.method}");
    debugPrint("Headers: ${options.headers}");

    // Print the saved authentication token if available
    try {
      final token = getSavedObject("token");
      if (token != null) {
        debugPrint("Saved Auth Token: $token");
      } else {
        debugPrint(
          "Saved Auth Token: Null (User not logged in or token not saved)",
        );
      }
    } catch (e) {
      // Catch potential storage read error if request is running in an isolate
      debugPrint(
        "Saved Auth Token: Running in Isolate (Storage access bypassed)",
      );
    }

    if (options.data != null) {
      if (options.data is FormData) {
        final formData = options.data as FormData;
        final fields = formData.fields
            .map((e) => "${e.key}: ${e.value}")
            .join(", ");
        final files = formData.files
            .map((e) => "${e.key}: ${e.value.filename}")
            .join(", ");
        debugPrint("Body (FormData): Fields: [$fields], Files: [$files]");
      } else {
        debugPrint("Body: ${options.data}");
      }
    }
    if (options.queryParameters.isNotEmpty) {
      debugPrint("QueryParameters: ${options.queryParameters}");
    }
    debugPrint("====================\n");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("=== HTTP RESPONSE ===");
    debugPrint("URL: ${response.requestOptions.uri}");
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Headers: ${response.headers.map}");
    debugPrint("Response Body: ${response.data}");
    debugPrint("=====================\n");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("=== HTTP ERROR ===");
    debugPrint("URL: ${err.requestOptions.uri}");
    debugPrint("Error: ${err.message}");
    if (err.response != null) {
      debugPrint("Status Code: ${err.response?.statusCode}");
      debugPrint("Headers: ${err.response?.headers.map}");
      debugPrint("Response Body: ${err.response?.data}");
    }
    debugPrint("==================\n");
    super.onError(err, handler);
  }
}
