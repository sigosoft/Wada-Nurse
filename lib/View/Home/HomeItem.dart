import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Widget/NurseShiftItem.dart';

import '../../Controller/HomeController.dart';
import '../../Resource/Strings.dart';
import '../../Resource/Colors.dart';
import '../../Widget/TextStyleInterWithoutPadding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'HomeAppBar.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({super.key});

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  final HomeController controller = Get.put(HomeController());
  bool _isInitialized = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        _isInitialized = true;
        controller.getHome();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.getHome(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          color: colorPrimary,
          onRefresh: () async {
            await controller.getHome(silent: true);
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: GetBuilder<HomeController>(
              init: controller,
              builder:
                  (controller) => Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.ongoingRequests.isEmpty &&
                            controller.upcomingRequests.isEmpty &&
                            controller.pendingRequests.isEmpty &&
                            controller.recentRequests.isEmpty) ...[
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.15,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "lib/Assets/Images/No data.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.3,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "No requests",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ] else ...[
                          if (controller.ongoingRequests.isNotEmpty) ...[
                            TextStyleInterWithoutPadding(
                              textAlign: TextAlign.center,
                              text: Strings.ongoing,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              size: 15.00,
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.ongoingRequests.length,
                              itemBuilder: (context, index) {
                                return NurseShiftItem(
                                  bookingType: "ongoing",
                                  showLocationText: false,
                                  request: controller.ongoingRequests[index],
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                          ],
                          if (controller.upcomingRequests.isNotEmpty) ...[
                            TextStyleInterWithoutPadding(
                              textAlign: TextAlign.center,
                              text: Strings.upcoming,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              size: 15.00,
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.upcomingRequests.length,
                              itemBuilder: (context, index) {
                                return NurseShiftItem(
                                  bookingType: "upcoming",
                                  showLocationText: false,
                                  request: controller.upcomingRequests[index],
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                          ],
                          if (controller.pendingRequests.isNotEmpty) ...[
                            TextStyleInterWithoutPadding(
                              textAlign: TextAlign.center,
                              text: Strings.requests,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              size: 15.00,
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.pendingRequests.length,
                              itemBuilder: (context, index) {
                                return NurseShiftItem(
                                  bookingType: "requests",
                                  showLocationText: false,
                                  request: controller.pendingRequests[index],
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                          ],
                          if (controller.recentRequests.isNotEmpty) ...[
                            TextStyleInterWithoutPadding(
                              textAlign: TextAlign.center,
                              text: Strings.recentshifts,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              size: 15.00,
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.recentRequests.length,
                              itemBuilder: (context, index) {
                                return NurseShiftItem(
                                  bookingType: "recent",
                                  showLocationText: false,
                                  request: controller.recentRequests[index],
                                );
                              },
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
