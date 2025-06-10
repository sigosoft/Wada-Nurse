import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Resource/Colors.dart';

class ShiftDetailsWidget extends StatefulWidget {
  final String text1;
  final String text2;
  final bool showInfoButton;

  const ShiftDetailsWidget({
    super.key,
    required this.text1,
    required this.text2,
    this.showInfoButton = false,
  });

  @override
  State<ShiftDetailsWidget> createState() => _ShiftDetailsWidgetState();
}

class _ShiftDetailsWidgetState extends State<ShiftDetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: boxBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.text1,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.text2,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: greyTextColour,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // if (widget.showInfoButton)
          //   InkWell(
          //     onTap: () => showCustomDialog(context),
          //     child: Center(
          //       child: Icon(Icons.info_outlined, size: 18, color: Colors.black),
          //     ),
          //   ),
        ],
      ),
    );
  }
}