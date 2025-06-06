import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool showCloseIcon;
  final bool showBackButton;
  final dynamic elevation;

  const CustomAppBar({
    super.key,
    required this.label,
    this.showCloseIcon = true,
    this.showBackButton=true,
    this.elevation,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      leading:  showBackButton
          ? InkWell(
        onTap: () {
          Get.back();
        },
        child: SvgPicture.asset(
          "lib/Assets/Images/back_arrow.svg",
          fit: BoxFit.scaleDown,
          color: Colors.black,
        ),
      )
          : null,
      title: Padding(
        padding:showBackButton? EdgeInsets.zero:EdgeInsets.only(left: 20.0),
        child: TextStyleInterWithPadding(
          text: label,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          size: 20.00,
        ),
      ),
      titleSpacing: -20.0, // Adjust this value to reduce the gap
      toolbarHeight: 50,
      actions: showCloseIcon
          ? [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              "lib/Assets/Images/CloseIcon.svg",
              fit: BoxFit.scaleDown,
              color: Colors.black,
            ),
          ),
        ),
      ]
          : null,
      elevation:elevation ?? 3,
      scrolledUnderElevation: 3.0,
    );
  }
}