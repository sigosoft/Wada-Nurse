import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../ApiConfigs/ApiConfigs.dart';
import '../Utils/CheckNetworkConnectivity.dart';
import '../Utils/HandleDioExceptions.dart';
import '../Utils/LoggingInterceptor.dart';
import '../Utils/utils.dart';

class BookingsController extends GetxController {
  bool isLoading = false;
  bool isUpcomingLoading = false;
  bool isOngoingLoading = false;
  bool isCompletedLoading = false;
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());
  List<dynamic> bookingRequests = [];
  List<dynamic> upcomingBookings = [];
  List<dynamic> ongoingBookings = [];
  List<dynamic> completedBookings = [];

  int activeTabIndex = 0;
  Timer? _timer;

  int bookingRequestsPage = 1;
  bool hasMoreBookingRequests = true;
  bool isBookingRequestsMoreLoading = false;

  int upcomingBookingsPage = 1;
  bool hasMoreUpcomingBookings = true;
  bool isUpcomingBookingsMoreLoading = false;

  int ongoingBookingsPage = 1;
  bool hasMoreOngoingBookings = true;
  bool isOngoingBookingsMoreLoading = false;

  int completedBookingsPage = 1;
  bool hasMoreCompletedBookings = true;
  bool isCompletedBookingsMoreLoading = false;

  void _startAutoUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      refreshActiveTab(silent: true);
    });
  }

  void refreshActiveTab({bool silent = false}) {
    if (activeTabIndex == 0 || activeTabIndex == 1) {
      getBookingRequests(silent: silent);
    } else if (activeTabIndex == 2) {
      getPendingBookings(silent: silent);
    } else if (activeTabIndex == 3) {
      getOngoingBookings(silent: silent);
    } else if (activeTabIndex == 4) {
      getCompletedBookings(silent: silent);
    }
  }

  Future<void> getBookingRequests({
    bool silent = false,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isBookingRequestsMoreLoading || !hasMoreBookingRequests) return;
      isBookingRequestsMoreLoading = true;
      update();
    } else {
      bookingRequestsPage = 1;
      hasMoreBookingRequests = true;
      if (!silent) {
        isLoading = true;
        update();
        checkNetworkAndRedirectOffAll();
      }
    }
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url =
          "${ApiConfigs.baseUrl}${APIEndpoints.bookingRequests}?limit=10&page=$bookingRequestsPage";
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            final List<dynamic> fetchedList =
                data['data'] is List ? data['data'] : [];

            if (loadMore) {
              final existingIds =
                  bookingRequests
                      .map((item) => item['id'])
                      .where((id) => id != null)
                      .toSet();
              final newItems =
                  fetchedList
                      .where(
                        (item) =>
                            item['id'] == null ||
                            !existingIds.contains(item['id']),
                      )
                      .toList();
              bookingRequests.addAll(newItems);
            } else {
              bookingRequests = fetchedList;
            }

            final currentPage = data['current_page'] ?? bookingRequestsPage;
            final lastPage = data['last_page'] ?? currentPage;
            if (currentPage >= lastPage || fetchedList.length < 10) {
              hasMoreBookingRequests = false;
            } else {
              hasMoreBookingRequests = true;
              bookingRequestsPage = currentPage + 1;
            }
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (!silent && !loadMore) {
        handleDioException(e);
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      if (loadMore) {
        isBookingRequestsMoreLoading = false;
      } else if (!silent) {
        isLoading = false;
      }
      update();
    }
  }

  Future<void> getPendingBookings({
    bool silent = false,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isUpcomingBookingsMoreLoading || !hasMoreUpcomingBookings) return;
      isUpcomingBookingsMoreLoading = true;
      update();
    } else {
      upcomingBookingsPage = 1;
      hasMoreUpcomingBookings = true;
      if (!silent) {
        isUpcomingLoading = true;
        update();
        checkNetworkAndRedirectOffAll();
      }
    }
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url =
          "${ApiConfigs.baseUrl}${APIEndpoints.pendingBookings}?limit=10&page=$upcomingBookingsPage";
      debugPrint("Request GET: $url");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      debugPrint(
        "Response GET pendingBookings: ${response.statusCode} -> ${response.data}",
      );
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            final List<dynamic> fetchedList =
                data['data'] is List ? data['data'] : [];

            if (loadMore) {
              final existingIds =
                  upcomingBookings
                      .map((item) => item['id'])
                      .where((id) => id != null)
                      .toSet();
              final newItems =
                  fetchedList
                      .where(
                        (item) =>
                            item['id'] == null ||
                            !existingIds.contains(item['id']),
                      )
                      .toList();
              upcomingBookings.addAll(newItems);
            } else {
              upcomingBookings = fetchedList;
            }

            final currentPage = data['current_page'] ?? upcomingBookingsPage;
            final lastPage = data['last_page'] ?? currentPage;
            if (currentPage >= lastPage || fetchedList.length < 10) {
              hasMoreUpcomingBookings = false;
            } else {
              hasMoreUpcomingBookings = true;
              upcomingBookingsPage = currentPage + 1;
            }
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (!silent && !loadMore) {
        handleDioException(e);
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      if (loadMore) {
        isUpcomingBookingsMoreLoading = false;
      } else if (!silent) {
        isUpcomingLoading = false;
      }
      update();
    }
  }

  Future<void> getOngoingBookings({
    bool silent = false,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isOngoingBookingsMoreLoading || !hasMoreOngoingBookings) return;
      isOngoingBookingsMoreLoading = true;
      update();
    } else {
      ongoingBookingsPage = 1;
      hasMoreOngoingBookings = true;
      if (!silent) {
        isOngoingLoading = true;
        update();
        checkNetworkAndRedirectOffAll();
      }
    }
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url =
          "${ApiConfigs.baseUrl}${APIEndpoints.ongoingBookings}?limit=10&page=$ongoingBookingsPage";
      debugPrint("Request GET: $url");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      debugPrint(
        "Response GET ongoingBookings: ${response.statusCode} -> ${response.data}",
      );
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            final List<dynamic> fetchedList =
                data['data'] is List ? data['data'] : [];

            if (loadMore) {
              final existingIds =
                  ongoingBookings
                      .map((item) => item['id'])
                      .where((id) => id != null)
                      .toSet();
              final newItems =
                  fetchedList
                      .where(
                        (item) =>
                            item['id'] == null ||
                            !existingIds.contains(item['id']),
                      )
                      .toList();
              ongoingBookings.addAll(newItems);
            } else {
              ongoingBookings = fetchedList;
            }

            final currentPage = data['current_page'] ?? ongoingBookingsPage;
            final lastPage = data['last_page'] ?? currentPage;
            if (currentPage >= lastPage || fetchedList.length < 10) {
              hasMoreOngoingBookings = false;
            } else {
              hasMoreOngoingBookings = true;
              ongoingBookingsPage = currentPage + 1;
            }
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (!silent && !loadMore) {
        handleDioException(e);
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      if (loadMore) {
        isOngoingBookingsMoreLoading = false;
      } else if (!silent) {
        isOngoingLoading = false;
      }
      update();
    }
  }

  Future<void> getCompletedBookings({
    bool silent = false,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isCompletedBookingsMoreLoading || !hasMoreCompletedBookings) return;
      isCompletedBookingsMoreLoading = true;
      update();
    } else {
      completedBookingsPage = 1;
      hasMoreCompletedBookings = true;
      if (!silent) {
        isCompletedLoading = true;
        update();
        checkNetworkAndRedirectOffAll();
      }
    }
    try {
      var token = await getSavedObject("token");
      debugPrint("Token: $token");
      String url =
          "${ApiConfigs.baseUrl}${APIEndpoints.completedBookings}?limit=10&page=$completedBookingsPage";
      debugPrint("Request GET: $url");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(url);
      debugPrint(
        "Response GET completedBookings: ${response.statusCode} -> ${response.data}",
      );
      if (response.statusCode == 200) {
        final resData = response.data;
        if (resData['status'] == "true" || resData['status'] == true) {
          final data = resData['data'];
          if (data is Map<String, dynamic>) {
            final List<dynamic> fetchedList =
                data['data'] is List ? data['data'] : [];

            if (loadMore) {
              final existingIds =
                  completedBookings
                      .map((item) => item['id'])
                      .where((id) => id != null)
                      .toSet();
              final newItems =
                  fetchedList
                      .where(
                        (item) =>
                            item['id'] == null ||
                            !existingIds.contains(item['id']),
                      )
                      .toList();
              completedBookings.addAll(newItems);
            } else {
              completedBookings = fetchedList;
            }

            final currentPage = data['current_page'] ?? completedBookingsPage;
            final lastPage = data['last_page'] ?? currentPage;
            if (currentPage >= lastPage || fetchedList.length < 10) {
              hasMoreCompletedBookings = false;
            } else {
              hasMoreCompletedBookings = true;
              completedBookingsPage = currentPage + 1;
            }
          }
        }
      } else {
        throw Exception("Unexpected status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (!silent && !loadMore) {
        handleDioException(e);
      }
    } catch (e, stackTrace) {
      debugPrint("Unexpected Error: $e");
      debugPrint("Stack Trace: $stackTrace");
    } finally {
      if (loadMore) {
        isCompletedBookingsMoreLoading = false;
      } else if (!silent) {
        isCompletedLoading = false;
      }
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    print("BookingsController initialized");
    _startAutoUpdate();
  }

  @override
  void onClose() {
    print("BookingsController disposed");
    _timer?.cancel();
    super.onClose();
  }
}
