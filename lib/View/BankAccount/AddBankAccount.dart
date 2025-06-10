import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/BankAccount/BankAccountListing.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/SubmitButtonWidget.dart';
import 'package:waaada_nurseapp/Widget/TextFieldWidget.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({super.key});

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.addBankAccount, showCloseIcon: true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  AddBankAccountTextFieldWidget(
                    hintText: Strings.accountHolderName,
                  ),
                  SizedBox(height: 15),
                  AddBankAccountTextFieldWidget(hintText: Strings.bankName),
                  SizedBox(height: 15),
                  AddBankAccountTextFieldWidget(
                    hintText: Strings.accountNumber,
                  ),
                  SizedBox(height: 15),
                  AddBankAccountTextFieldWidget(
                    hintText: Strings.confirmAccountNumber,
                  ),
                  SizedBox(height: 15),
                  AddBankAccountTextFieldWidget(hintText: Strings.ifscCode),
                  SizedBox(height: 15),
                  AddBankAccountTextFieldWidget(hintText: Strings.branchName),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.33),
                  SubmitButtonWidget(text: Strings.save, onTap: () {
                    Get.to(BankAccountListing());
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
