import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waaada_nurseapp/Controller/WalletController.dart';
import 'package:waaada_nurseapp/Resource/Strings.dart';
import 'package:waaada_nurseapp/View/BankAccount/AddBankAccount.dart';
import 'package:waaada_nurseapp/View/BankAccount/BankAccountListing.dart';
import 'package:waaada_nurseapp/Widget/BankAccountWidget.dart';
import 'package:waaada_nurseapp/Widget/CustomAppBar.dart';
import 'package:waaada_nurseapp/Widget/TextStyleInterWithoutPadding.dart';
import 'package:waaada_nurseapp/Widget/TransactionTile.dart';
import 'package:waaada_nurseapp/Widget/WithDrawalWidget.dart';
import 'package:waaada_nurseapp/Resource/Colors.dart';
import 'package:waaada_nurseapp/View/Home/Home.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: colorPrimary, width: 2.0),
          ),
          title: Row(
            children: [
              const Icon(Icons.info_outline, color: colorPrimary, size: 28),
              const SizedBox(width: 10),
              const Text(
                "Coming Soon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: const Text(
            "This feature is coming soon.",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: colorPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        label: Strings.wallet,
        showBackButton: true,
        onTap: () {
          Get.offAll(Home());
        },
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _showComingSoonDialog(context);
          },
          child: AbsorbPointer(
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
                                Get.to(BankAccountListing());
                              },
                              child: BankAccountsWidget(),
                            ),
                            SizedBox(height: 10),
                            WithDrawalWidget(
                              balance: "0",
                              nextWithdrawalDate: "",
                              minWithdrawalAmount: "1,500",
                              onWithdrawPressed: () {
                                controller.showWithdrawBottomSheet(context);
                              },
                            ),
                            if (controller.transactions.isNotEmpty) ...[
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
                                    date:
                                        controller.transactions[index]['date'],
                                    title:
                                        controller.transactions[index]['title'],
                                    status:
                                        controller
                                            .transactions[index]['status'],
                                    amount:
                                        controller
                                            .transactions[index]['amount'],
                                    isCredited:
                                        controller
                                            .transactions[index]['isCredited'],
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 10),
                                itemCount: controller.transactions.length,
                              ),
                            ],
                          ],
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
