import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';


class NotificationItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child:
                  Text("duis deserunt mollit dolore ",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),),
                  Text(
                    "25 min",
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: greyishBlack),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: greyishBlack)),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            ]));
  }
}
