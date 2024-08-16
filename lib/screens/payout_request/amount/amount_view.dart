import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/stepper_text.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_row.dart';
import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/helpers/global_variables.dart';
import 'package:adawat_provider_app/screens/payout_request/payout_request_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class AmountView extends StatelessWidget {
  AmountView({super.key});

  final PayoutRequestViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.payoutRequest.tr,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - constraintSubtractValue,
                minWidth: constraints.maxWidth
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    StepperText(index: 1, texts: [lang_key.selectAccount.tr, lang_key.amount.tr]),
                    const AmountInWalletWidget(),
                    const SizedBox(height: 40,),
                    TitleAndTextRow(
                      title: lang_key.maxPayoutAmountColon.tr,
                      text: (GlobalVariables.amountInWallet.value - 100).toString(),
                    sizedBoxWidth: 0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    PayoutTextField(),
                    Obx(() => TitleAndTextRow(
                      title: lang_key.remainingAmountColon.tr,
                      text: viewModel.remainingAmount.string,
                      sizedBoxWidth: 0,
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                              onTap: () {
                                if(viewModel.formKey.currentState!.validate()) {

                                }
                              },
                            text: lang_key.request.tr,
                            height: 45,
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

/// Total amount in wallet text widget
class AmountInWalletWidget extends StatelessWidget {
  const AmountInWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
            text: TextSpan(
                text: GlobalVariables.amountInWallet.string,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 75
                ),
                children: [
                  TextSpan(
                      text: " ${lang_key.sar.tr}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400
                      )
                  )
                ]
            )
        ),
        Text(
          lang_key.amountInWallet.tr,
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    );
  }
}

/// Textfield for entering payout amount
class PayoutTextField extends StatelessWidget {
  PayoutTextField({super.key});

  final PayoutRequestViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: CustomTextField(
        textAlign: TextAlign.center,
        textStyle: Theme.of(context).textTheme.labelLarge,
        controller: viewModel.amountController,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.25, vertical: 15),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if(CommonFunctions.validateDefaultField(value) == null) {
            if(int.tryParse(value!)! > GlobalVariables.amountInWallet.value) {
              return lang_key.greaterThanTotal.tr;
            } else {
              if(int.tryParse(value)! > (GlobalVariables.amountInWallet.value - 100)) {
                return lang_key.greaterThanMaxPayout.tr;
              } else {
                return null;
              }
            }
          } else {
            return CommonFunctions.validateDefaultField(value);
          }
        },
        onChanged: (value) {
          viewModel.calculateRemainingAmount(value);
        },
      ),
    );
  }
}
