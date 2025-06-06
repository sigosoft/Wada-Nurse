import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';

class UploadedFilesListView extends StatelessWidget {
  final List<String> uploadedFiles = [
    'lib/Assets/Images/uploadedImageDummy.png',
    'lib/Assets/Images/uploadedImageDummy.png',
    'lib/Assets/Images/uploadedImageDummy.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110, // Provide a fixed height
      child: ListView.builder(
        itemCount: uploadedFiles.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: AssetImage(uploadedFiles[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Handle close button action
                  },
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: blackTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}