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
    if (bookingType == "requests") {
      return GetBuilder<BookingsController>(
        init: Get.find<BookingsController>(),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator(color: colorPrimary));
          }
          if (controller.bookingRequests.isEmpty) {
            return Center(
              child: Image.asset(
                "lib/Assets/Images/No bookings.png",
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.contain,
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
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
            return Center(child: CircularProgressIndicator(color: colorPrimary));
          }
          if (controller.upcomingBookings.isEmpty) {
            return Center(
              child: Image.asset(
                "lib/Assets/Images/No bookings.png",
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.contain,
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
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
            return Center(child: CircularProgressIndicator(color: colorPrimary));
          }
          if (controller.ongoingBookings.isEmpty) {
            return Center(
              child: Image.asset(
                "lib/Assets/Images/No bookings.png",
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.contain,
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
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
            return Center(child: CircularProgressIndicator(color: colorPrimary));
          }
          if (controller.completedBookings.isEmpty) {
            return Center(
              child: Image.asset(
                "lib/Assets/Images/No bookings.png",
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.contain,
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(15),
            child: ListView.builder(
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
}
