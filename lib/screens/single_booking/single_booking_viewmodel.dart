import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:get/get.dart';

class SingleBookingViewModel extends GetxController {

  ContainerType? bookingType;
  Map<String, dynamic>? args;

  @override
  void onInit() {
    args = Get.arguments;
    if(args != null) {
      if(args!.containsKey('bookingType')) {
        bookingType = args!['bookingType'];
      } else {
        bookingType = ContainerType.pending;
      }
    } else {
      bookingType = ContainerType.pending;
    }
    super.onInit();
  }

}