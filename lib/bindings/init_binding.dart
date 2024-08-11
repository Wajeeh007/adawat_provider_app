import 'package:get/get.dart';
import '../language_controller.dart';
import '../screens/notifications/notifications_viewmodel.dart';

LanguageController get initLanguageController {

  try {
    return Get.find();
  } catch (e) {
    Get.put(LanguageController(), permanent: true);
    return Get.find();
  }

}

class InitBinding extends Bindings {

  @override
  void dependencies() {
    // Get.put(CartViewModel(), permanent: true);
    Get.put(NotificationsViewModel(), permanent: true);
    // Get.put(InboxViewModel());
  }

}