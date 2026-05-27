import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Widget/NurseShiftItem.dart';
import '../../Controller/BookingsController.dart';
import '../../Resource/Colors.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({super.key, required this.index, required this.bookingType});
  final int index;
  final String bookingType;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: colorPrimary,
      onRefresh: () async {
        final BookingsController controller = Get.find<BookingsController>();
        if (bookingType == "requests") {
          await controller.getBookingRequests(silent: true);
        } else if (bookingType == "upcoming") {
          await controller.getPendingBookings(silent: true);
        } else if (bookingType == "ongoing") {
          await controller.getOngoingBookings(silent: true);
        } else if (bookingType == "completed") {
          await controller.getCompletedBookings(silent: true);
        }
      },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (bookingType == "requests") {
      return GetBuilder<BookingsController>(
        init: Get.find<BookingsController>(),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorPrimary),
            );
          }
          if (controller.bookingRequests.isEmpty) {
            return _buildEmptyState(context);
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.bookingRequests.length,
              itemBuilder: (context, indexValue) {
                return NurseShiftItem(
                  showLocationText: true,
                  bookingType: bookingType,
                  request: controller.bookingRequests[indexValue],
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
