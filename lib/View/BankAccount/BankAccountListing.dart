import 'package:flutter/material.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
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
      appBar: CustomAppBar(label: Strings.bankAccount),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BankAccountListingCard(
                    bankName: "SBI Bank",
                    accountNumber: "123xxxxxxxx8",
                    accountHolder: "Joy Thomas",
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: 1,
              ),
              Spacer(),
              SubmitButtonWidget(text:Strings.addBankAccount,),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
