import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:waaada_nurseapp/Controller/ProfileController.dart';
import 'package:waaada_nurseapp/Widget/NurseShiftItem.dart';

import '../../Controller/HomeController.dart';
import '../../Resource/Strings.dart';
import '../../Widget/TextStyleInterWithoutPadding.dart';
import 'HomeAppBar.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({Key? key}) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder(
            init: HomeController(),
            didChangeDependencies: (state){

            },
            builder:
                (controller) => Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyleInterWithoutPadding(
                        textAlign: TextAlign.center,
                        text: Strings.ongoing,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 15.00,
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return NurseShiftItem(bookingType: "ongoing",showLocationText: false,);
                        },
                      ),
                      SizedBox(height: 5),
                      TextStyleInterWithoutPadding(
                        textAlign: TextAlign.center,
                        text: Strings.upcoming,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 15.00,
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return NurseShiftItem(bookingType: "upcoming",showLocationText: false,);
                        },
                      ),
                      SizedBox(height: 5),
                      TextStyleInterWithoutPadding(
                        textAlign: TextAlign.center,
                        text: Strings.requests,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 15.00,
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return NurseShiftItem(bookingType: "requests",showLocationText: false,);
                        },
                      ),
                      SizedBox(height: 5),
                      TextStyleInterWithoutPadding(
                        textAlign: TextAlign.center,
                        text: Strings.recentshifts,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        size: 15.00,
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return NurseShiftItem(bookingType: "recent",showLocationText: false,);
                        },
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
