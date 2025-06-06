import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Widget/NurseShiftItem.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({super.key, required this.index,required this.bookingType});
  final int index;
  final String bookingType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: 3, // Number of items in the list
        itemBuilder: (context, indexValue) {
          return NurseShiftItem(showLocationText: index==0?true:false, bookingType: bookingType); // Show location text for index 1
        },
      ),
    );
  }
}