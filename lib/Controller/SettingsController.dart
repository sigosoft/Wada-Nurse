import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Utils/LoggingInterceptor.dart';
import 'package:waaada_nurseapp/Utils/utils.dart';
import 'package:waaada_nurseapp/Utils/HandleDioExceptions.dart';

class SettingsController extends GetxController {
  var isLoading = false.obs;
  bool tabValue = false;
  List<bool> expanded = [false, false, false, false, false];
  List<Map<String, String>> faqData = [
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle':
          'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle':
          'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle':
          'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle':
          'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
    {
      'title': 'Elit aute irure tempor cupidatat?',
      'subtitle':
          'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint ',
    },
  ];

  String termsContent = "";
  String privacyPolicyContent = "";
  String aboutContent = "";
  String contactPhone = "+968 943472138";
  String contactEmail = "customercare@.com";
  String contactAddress = "New Rajendra Nagar, Amlihdih, New Rajendra Nagar, Raipur, Tikrapara, Chhattisgarh 492001";

  Future<void> fetchTerms() async {
    isLoading.value = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting Terms ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.terms;
      debugPrint("URL: $url");
      debugPrint("Method: GET");

      final dio = Dio()..interceptors.add(LoggingInterceptor());
      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }

      final response = await dio.get(url);

      debugPrint("=== Response for Terms ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null &&
            data['data'] != null &&
            data['data']['content'] != null) {
          termsContent = data['data']['content'].toString();
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception fetching terms: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error fetching terms: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchPrivacyPolicy() async {
    isLoading.value = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting Privacy Policy ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.privacyPolicy;
      debugPrint("URL: $url");
      debugPrint("Method: GET");

      final dio = Dio()..interceptors.add(LoggingInterceptor());
      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }

      final response = await dio.get(url);

      debugPrint("=== Response for Privacy Policy ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null &&
            data['data'] != null &&
            data['data']['content'] != null) {
          privacyPolicyContent = data['data']['content'].toString();
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception fetching privacy policy: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error fetching privacy policy: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchAbout() async {
    isLoading.value = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting About ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.about;
      debugPrint("URL: $url");
      debugPrint("Method: GET");

      final dio = Dio()..interceptors.add(LoggingInterceptor());
      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }

      final response = await dio.get(url);

      debugPrint("=== Response for About ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null &&
            data['data'] != null &&
            data['data']['content'] != null) {
          aboutContent = data['data']['content'].toString();
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception fetching about: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error fetching about: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchContactUs() async {
    isLoading.value = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting Contact Us ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.contactUs;
      debugPrint("URL: $url");
      debugPrint("Method: GET");

      final dio = Dio()..interceptors.add(LoggingInterceptor());
      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }

      final response = await dio.get(url);

      debugPrint("=== Response for Contact Us ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            contactPhone = (data['phone'] ?? data['mobile'] ?? data['phone_number'] ?? data['contact'] ?? contactPhone).toString();
            contactEmail = (data['email'] ?? data['mail'] ?? contactEmail).toString();
            contactAddress = (data['address'] ?? data['office_address'] ?? data['location'] ?? contactAddress).toString();
          } else if (data is List && data.isNotEmpty) {
            final first = data.first;
            if (first is Map<String, dynamic>) {
              contactPhone = (first['phone'] ?? first['mobile'] ?? first['phone_number'] ?? first['contact'] ?? contactPhone).toString();
              contactEmail = (first['email'] ?? first['mail'] ?? contactEmail).toString();
              contactAddress = (first['address'] ?? first['office_address'] ?? first['location'] ?? contactAddress).toString();
            }
          }
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception fetching contact us: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error fetching contact us: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchFaqs() async {
    isLoading.value = true;
    update();
    try {
      var token = await getSavedObject("token");
      debugPrint("=== Requesting FAQs ===");
      debugPrint("Token: $token");
      String url = ApiConfigs.baseUrl + APIEndpoints.faqs;
      debugPrint("URL: $url");
      debugPrint("Method: GET");

      final dio = Dio()..interceptors.add(LoggingInterceptor());
      if (token != null) {
        dio.options.headers["Authorization"] = "Bearer $token";
      }

      final response = await dio.get(url);

      debugPrint("=== Response for FAQs ===");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.data}");

      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is List) {
            faqData = [];
            expanded = [];
            for (var item in data) {
              if (item is Map) {
                final title = item['question'] ?? item['title'] ?? item['q'] ?? "";
                final subtitle = item['answer'] ?? item['subtitle'] ?? item['a'] ?? "";
                faqData.add({
                  'title': title.toString(),
                  'subtitle': subtitle.toString(),
                });
                expanded.add(false);
              }
            }
          }
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        handleDioException(e);
      } else {
        debugPrint("Dio Exception fetching FAQs: ${e.message}");
      }
    } catch (e) {
      debugPrint("Unexpected Error fetching FAQs: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
