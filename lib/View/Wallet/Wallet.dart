import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/WalletController.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/BankAccount/AddBankAccount.dart';
import 'package:waaada_nurseapp/Widget/BankAccountWidget.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';
import 'package:waaada_nurseapp/Widget/TransactionTile.dart';
import 'package:waaada_nurseapp/Widget/WithDrawalWidget.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(label: Strings.wallet, showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GetBuilder(
                init: WalletController(),
                builder:
                    (controller) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Get.to(AddBankAccount());
                          },
                          child: BankAccountsWidget(),
                        ),
                        SizedBox(height: 10),
                        WithDrawalWidget(
                          balance: "1,500",
                          nextWithdrawalDate: "01 May 2025",
                          minWithdrawalAmount: "1,500",
                          onWithdrawPressed: () {},
                        ),
                        SizedBox(height: 20),
                        TextStyleInterWithoutPadding(
                          text: Strings.transactions,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          size: 16.00,
                        ),
                        SizedBox(height: 10),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return TransactionTile(
                              date: controller.transactions[index]['date'],
                              title: controller.transactions[index]['title'],
                              status: controller.transactions[index]['status'],
                              amount: controller.transactions[index]['amount'],
                              isCredited:
                                  controller.transactions[index]['isCredited'],
                            );
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(height: 10),
                          itemCount: controller.transactions.length,
                        ),
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
