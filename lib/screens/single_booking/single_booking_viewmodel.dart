import 'package:get/get.dart';

class SingleBookingViewModel extends GetxController {

  bool isScheduledBooking = true;

  Map<String, dynamic>? args;

  @override
  void onInit() {
    args = Get.arguments;
    if(args != null) {
      if(args!.containsKey('isScheduled')) {
        isScheduledBooking = args!['isScheduled'];
      } else {
        isScheduledBooking = false;
      }
    } else {
      isScheduledBooking = false;
    }
    super.onInit();
  }

}