import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/stepper_text.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:adawat_provider_app/screens/payout_request/bank_account_extended_model.dart';
import 'package:adawat_provider_app/screens/payout_request/payout_request_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

import '../../../helpers/constants.dart';

class SelectAccountView extends StatelessWidget {
  SelectAccountView({super.key});

  final PayoutRequestViewModel viewModel = Get.put(PayoutRequestViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.payoutRequest.tr,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - constraintSubtractValue,
                minWidth: constraints.maxWidth
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StepperText(index: 0, texts: [lang_key.selectAccount.tr, lang_key.amount.tr]),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 8.0, left: 15),
                    //   child: Text(
                    //     lang_key.selectBankAccount.tr,
                    //     style: Theme.of(context).textTheme.labelLarge,
                    //   ),
                    // ),
                    Obx(() => Column(
                      children: List.generate(
                          viewModel.accountsList.length,
                              (index) {
                            return SelectBankAccount(accountDetails: viewModel.accountsList[index]);
                          }),
                    ),
                    ),
                    AddAccountButton(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                              onTap: () => Get.toNamed(
                                  AppRoutes.amount,
                                  arguments: {'bankAccount': viewModel.selectedAccount}
                              ),
                            text: lang_key.proceed.tr,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

/// Select Account list widget
class SelectBankAccount extends StatelessWidget {
  SelectBankAccount({super.key, required this.accountDetails});

  final BankAccountExtendedModel accountDetails;

  final PayoutRequestViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {

    final strings = accountDetails.bankAccount!.bankName!.split(' ');
    String text = '';
    for(var element in strings) {
      text = text + element[0];
    }

    return Container(
      color: accountDetails.isSelected! ? Theme.of(context).colorScheme.onPrimaryFixedVariant : Colors.transparent,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          for (var element in viewModel.accountsList) {
            element.isSelected = false;
          }
          accountDetails.isSelected = true;
          viewModel.accountsList.refresh();
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 70,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accountDetails.bankAccount!.circleColor,
                ),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: primaryBlack
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          accountDetails.bankAccount!.bankName!,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      if(accountDetails.bankAccount!.isDefault!) Text(
                        lang_key.defaultAccount.tr,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountDetails.bankAccount!.accountHolderName!,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          accountDetails.bankAccount!.accountNumber!,
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddAccountButton extends StatelessWidget {
  AddAccountButton({super.key});

  final PayoutRequestViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return viewModel.accountsList.length < 5 ? Column(
      children: [
        IconButton(onPressed: () => Get.toNamed(AppRoutes.editOrAddAccount), icon: const Icon(
          CupertinoIcons.add_circled,
          size: 40,
        )),
        Text(
          lang_key.addAccount.tr,
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    ) : const SizedBox();
  }
}