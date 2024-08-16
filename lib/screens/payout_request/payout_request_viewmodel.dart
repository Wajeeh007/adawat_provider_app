import 'dart:math';
import 'package:adawat_provider_app/helpers/global_variables.dart';
import 'package:adawat_provider_app/screens/payout_request/bank_account_extended_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helpers/constants.dart';
import '../../models/bank_account.dart';

class PayoutRequestViewModel extends GetxController {

  /// Controller(s) & Global Key
  TextEditingController amountController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Bank Accounts List
  RxList<BankAccountExtendedModel> accountsList = <BankAccountExtendedModel>[
    BankAccountExtendedModel(
      bankAccount: BankAccount(
        accountHolderName: 'Syed Wajeeh Ahsan',
        bankName: 'Faysal Bank',
        accountNumber: 'PK00FAYB51353843135015',
        isDefault: true,
      ),
      isSelected: true,
    ),
    BankAccountExtendedModel(
      bankAccount: BankAccount(
          accountHolderName: 'Syed Wajeeh Ahsan',
          bankName: 'Faysal Bank',
          accountNumber: 'PK00FAYB51353843135015',
          isDefault: false
      ),
      isSelected: false,
    ),
    BankAccountExtendedModel(
      bankAccount: BankAccount(
        accountHolderName: 'Ahmad',
        bankName: 'Standard Charted',
        accountNumber: 'PK00SCB51353843135015',
        isDefault: false
    ),
      isSelected: false,
    ),
    BankAccountExtendedModel(
      bankAccount: BankAccount(
        accountHolderName: 'Ali Khan',
        bankName: 'Bank Alfalah',
        accountNumber: 'PK00BALF51353843135015',
        isDefault: false
        ),
    isSelected: false,
    )
  ].obs;
  
  /// Selected Bank Account details
  BankAccount selectedAccount = BankAccount();

  /// Remaining Amount variable
  RxInt remainingAmount = 0.obs;

  @override
  void onReady() {
    remainingAmount.value = GlobalVariables.amountInWallet.value;
    for (var element in accountsList) {
      element.bankAccount!.circleColor = colors[Random().nextInt(colors.length)];
    }
    accountsList.refresh();
    super.onReady();
  }

  @override
  void onClose() {
    amountController.dispose();
    accountsList.clear();
    super.onClose();
  }

  calculateRemainingAmount(String value) {
    if(value.isEmpty || value == '') {
      remainingAmount.value = GlobalVariables.amountInWallet.value;
    } else if(int.tryParse(value)! > GlobalVariables.amountInWallet.value){
      remainingAmount.value = GlobalVariables.amountInWallet.value;
    } else if(int.tryParse(value)! > (GlobalVariables.amountInWallet.value - 100)) {
      remainingAmount.value = GlobalVariables.amountInWallet.value;
    } else {
      remainingAmount.value = GlobalVariables.amountInWallet.value - int.tryParse(value)!;
    }
  }
}