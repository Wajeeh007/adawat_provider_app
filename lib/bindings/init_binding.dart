import 'package:get/get.dart';
import '../language_controller.dart';
import '../screens/inbox/inbox_viewmodel.dart';
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
    //TODO: Add check if the user is logged in or not
    Get.put(NotificationsViewModel(), permanent: true);
    Get.put(InboxViewModel(), permanent: true);
  }

}