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
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}