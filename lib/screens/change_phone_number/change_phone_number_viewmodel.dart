import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePhoneNumberViewModel extends GetxController {

  /// Global Key and Controller
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}