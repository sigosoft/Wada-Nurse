import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({super.key, this.onTap, this.image});
  final VoidCallback? onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          image != null
              ? MediaQuery.of(context).size.width * 0.30
              : MediaQuery.of(context).size.width * 0.17,
      height:
          image != null
              ? MediaQuery.of(context).size.height * 0.15
              : MediaQuery.of(context).size.height * 0.08,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width:
                  image != null
                      ? MediaQuery.of(context).size.width * 0.30
                      : MediaQuery.of(context).size.width * 0.17,
              height:
                  image != null
                      ? MediaQuery.of(context).size.height * 0.15
                      : MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                border: Border.all(color: profilePicColor, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child:
                  image != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(image!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                      : Center(
                        child: SvgPicture.asset(
                          "lib/Assets/Images/profilePicIcon.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
            ),
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
      ),
    );
  }
}
