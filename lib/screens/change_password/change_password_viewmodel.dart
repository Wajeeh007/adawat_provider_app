import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordViewModel extends GetxController {

  /// Global Key and Controllers
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Variables for obscuring text and changing textfields icons
  RxBool newPassVisibility = true.obs;
  RxBool confirmPassVisibility = true.obs;

  /// Variables for caution dialog
  RxBool dialogVisibility = false.obs;
  RxBool childrenVisibility = false.obs;
  RxDouble containerWidth = 15.0.obs;
  RxDouble containerHeight = 15.0.obs;

  @override
  void onClose() {
    disposeVariables();
    super.onClose();
  }

  /// Reset caution dialog variables
  closeDialog() {
    dialogVisibility.value = false;
    containerWidth.value = 15;
    containerHeight.value = 15;
    childrenVisibility.value = false;
  }

  /// Dispose and release memory once screen closes
  disposeVariables() {
    dialogVisibility.value = false;
    containerWidth.value = 15;
    containerHeight.value = 15;
    childrenVisibility.value = false;
    newPassVisibility.value = true;
    confirmPassVisibility.value = true;
    newPassController.dispose();
    confirmPassController.dispose();
  }
}