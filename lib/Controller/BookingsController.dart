import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class BookingsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("BookingsController initialized");
  }

  @override
  void onClose() {
    print("BookingsController disposed");
    super.onClose();
  }

}