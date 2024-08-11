import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginViewModel extends GetxController {

  /// Global Key(s) & Controllers
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// General Variables
  RxBool obscurePassword = true.obs;

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    obscurePassword.value = true;
  }

}