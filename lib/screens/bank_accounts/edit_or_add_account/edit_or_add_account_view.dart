import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/screens/bank_accounts/edit_or_add_account/edit_or_add_account_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class EditOrAddAccountView extends StatelessWidget {
  EditOrAddAccountView({super.key});

  final EditOrAddAccountViewModel viewModel = Get.put(EditOrAddAccountViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: viewModel.args == null ? lang_key.addAccount.tr : lang_key.editAccount.tr,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight - constraintSubtractValue),
              child: IntrinsicHeight(
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: viewModel.bankNameController,
                        title: lang_key.bankName.tr,
                        asterisk: true,
                        hintText: 'Al Riyadh Bank',
                        validator: (value) => CommonFunctions.validateDefaultField(value),
                      ),
                      CustomTextField(
                        controller: viewModel.accountTitleController,
                        title: lang_key.accountTitle.tr,
                        asterisk: true,
                        hintText: 'John Doe',
                        validator: (value) => CommonFunctions.validateDefaultField(value),
                      ),
                      CustomTextField(
                        controller: viewModel.accountIbanController,
                        title: lang_key.accountIban.tr,
                        asterisk: true,
                        hintText: 'SA01RYB515616813',
                        validator: (value) {
                          if(CommonFunctions.validateDefaultField(value) == null) {
                            if(value!.length < 12) {
                              return lang_key.ibanLength.tr;
                            } else {
                              return null;
                            }
                          } else {
                            return CommonFunctions.validateDefaultField(value);
                          }
                        },
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              onTap: () {
                                if(viewModel.formKey.currentState!.validate()) {
                                  
                                }
                              },
                              text: lang_key.confirm.tr,
                            ),
                            if(viewModel.args != null) CustomButton(
                                onTap: () => showCautionDialog(context),
                              text: lang_key.deleteAccount.tr,
                              color: errorRed,
                              textColor: backgroundWhite,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  /// Caution dialog for bank account delete confirmation
  showCautionDialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            iconPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            icon: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/delete_details.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    lang_key.deleteAccountCaution.tr,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        onTap: (){},
                        text: lang_key.yes.tr
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: CustomButton(
                      onTap: () => Get.back(),
                      text: lang_key.no.tr,
                      color: Colors.transparent,
                      borderStyle: Border.all(
                          color: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
                          width: 0.5
                      ),
                      textColor: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
                    ),
                  ),
                ],
              )
            ],
          );
        }
    );
  }
}