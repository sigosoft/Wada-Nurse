import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class ProfileRowWidget extends StatelessWidget {
  final dynamic svgIcon;
  final dynamic text;
  final VoidCallback? onTap;

  const ProfileRowWidget({
    super.key,this.svgIcon,this.text,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                SvgPicture.asset(
                  svgIcon,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(width: 8.0),
                TextStyleInterWithPadding(
                  text: text,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  size: 14.00,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios,size: 16,),
        ],
      ),
    );
  }
}