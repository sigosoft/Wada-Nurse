import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';


class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic onTap;

  const ProfileAppBar({super.key,this.onTap});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      scrolledUnderElevation: 3.0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextStyleInterWithPadding(
                    text: Strings.profile,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    size: 20.00,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                      onTap: onTap,
                      child: SvgPicture.asset("lib/Assets/Images/MenuIcon.svg")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}