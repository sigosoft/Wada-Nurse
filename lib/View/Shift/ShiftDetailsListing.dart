import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:get/get.dart';
import '../../Resource/Strings.dart';
import '../../Widget/CustomAppBar.dart';

class ShiftDetailsListing extends StatefulWidget {
  const ShiftDetailsListing({super.key});

  @override
  State<ShiftDetailsListing> createState() => _ShiftDetailsListingState();
}

class _ShiftDetailsListingState extends State<ShiftDetailsListing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.shiftdetails, showCloseIcon: false,onTap: Get.back,),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "David Thomas",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Age: 75 | Gender: M",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: greyishBlack,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Nursing Fee: ₹4,000",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: greyishBlack,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Raipur",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: greyishBlack,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "7J3H+2RG Raipur, Chhattisgarh",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: greyishBlack,
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAF3FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "08 Feb 2025",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.in_value,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "09:30 AM",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              Strings.out_value,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "1:30 PM",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}