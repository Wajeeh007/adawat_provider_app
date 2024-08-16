import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalDetailsViewModel extends GetxController {

  /// Controllers and Global Key
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController iqamaController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    iqamaController.dispose();
  }
}