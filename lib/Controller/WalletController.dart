import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/SuccessScreens/WithdrawalSuccessScreen.dart';
import 'package:waaada_nurseapp/Widget/NurseShiftItem.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';

import '../Resource/Colors.dart';

class WalletController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("WalletController initialized");
  }

  @override
  void onClose() {
    print("WalletController disposed");
    super.onClose();
  }


  final List<Map<String, dynamic>> transactions = [
    {
      "date": "24 Oct 2023",
      "title": "Wada Office",
      "status": "Credited",
      "amount": "37,800",
      "isCredited": true,
    },
    {
      "date": "02 Nov 2023",
      "title": "Client Payment",
      "status": "Credited",
      "amount": "15,000",
      "isCredited": true,
    },
    {
      "date": "10 Nov 2023",
      "title": "Internet Bill",
      "status": "Debited",
      "amount": "1,200",
      "isCredited": false,
    },
    {
      "date": "15 Nov 2023",
      "title": "Office Rent",
      "status": "Debited",
      "amount": "20,000",
      "isCredited": false,
    },
    {
      "date": "20 Nov 2023",
      "title": "Wada Office",
      "status": "Credited",
      "amount": "25,500",
      "isCredited": true,
    },
  ];


  void deleteBankAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                ClipRect(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorPrimary,
                    ),
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                      "lib/Assets/Images/deleteWhiteIcon.svg",
                      width: 40,
                      height: 40,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  Strings.deleteBankAccount,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  Strings.areYouSureYouWantToDelete,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  Strings.thisActionCantBeUndone,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: redColorText2,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE7F4FD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            Strings.no,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            Strings.yes,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showWithdrawBottomSheet(BuildContext context) {
    TextEditingController amountController = TextEditingController(text: "200");
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom + 20,
          ),
          child: SafeArea(
            child: StatefulBuilder(
              builder: (context, setState) =>
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextStyleInterWithoutPadding(
                            text: Strings.withDraw,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            size: 20.00,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: amountController,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: grayText2,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "₹0",
                          prefixText: "₹",
                          prefixStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: grayText2,
                          ),
                          filled: true,
                          fillColor: boxGradient,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: borderColor
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [200, 500, 800, 1000].map((amount) {
                          final isSelected = amountController.text == "$amount";
                          return GestureDetector(
                            onTap: () {
                              amountController.text = "$amount";
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? colorPrimary : boxGradient,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:
                              TextStyleInterWithoutPadding(
                                text: "₹$amount",
                                color: isSelected ? Colors.white : grayText2,
                                fontWeight: FontWeight.w500,
                                size: 14.00,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: boxGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  TextStyleInterWithoutPadding(
                                    text: "SBI Bank",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    size: 14.00,
                                  ),
                                  SizedBox(height: 8),
                                  TextStyleInterWithoutPadding(
                                    text: "123XXXXXXXX8",
                                    color: grayText2,
                                    fontWeight: FontWeight.w500,
                                    size: 13.00,
                                  ),
                                  SizedBox(height: 8),
                                  TextStyleInterWithoutPadding(
                                    text: "Joy Thomas",
                                    color: grayText2,
                                    fontWeight: FontWeight.w500,
                                    size: 13.00,
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: colorPrimary,
                                radius: 12,
                                child: const Icon(Icons.keyboard_arrow_down, color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                           Get.to(WithdrawalSuccess());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child:  TextStyleInterWithoutPadding(
                              text: '${Strings.withdraw} ₹${amountController.text}',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              size: 18.00,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        );
      },
    );
  }



  void showCreditDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "lib/Assets/Images/creditDetailsBottomSheetIcon.svg",
                      width: 45,
                      height: 45,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Wada Office",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: colorPrimary,
                      ),
                    ),
                    Text(
                      "₹37,800",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "24 Oct 2023",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  Strings.shiftDetails,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                NurseShiftItem(showLocationText: false,bookingType: "",),

              ],
            ),
          ),
        );
      },
    );
  }


  void showDebitDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "lib/Assets/Images/walletdebit.svg",
                      width: 45,
                      height: 45,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "David Thomas",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "-100",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Nurse Booking | 24 Oct 2023",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color:  Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Booking Details",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
          
              ],
            ),
          ),
        );
      },
    );
  }
}



