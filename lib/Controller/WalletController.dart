import 'package:get/get.dart';

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

}