import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Controller/HomeController.dart';
import '../../Resource/Colors.dart';
import '../../Widget/CustomCliprect.dart';
import '../../Widget/TextStyleInterWithoutPadding.dart';
import '../Notifications/NotificationsListing.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      elevation: 3,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 3.0,
      leadingWidth: 0.0,
      leading: Container(),
      title: GetBuilder<HomeController>(
        builder: (controller) {
          final nurseName =
              controller.profileName.isNotEmpty
                  ? controller.profileName
                  : controller.homeData?['nurse']?['name'];
          final nurseImage =
              controller.profileImage.isNotEmpty
                  ? controller.profileImage
                  : controller.homeData?['nurse']?['image'];

          return Container(
            margin: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                CustomClipRRect(
                  borderRadius: 60,
                  imagePath:
                      nurseImage != null &&
                              nurseImage.toString().isNotEmpty &&
                              nurseImage.toString() != "null"
                          ? ApiConfigs.Image_URL + nurseImage.toString()
                          : "",
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleInterWithoutPadding(
                      textAlign: TextAlign.center,
                      text: () {
                        final hour = DateTime.now().hour;
                        if (hour < 12) return "Good Morning!";
                        if (hour < 15) return "Good Afternoon!";
                        return "Good Evening!";
                      }(),
                      color: greyishBlack,
                      fontWeight: FontWeight.w500,
                      size: 12.00,
                    ),
                    if (nurseName != null && nurseName.toString().isNotEmpty)
                      TextStyleInterWithoutPadding(
                        textAlign: TextAlign.center,
                        text: nurseName.toString(),
                        color: greyishBlack,
                        fontWeight: FontWeight.w700,
                        size: 16.00,
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: () {
              Get.to(() => NotificationsListing());
            },
            child: SvgPicture.asset(
              "lib/Assets/Images/bellIcon.svg",
              width: 25,
              height: 25,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
