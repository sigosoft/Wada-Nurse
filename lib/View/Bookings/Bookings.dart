import 'package:flutter/material.dart';
import '../../Resource/Colors.dart';
import '../../Resource/Strings.dart';
import '../../Widget/CustomAppBar.dart';
import 'TabBarItem.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild UI when tab changes
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _tabController.index == index
                                      ? colorPrimary
                                      : inactiveTab,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  index == 0
                                      ? Strings.requests
                                      : index == 1
                                          ? Strings.upcoming
                                          : Strings.completed,
                                  style: TextStyle(
                                    color: _tabController.index == index
                                        ? Colors.white
                                        : colorPrimaryDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (index < 2) SizedBox(width: 10), // Add space between buttons
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification notification) {
                    notification.disallowIndicator(); // Disable overscroll glow
                    return true;
                  },
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(), // Disable swipe scrolling
                    children: [
                      TabBarItem(index:0,bookingType: "requests",),
                      TabBarItem(index:1,bookingType: "upcoming",),
                      TabBarItem(index:2,bookingType: "completed",),
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