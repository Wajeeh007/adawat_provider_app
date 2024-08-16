import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/constants.dart';
import '../../../models/bank_account.dart';
import '../../../models/bottom_sheet_item_model.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class BankAccountsListingViewModel extends GetxController {

  /// Controller(s)
  TextEditingController searchController = TextEditingController();
  
  /// Bank Accounts List
  List<BankAccount> allAccountsList = <BankAccount>[
    BankAccount(
      accountHolderName: 'Syed Wajeeh Ahsan',
      bankName: 'Faysal Bank',
      accountNumber: 'PK00FAYB51353843135015',
      isDefault: true,
    ),
    BankAccount(
      accountHolderName: 'Syed Wajeeh Ahsan',
      bankName: 'Faysal Bank',
      accountNumber: 'PK00FAYB51353843135015',
      isDefault: false
    ),
    BankAccount(
      accountHolderName: 'Ahmad',
      bankName: 'Standard Charted',
      accountNumber: 'PK00SCB51353843135015',
        isDefault: false
    ),
    BankAccount(
      accountHolderName: 'Ali Khan',
      bankName: 'Bank Alfalah',
      accountNumber: 'PK00BALF51353843135015',
        isDefault: false
    )
  ];
  RxList<BankAccount> visibleAccountsList = <BankAccount>[].obs;

  /// Filter bottom sheet items list
  RxList<BottomSheetItemModel> bottomSheetItems = <BottomSheetItemModel>[
    BottomSheetItemModel(text: lang_key.bankName.tr, isSelected: false),
    BottomSheetItemModel(text: lang_key.accountTitle.tr, isSelected: false),
    BottomSheetItemModel(text: lang_key.accountIban.tr, isSelected: false),
  ].obs;

  /// Chosen filter variable
  RxString chosenFilter = ''.obs;

  /// Loading Variable
  RxBool showBankAccounts = false.obs;

  /// Guider Variable
  RxBool showGuider = true.obs;

  @override
  void onReady() {
    chosenFilter.value = bottomSheetItems.first.text!;
    bottomSheetItems.first.isSelected = true;
    Future.delayed(const Duration(seconds: 3), () => showBankAccounts.value = true);
    visibleAccountsList.addAll(allAccountsList);
    visibleAccountsList.refresh();
    for (var element in allAccountsList) {
      element.circleColor = colors[Random().nextInt(colors.length)];
    }
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    allAccountsList.clear();
    visibleAccountsList.clear();
    showBankAccounts.value = false;
    super.onClose();
  }

  void searchAccount(dynamic value) {
    visibleAccountsList.clear();
      for(var element in allAccountsList) {
        if(value.runtimeType == int) {
          if (element.accountNumber.toString().contains(value.toString())) {
            visibleAccountsList.add(element);
          }
        } else {
          if(element.accountHolderName!.toLowerCase().contains(value.toString().toLowerCase())) {
            visibleAccountsList.add(element);
          } else {
            if(element.bankName!.toLowerCase().contains(value.toString().toLowerCase())) {
              visibleAccountsList.add(element);
            }
          }
        }
    }
  }
}