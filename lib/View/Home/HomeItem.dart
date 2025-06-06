import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Controller/HomeController.dart';
import '../../Resource/Strings.dart';
import '../../Widget/TextStyleInterWithoutPadding.dart';
import 'HomeAppBar.dart';
import 'RequestsItem.dart';

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
            builder:
                (controller) => Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return RequestsItem();
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
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return RequestsItem();
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
