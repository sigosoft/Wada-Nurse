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
    final media = MediaQuery.of(context);
    final mediaSize = media.size;
    final devicePixelRatio = media.devicePixelRatio;
    final width = image != null ? mediaSize.width * 0.30 : mediaSize.width * 0.17;
    final height = image != null ? mediaSize.height * 0.15 : mediaSize.height * 0.08;
    
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(color: profilePicColor, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: image!.startsWith('http')
                          ? Image.network(
                              image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Image.file(
                              File(image!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              cacheWidth: (width * devicePixelRatio).round(),
                              cacheHeight: (height * devicePixelRatio).round(),
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
