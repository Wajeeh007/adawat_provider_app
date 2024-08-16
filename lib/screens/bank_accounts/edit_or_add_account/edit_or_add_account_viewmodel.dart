import 'package:adawat_provider_app/models/bank_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditOrAddAccountViewModel extends GetxController {

  /// Global Keys & Controller(s)
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountIbanController = TextEditingController();
  TextEditingController accountTitleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Variables for arguments from previous screen
  Map<String, dynamic>? args;
  BankAccount accountDetails = BankAccount();

  @override
  void onInit() {
    args = Get.arguments;
    if(args != null) {
      accountDetails = args!['accountDetails'];
      setControllers();
    }
    super.onInit();
  }

  @override
  void onClose() {
    bankNameController.dispose();
    accountTitleController.dispose();
    accountIbanController.dispose();
    accountDetails = BankAccount();
    super.onClose();
  }

  setControllers() {
    bankNameController.text = accountDetails.bankName!;
    accountIbanController.text = accountDetails.accountNumber!;
    accountTitleController.text = accountDetails.accountHolderName!;
  }
}