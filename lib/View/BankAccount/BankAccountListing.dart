import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/WalletController.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/BankAccount/AddBankAccount.dart';
import 'package:waaada_nurseapp/Widget/BankAccountListingCard.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';

class BankAccountListing extends StatefulWidget {
  const BankAccountListing({super.key});

  @override
  State<BankAccountListing> createState() => _BankAccountListingState();
}

class _BankAccountListingState extends State<BankAccountListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.bankAccount,onTap: Get.back,),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GetBuilder(
            init: WalletController(),
            builder:(controller) =>  Column(
              children: [
                SizedBox(height: 15),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BankAccountListingCard(
                      bankName: "SBI Bank",
                      accountNumber: "123xxxxxxxx8",
                      accountHolder: "Joy Thomas",
                      onDelete:() {
                        controller.deleteBankAccountBottomSheet(context);
                      } ,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 0),
                  itemCount: 4,
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                    child: SubmitButtonWidget(text:Strings.addBankAccount,onTap: (){ Get.to(AddBankAccount());},)),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
