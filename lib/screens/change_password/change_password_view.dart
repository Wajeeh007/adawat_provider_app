import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/password_visibility_icon.dart';
import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/screens/change_password/change_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

import '../../helpers/constants.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final ChangePasswordViewModel viewModel = Get.put<ChangePasswordViewModel>(ChangePasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.changePassword.tr,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - constraintSubtractValue,
                  minWidth: constraints.maxWidth
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      lang_key.createNewPassword.tr,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      lang_key.newPasswordDiff.tr,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Form(
                        key: viewModel.formKey,
                        child: Obx(() => Column(
                            children: [
                              CustomTextField(
                                controller: viewModel.newPassController,
                                validator: (value) {
                                  if(CommonFunctions.validateDefaultField(value) == null) {
                                    if(value!.length > 6) {
                                      return null;
                                    } else {
                                      return lang_key.passwordLength.tr;
                                    }
                                  } else {
                                    return CommonFunctions.validateDefaultField(value);
                                  }
                                },
                                title: lang_key.newPassword.tr,
                                obscureText: viewModel.newPassVisibility.value,
                                asterisk: true,
                                hintText: '******',
                                suffixIcon: PasswordVisibilityIcon(visibility: viewModel.newPassVisibility)
                              ),
                              CustomTextField(
                                controller: viewModel.confirmPassController,
                                validator: (value) {
                                  if(CommonFunctions.validateDefaultField(value) == null) {
                                    if(viewModel.newPassController.text == '') {
                                      return null;
                                    } else {
                                      if(viewModel.newPassController.text == value) {
                                        return null;
                                      }
                                      return lang_key.passwordNotMatching.tr;
                                    }
                                  } else {
                                    return CommonFunctions.validateDefaultField(value);
                                  }
                                },
                                title: lang_key.confirmPassword.tr,
                                asterisk: true,
                                obscureText: viewModel.confirmPassVisibility.value,
                                hintText: '******',
                                suffixIcon: PasswordVisibilityIcon(visibility: viewModel.confirmPassVisibility)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                            onTap: () {
                              if(viewModel.formKey.currentState!.validate()) {

                              }
                            },
                            text: lang_key.cont.tr
                        ),
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