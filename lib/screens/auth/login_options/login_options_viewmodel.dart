import 'package:get/get.dart';

class LoginOptionsViewModel extends GetxController {

  RxBool makeVisible = false.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 500), () {
      makeVisible.value = true;
    });
    super.onReady();
  }

  @override
  void onClose() {
    makeVisible.value = false;
    super.onClose();
  }
}