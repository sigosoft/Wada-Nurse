import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithPadding.dart';

class ChooseImageWidget extends StatelessWidget {
  final Size media;
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  const ChooseImageWidget({
    super.key,
    required this.icon,
    required this.media,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: greyBg,
            borderRadius: BorderRadius.circular(6),
          ),
          height: media.height * 0.13,
          width: media.width * 0.28,
          child: InkWell(
            onTap: onTap,
            child: Center(child: Icon(icon, color: colorPrimary, size: 24)),
          ),
        ),
        const SizedBox(height: 10),
        TextStyleInterWithPadding(
          size: 14,
          text: text,
          color: colorPrimary,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
