import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends GetxController {

  /// Selected Date variable
  RxString selectedDateString = ''.obs;
  DateTime selectedDateTime = DateTime.now();

  /// Variables for showing shimmers
  RxBool showBookingsData = false.obs;
  RxBool showEarningGraph = false.obs;
  RxBool showNextBooking = false.obs;
  RxBool showTotalAmounts = false.obs;

  @override
  void onReady() {
    selectedDateString.value = 'Today';
    Future.delayed(const Duration(milliseconds: 1500), () {
      showBookingsData.value = true;
      showNextBooking.value = true;
      showEarningGraph.value = true;
      showTotalAmounts.value = true;
    });
    super.onReady();
  }
  
  void switchDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
      initialDate: selectedDateTime
    );

    if(date != null) {
      if(date == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        selectedDateTime = DateTime.now();
        selectedDateString.value = 'Today';
      } else {
        selectedDateTime = date;
        selectedDateString.value = DateFormat('dd MMM yyyy').format(date);
      }
    }
  }
  
}