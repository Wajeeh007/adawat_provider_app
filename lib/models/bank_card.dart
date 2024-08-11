class BankCard {

  String? networkName;
  String? cardHolderName;
  String? cardNumber;
  int? cardCvc;
  DateTime? expiryDate;
  bool? isDefault;

  BankCard({this.cardHolderName, this.cardNumber, this.cardCvc, this.expiryDate, this.networkName, this.isDefault});
}