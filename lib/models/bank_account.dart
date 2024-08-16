import 'dart:ui';

class BankAccount {
  
  String? accountHolderName;
  String? accountNumber;
  String? bankName;
  bool? isDefault;
  Color? circleColor;

  BankAccount({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.isDefault,
    this.circleColor
  });
}