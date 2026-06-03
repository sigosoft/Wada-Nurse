import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/ApiConfigs/ApiConfigs.dart';
import 'package:waaada_nurseapp/Controller/HomeController.dart';
import '../../Resource/Colors.dart';
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
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipOval(
                    child:
                        nurseImage != null &&
                                nurseImage.toString().isNotEmpty &&
                                nurseImage.toString() != "null"
                            ? CachedNetworkImage(
                              imageUrl:
                                  ApiConfigs.Image_URL + nurseImage.toString(),
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: colorPrimary,
                                      ),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Image.asset(
                                    "lib/Assets/Images/nurseimage.png",
                                    fit: BoxFit.cover,
                                  ),
                            )
                            : Image.asset(
                              "lib/Assets/Images/nurseimage.png",
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleInterWithoutPadding(
                      textAlign: TextAlign.center,
                      text: "Good Morning!",
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
