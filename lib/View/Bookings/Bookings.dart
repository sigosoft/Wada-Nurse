import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Controller/BookingsController.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widget/CustomAppBar.dart';
import '../Home/Home.dart';
import 'TabBarItem.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings>
    with SingleTickerProviderStateMixin {
  final BookingsController controller = Get.put(BookingsController());
  late TabController _tabController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      controller.activeTabIndex = _tabController.index;
      setState(() {}); // Rebuild UI when tab changes
      if (_tabController.index == 0) {
        controller.getBookingRequests();
      } else if (_tabController.index == 1) {
        controller.getBookingRequests();
      } else if (_tabController.index == 2) {
        controller.getPendingBookings();
      } else if (_tabController.index == 3) {
        controller.getOngoingBookings();
      } else if (_tabController.index == 4) {
        controller.getCompletedBookings();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        _isInitialized = true;
        controller.activeTabIndex = 0;
        controller.getBookingRequests();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        label: Strings.bookings,
        showCloseIcon: false,
        showBellIcon: true,
        elevation: 0.0,
        onTap: () {
          Get.offAll(Home());
        },
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: index < 5 ? 10 : 0,
                        ), // Add space between buttons
                        child: InkWell(
                          onTap: () {
                            _tabController.animateTo(index);
                          },
                          child: Container(
                            height: 50,
                            width: 100, // Adjust width as needed
                            decoration: BoxDecoration(
                              color:
                                  _tabController.index == index
                                      ? colorPrimary
                                      : inactiveTab,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              index == 0
                                  ? "All Requests"
                                  : index == 1
                                  ? "Pending"
                                  : index == 2
                                  ? Strings.upcoming
                                  : index == 3
                                  ? Strings.ongoing
                                  : index == 4
                                  ? Strings.completed
                                  : Strings.cancelled,
                              style: TextStyle(
                                color:
                                    _tabController.index == index
                                        ? Colors.white
                                        : colorPrimaryDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (
                    OverscrollIndicatorNotification notification,
                  ) {
                    notification.disallowIndicator(); // Disable overscroll glow
                    return true;
                  },
                  child: TabBarView(
                    controller: _tabController,
                    physics:
                        NeverScrollableScrollPhysics(), // Disable swipe scrolling
                    children: [
                      TabBarItem(index: 0, bookingType: "requests"),
                      TabBarItem(index: 1, bookingType: "pending"),
                      TabBarItem(index: 2, bookingType: "upcoming"),
                      TabBarItem(index: 3, bookingType: "ongoing"),
                      TabBarItem(index: 4, bookingType: "completed"),
                      TabBarItem(index: 5, bookingType: "cancelled"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
