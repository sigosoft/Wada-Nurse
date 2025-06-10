import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../Resource/Colors.dart';
import '../../Widget/TextStyleInterWithoutPadding.dart';
import '../Notifications/NotificationsListing.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
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
      title: Container(
        margin: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipOval(
                child: Image.asset(
                  "lib/Assets/Images/nurseimage.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 5,),
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
                TextStyleInterWithoutPadding(
                  textAlign: TextAlign.center,
                  text: "Joy Thomas",
                  color: greyishBlack,
                  fontWeight: FontWeight.w700,
                  size: 16.00,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
              onTap: () {
               Get.to(() => NotificationsListing());
              },
              child: SvgPicture.asset("lib/Assets/Images/bellIcon.svg",width: 25,height: 25,)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}