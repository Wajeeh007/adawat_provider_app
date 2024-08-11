import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:get/get_rx/get_rx.dart';

class ScreenOneViewModel extends GetxController {

  /// GlobalKey(s) & Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Obscure Password Variables
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  /// Checkbox variable
  RxBool checkBoxValue = false.obs;
  RxBool showError = false.obs;

  String? isPasswordMatching(String? value) {
    if(value != passwordController.text) {
      return lang_key.passwordNotMatching.tr;
    } else {
      return null;
    }
  }

  disposeVariables() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    obscurePassword.value = true;
    obscureConfirmPassword.value = true;
  }
}