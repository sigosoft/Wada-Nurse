import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppbarWithoutElevation extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarWithoutElevation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          "lib/Assets/Images/back_arrow.svg",
          fit: BoxFit.scaleDown,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
