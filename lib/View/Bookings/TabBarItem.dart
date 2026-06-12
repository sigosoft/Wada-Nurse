import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Widget/NurseShiftItem.dart';
import '../../Controller/BookingsController.dart';
import '../../Resource/Colors.dart';

class TabBarItem extends StatefulWidget {
  const TabBarItem({super.key, required this.index, required this.bookingType});
  final int index;
  final String bookingType;

  @override
  State<TabBarItem> createState() => _TabBarItemState();
}

class _TabBarItemState extends State<TabBarItem> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final BookingsController controller = Get.find<BookingsController>();
      if (widget.bookingType == "requests" || widget.bookingType == "pending") {
        controller.getBookingRequests(loadMore: true);
      } else if (widget.bookingType == "upcoming") {
        controller.getPendingBookings(loadMore: true);
      } else if (widget.bookingType == "ongoing") {
        controller.getOngoingBookings(loadMore: true);
      } else if (widget.bookingType == "completed") {
        controller.getCompletedBookings(loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: colorPrimary,
      onRefresh: () async {
        final BookingsController controller = Get.find<BookingsController>();
        if (widget.bookingType == "requests" || widget.bookingType == "pending") {
          await controller.getBookingRequests(silent: true);
        } else if (widget.bookingType == "upcoming") {
          await controller.getPendingBookings(silent: true);
        } else if (widget.bookingType == "ongoing") {
          await controller.getOngoingBookings(silent: true);
        } else if (widget.bookingType == "completed") {
          await controller.getCompletedBookings(silent: true);
        }
      },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final String bookingType = widget.bookingType;
    final int index = widget.index;

    if (bookingType == "requests") {
      return GetBuilder<BookingsController>(
        init: Get.find<BookingsController>(),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          final filteredList = controller.bookingRequests.where((item) {
            final status = item['booking_status']?.toString() ??
                item['bookingStatus']?.toString() ??
                "";
            return status != "1" && status != "7";
          }).toList();

          if (filteredList.isEmpty) {
            return _buildEmptyState(context);
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredList.length,
              itemBuilder: (context, indexValue) {
                return NurseShiftItem(
                  showLocationText: true,
                  bookingType: bookingType,
                  request: filteredList[indexValue],
                );
              },
            ),
          );
        },
      );
    }

    if (bookingType == "pending") {
      return GetBuilder<BookingsController>(
        init: Get.find<BookingsController>(),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          final filteredList = controller.bookingRequests.where((item) {
            final status = item['booking_status']?.toString() ??
                item['bookingStatus']?.toString() ??
                "";
            return status == "1";
          }).toList();

          if (filteredList.isEmpty) {
            return _buildEmptyState(context);
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredList.length,
              itemBuilder: (context, indexValue) {
                return NurseShiftItem(
                  showLocationText: true,
                  bookingType: "requests",
                  request: filteredList[indexValue],
                );
              },
            ),
          );
        },
      );
    }

    if (bookingType == "upcoming") {
      return GetBuilder<BookingsController>(
        init: Get.find<BookingsController>(),
        builder: (controller) {
          if (controller.isUpcomingLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          if (controller.upcomingBookings.isEmpty) {
            return _buildEmptyState(context);
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.upcomingBookings.length,
              itemBuilder: (context, indexValue) {
                return NurseShiftItem(
                  showLocationText: false,
                  bookingType: bookingType,
                  request: controller.upcomingBookings[indexValue],
                );
              },
            ),
          );
        },
      );
    }

    if (bookingType == "ongoing") {
      return GetBuilder<BookingsController>(
        init: Get.find<BookingsController>(),
        builder: (controller) {
          if (controller.isOngoingLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          if (controller.ongoingBookings.isEmpty) {
            return _buildEmptyState(context);
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.ongoingBookings.length,
              itemBuilder: (context, indexValue) {
                return NurseShiftItem(
                  showLocationText: false,
                  bookingType: bookingType,
                  request: controller.ongoingBookings[indexValue],
                );
              },
            ),
          );
        },
      );
    }

    if (bookingType == "completed") {
      return GetBuilder<BookingsController>(
        init: Get.find<BookingsController>(),
        builder: (controller) {
          if (controller.isCompletedLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          if (controller.completedBookings.isEmpty) {
            return _buildEmptyState(context);
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.completedBookings.length,
              itemBuilder: (context, indexValue) {
                return NurseShiftItem(
                  showLocationText: false,
                  bookingType: bookingType,
                  request: controller.completedBookings[indexValue],
                );
              },
            ),
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.all(15),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 3, // Number of items in the list
        itemBuilder: (context, indexValue) {
          return NurseShiftItem(
            showLocationText: index == 0 ? true : false,
            bookingType: bookingType,
          ); // Show location text for index 1
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Center(
          child: Image.asset(
            "lib/Assets/Images/No bookings.png",
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
