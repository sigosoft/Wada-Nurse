import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Utils/utils.dart' hide showToast;

class RazorpayService {
  static final RazorpayService _instance = RazorpayService._internal();
  factory RazorpayService() => _instance;

  late Razorpay _razorpay;
  bool _isInitialized = false;

  Function(PaymentSuccessResponse)? _onSuccessCallback;
  Function(PaymentFailureResponse)? _onFailureCallback;
  String _currentBookingType = '';
  String _currentBookingId = '';

  RazorpayService._internal() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _isInitialized = true;
  }

  void dispose() {
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("--- [RazorpayService] Payment Success Callback ---");
    print("Payment ID: ${response.paymentId}");
    print("Order ID: ${response.orderId}");
    print("Signature: ${response.signature}");

    if (response.paymentId == null ||
        response.orderId == null ||
        response.signature == null) {
      if (_onFailureCallback != null) {
        _onFailureCallback!(
          PaymentFailureResponse(
            Razorpay.PAYMENT_CANCELLED,
            "Invalid payment response parameters.",
            const {},
          ),
        );
      }
      return;
    }

    if (_onSuccessCallback != null) {
      _onSuccessCallback!(response);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("--- [RazorpayService] Payment Error Callback ---");
    print("Code: ${response.code}");
    print("Message: ${response.message}");
    if (_onFailureCallback != null) {
      _onFailureCallback!(response);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("--- [RazorpayService] External Wallet Callback ---");
    print("Wallet Name: ${response.walletName}");
  }

  // Call Backend to Create Order
  Future<String?> createOrder(
    double amount,
    String bookingType,
    String? nurseId,
  ) async {
    try {
      // Use get_storage token (same as used throughout this project)
      final String? token = getSavedObject("token");

      String url = "${ApiConfigs.baseUrl}${APIEndpoints.createOrder}";
      Map<String, dynamic> data = {
        'amount': amount.toStringAsFixed(2),
        'booking_type': bookingType,
        'nurse_id': nurseId ?? '',
      };

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print(
        "--- [RazorpayService] Requesting createOrder: POST $url with $data ---",
      );
      final FormData formData = FormData.fromMap(data);

      final Dio dio = Dio();
      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print(
        "--- [RazorpayService] createOrder response: ${response.statusCode} ---",
      );
      print("--- [RazorpayService] Response data: ${response.data} ---");

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        if (responseData is Map) {
          // If order_id or id is directly present, return it immediately
          var orderId = responseData['order_id'] ?? responseData['id'];
          if (orderId == null && responseData['data'] is Map) {
            orderId =
                responseData['data']['order_id'] ?? responseData['data']['id'];
          }
          if (orderId != null) {
            return orderId.toString();
          }

          // Fallback check for success/status indicators
          if (responseData['success'] == true ||
              responseData['success'].toString() == "true" ||
              responseData['status'] == true ||
              responseData['status'].toString() == "true") {
            var nestedId = responseData['order_id'] ?? responseData['id'];
            if (nestedId == null && responseData['data'] is Map) {
              nestedId =
                  responseData['data']['order_id'] ??
                  responseData['data']['id'];
            }
            if (nestedId != null) {
              return nestedId.toString();
            }
          }
        }
      }
      return null;
    } catch (e) {
      print("--- [RazorpayService] createOrder API EXCEPTION: $e ---");
      return null;
    }
  }

  // Start checkout flow
  Future<void> startPayment({
    required double amount, // in Rupees (e.g. 500)
    required String
    bookingType, // 'nurse_booking', 'doctor_booking', 'other_service_booking', 'nurse_registration'
    required String bookingId,
    required String description,
    required String contact,
    required String email,
    required String key, // Test Key: rzp_test_T8uZQ7cP2kcNGN
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    String? id, // nurse_id or doctor_id
    String? paymentType,
  }) async {
    _onSuccessCallback = onSuccess;
    _onFailureCallback = onFailure;
    _currentBookingType = bookingType;
    _currentBookingId = bookingId;

    // Show loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.blue)),
      barrierDismissible: false,
    );

    // Call backend to create order
    final orderId = await createOrder(amount, bookingType, id);

    // Close loading dialog
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (orderId == null) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Unable to generate order ID from backend."),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      onFailure(
        PaymentFailureResponse(
          Razorpay.PAYMENT_CANCELLED,
          "Failed to create order on backend.",
          const {},
        ),
      );
      return;
    }

    var options = {
      'key': key,
      'amount': (amount * 100).toInt(), // in paise
      'currency': 'INR',
      'name': 'Wada App',
      'description': description,
      'order_id': orderId,
      'payment_capture':
          1, // Auto capture payment immediately after authorization
      'prefill': {
        'contact': contact.isNotEmpty ? contact : '9876543210',
        'email': email.isNotEmpty ? email : 'test@test.com',
      },
      'notes': {
        'payment_type': paymentType ?? 'Online',
        'total_amount': amount.toString(),
        'type': bookingType,
        'id': id ?? '',
      },
      'config': {
        'display': {
          'hide': [
            {'method': 'emi'},
            {'method': 'paylater'},
          ],
          'preferences': {'show_default_blocks': true},
        },
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("--- [RazorpayService] Error opening Razorpay checkout: $e ---");
      onFailure(
        PaymentFailureResponse(
          Razorpay.PAYMENT_CANCELLED,
          e.toString(),
          const {},
        ),
      );
    }
  }
}
