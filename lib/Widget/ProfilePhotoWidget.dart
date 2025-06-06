import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.height * 0.09,
      child: Stack(
        children: [
          // Main profile icon
          Container(
            width: MediaQuery.of(context).size.width * 0.17,
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: profilePicColor, width: 4),
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Center(
              child: SvgPicture.asset("lib/Assets/Images/profilePicIcon.svg",
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          // Edit icon (pencil) in bottom-right
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: profilePicColor,
                border: Border.all(color: profilePicColor),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
