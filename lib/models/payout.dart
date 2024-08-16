class Payout {

  DateTime? payoutDateTime;
  int? amount;
  String? accountTitle;
  String? accountIban;
  DateTime? payoutRequestDateTime;
  String? bankName;

  Payout({this.accountTitle, this.accountIban, this.amount, this.payoutDateTime, this.payoutRequestDateTime, this.bankName});
}