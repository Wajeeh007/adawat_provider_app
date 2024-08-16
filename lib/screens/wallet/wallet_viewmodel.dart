import 'package:adawat_provider_app/models/payout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletViewModel extends GetxController with GetTickerProviderStateMixin {

  /// Animation variables and controller
  late AnimationController animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1300));
  late Animation<double> animationValue = CurvedAnimation(parent: animationController, curve: Curves.easeOutQuad);
  late TabController tabController = TabController(length: 2, vsync: this);

  /// Completed Payout List
  RxList<Payout> completedPayoutList = <Payout>[
    Payout(
      accountTitle: 'Syed Wajeeh Ahsan',
      accountIban: 'PK00FAYB129741294081',
      amount: 20,
      payoutDateTime: DateTime.now().subtract(const Duration(days: 1)),
      bankName: 'Faysal Bank',
    ),
    Payout(
      accountTitle: 'Syed Wajeeh Ahsan',
      accountIban: 'PK00FAYB129741294081',
      amount: 20,
      payoutDateTime: DateTime.now().subtract(const Duration(days: 5)),
      bankName: 'Bank Alfalah',
    ),
    Payout(
      accountTitle: 'Syed Wajeeh Ahsan',
      accountIban: 'PK00FAYB129741294081',
      amount: 20,
      payoutDateTime: DateTime.now().subtract(const Duration(days: 30)),
      bankName: 'Faysal Bank',
    )
  ].obs;

  /// Requested Payout List
  RxList<Payout> requestedPayoutList = <Payout>[
    Payout(
      accountTitle: 'Syed Wajeeh Ahsan',
      accountIban: 'PK00FAYB129741294081',
      amount: 20,
      payoutDateTime: DateTime.now(),
      bankName: 'Samba Bank',
    ),
    Payout(
      accountTitle: 'Syed Wajeeh Ahsan',
      accountIban: 'PK00FAYB129741294081',
      amount: 20,
      payoutDateTime: DateTime.now().subtract(const Duration(minutes: 70)),
    ),
    Payout(
      accountTitle: 'Syed Wajeeh Ahsan',
      accountIban: 'PK00FAYB129741294081',
      amount: 20,
      payoutDateTime: DateTime.now().subtract(const Duration(hours: 20)),
      bankName: 'Al Riyadh Bank',
    ),
  ].obs;

  /// Arguments variable
  Map<String, dynamic>? args;

  /// Wallet Actual amount
  int walletAmount = 0;

  /// Wallet animated value
  RxInt animatedWalletAmount = 0.obs;

  /// Loading Variables
  RxBool showCompletedList = false.obs;
  RxBool showRequestedList = false.obs;
  
  @override
  void onInit() {
    args = Get.arguments;
    if(args != null) {
      if(args!.containsKey('walletAmount')) {
        walletAmount = args!['walletAmount'].toInt();
      }
    }
    super.onInit();
  }
  
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2), () {
      showRequestedList.value = true;
      showCompletedList.value = true;
    });
    animationController.forward();
    animationController.addListener(() {
      animatedWalletAmount.value = (walletAmount * animationValue.value).toInt();
      if(animationController.isCompleted) {
        animationController.dispose();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}