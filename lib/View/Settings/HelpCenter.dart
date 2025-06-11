import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/SettingsController.dart';
import '../../Resource/Strings.dart';
import '../../Resource/colors.dart';
import '../../Widget/CustomAppBar.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          label: Strings.helpCentre,
          showCloseIcon: false,
        ),
        body: GetBuilder<SettingsController>(
          init: SettingsController(),
          initState: (_) {},
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),
                      Text(Strings.feedback,
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: greyishBlack)),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.callUs,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: greyishBlack)),
                            SizedBox(height: 5,),
                            Text("+968 943472138",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: greyishBlack)),
                          ],
                        )),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.emailUs,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: greyishBlack)),
                            SizedBox(height: 5,),
                            Text("customercare@.com",
                                style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: greyishBlack)),
                          ],
                        ))
                      ],),

                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
                  child: Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15,top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(Strings.companyOffice,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: greyishBlack)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "New Rajendra Nagar, Amlihdih, New Rajendra Nagar, Raipur, Tikrapara, Chhattisgarh 492001",
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: greyishBlack)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
