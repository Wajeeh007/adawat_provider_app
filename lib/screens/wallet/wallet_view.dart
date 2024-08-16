import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:adawat_provider_app/screens/wallet/wallet_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:intl/intl.dart';
import '../../models/payout.dart';

class WalletView extends StatelessWidget {
  WalletView({super.key});

  final WalletViewModel viewModel = Get.put(WalletViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.wallet.tr,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed(AppRoutes.selectAccount),
          label: Text(
            lang_key.requestPayout.tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: primaryBlack
            ),
          ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AmountText(),
                Text(
                  lang_key.amountInWallet.tr,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Divider(height: 30,),
                Text(
                  lang_key.payoutsHistory.tr,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TabBarData(),
                Expanded(
                  child: TabBarView(
                    controller: viewModel.tabController,
                      children: [
                        TabBarChild(
                          payoutList: viewModel.completedPayoutList,
                          loaderBool: viewModel.showCompletedList,
                        ),
                        TabBarChild(
                          payoutList: viewModel.requestedPayoutList,
                          loaderBool: viewModel.showRequestedList,
                        )
                      ]
                  ),
                )
              ],
            ),
        ),
    );
  }
}

/// Wallet amount animated text
class AmountText extends StatelessWidget {
  AmountText({super.key});

  final WalletViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => RichText(
        text: TextSpan(
            text: viewModel.animatedWalletAmount.value.toString(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 75
            ),
            children: [
              TextSpan(
                  text: " ${lang_key.sar.tr}",
                  style: Theme.of(context).textTheme.bodySmall
              )
            ]
        ),
      ),
    );
  }
}

/// Tab bar header data
class TabBarData extends StatelessWidget {
  TabBarData({super.key});

  final WalletViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.only(top: 20),
        labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
        unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
        controller: viewModel.tabController,
        tabs: [
          Text(lang_key.completed.tr),
          Text(lang_key.requested.tr),
        ]
    );
  }
}

/// Payout list widget
class TabBarChild extends StatelessWidget {
  TabBarChild({super.key, required this.payoutList, required this.loaderBool});

  final RxList<Payout> payoutList;
  final RxBool loaderBool;

  final WalletViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => loaderBool.value ? ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        itemCount: payoutList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                )
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleAndValue(
                        title: lang_key.timeColon.tr,
                      text: DateFormat('dd/MM/yy hh:mm a').format(payoutList[index].payoutDateTime ?? payoutList[index].payoutRequestDateTime!),
                    ),
                    TitleAndValue(
                      title: lang_key.amountColon.tr,
                      text: payoutList[index].amount.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleAndValue(
                      title: lang_key.accountTitleColon.tr,
                      text: payoutList[index].accountTitle!,
                    ),
                    TitleAndValue(
                      title: lang_key.ibanColon.tr,
                      text: payoutList[index].accountIban!,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ) : const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

/// Payout detail title and text value
class TitleAndValue extends StatelessWidget {
  const TitleAndValue({super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        text: "$title: ",
        style: Theme.of(context).textTheme.labelMedium,
        children: [
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600
            )
          )
        ]
      ),
    );
  }
}