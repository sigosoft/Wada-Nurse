import 'package:flutter/material.dart';

class CustomClipRRect extends StatelessWidget {
  final double borderRadius;
  final String imagePath;

  const CustomClipRRect({
    super.key,
    required this.borderRadius,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child:
          (imagePath == "null" || imagePath.isEmpty)
              ? Image.asset(
                "lib/Assets/Images/noprofileimage.png",
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              )
              : Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
                errorBuilder:
                    (context, error, stackTrace) => Image.asset(
                      "lib/Assets/Images/noprofileimage.png",
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
              ),
    );
  }
}
