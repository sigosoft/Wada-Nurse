import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/NotificationsController.dart';
import '../../Resource/Strings.dart';
import '../../Widget/CustomAppBar.dart';
import 'NotificationItem.dart';

class NotificationsListing extends StatefulWidget {
  @override
  State<NotificationsListing> createState() => _NotificationsListingState();
}

class _NotificationsListingState extends State<NotificationsListing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          label:Strings.notifications,
         showCloseIcon: false,
          onTap: () {
            Get.back();
          },
        ),
        body: GetBuilder<NotificationsController>(
            init: NotificationsController(),
            initState: (_) {},
            builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(left: 5.0,right: 5,bottom: 15),
                color: Colors.white,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0,right: 10,top: 20,bottom: 5),
                      child: Text("Today",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NotificationItem(
                        );
                      },
                    ),
                  ],
                ),
              );
            }));
  }
}
