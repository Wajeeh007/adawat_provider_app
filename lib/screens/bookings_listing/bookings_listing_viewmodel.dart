import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsListingViewModel extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController tabController = TabController(length: 3, vsync: this);

  /// Variables for showing loaders
  RxBool showScheduledList = false.obs;
  RxBool showCompletedList = false.obs;
  RxBool showCancelledList = false.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 3), () {
      showScheduledList.value = true;
      showCompletedList.value = true;
      showCancelledList.value = true;
    });
    super.onReady();
  }

  @override
  void onClose() {
    resetVariables();
    super.onClose();
  }

  resetVariables() {
    showScheduledList.value = false;
    showCompletedList.value = false;
    showCancelledList.value = false;
  }
}