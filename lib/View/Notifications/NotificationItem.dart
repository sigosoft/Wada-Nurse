import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';


class NotificationItem extends StatelessWidget {
  final dynamic notification;

  const NotificationItem({super.key, this.notification});

  @override
  Widget build(BuildContext context) {
    final String title = notification?['title']?.toString() ?? 
                         notification?['data']?['title']?.toString() ?? 
                         "Notification";
    final String body = notification?['message']?.toString() ?? 
                        notification?['body']?.toString() ?? 
                        notification?['description']?.toString() ?? 
                        notification?['data']?['message']?.toString() ?? 
                        notification?['data']?['body']?.toString() ?? 
                        "";
    final String time = notification?['time_ago']?.toString() ?? 
                        notification?['converted_created_at']?.toString() ?? 
                        notification?['created_at']?.toString() ?? 
                        "";

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
                  Text(title,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),),
                  Text(
                    time,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: greyishBlack),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(body,
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
