import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../helpers/common_functions.dart';
import '../../helpers/constants.dart';
import 'change_phone_number_viewmodel.dart';

class ChangePhoneNumberView extends StatelessWidget {
  ChangePhoneNumberView({super.key});

  final ChangePhoneNumberViewModel viewModel = Get.put<ChangePhoneNumberViewModel>(ChangePhoneNumberViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.changePhoneNumber.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              lang_key.addNewNum.tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8,),
            Text(
              lang_key.enterNewNum.tr,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Form(
              key: viewModel.formKey,
              child: PhoneNoTextField(),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                    onTap: () {
                      if(viewModel.formKey.currentState!.validate()) {
                        showCautionDialog(context);
                      }
                    },
                  text: lang_key.cont.tr,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showCautionDialog(BuildContext context) {
    return showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            iconPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            icon: Column(
              children: [
                const Image(image: Svg('assets/svg_vectors/change_phone_number_caution.svg',)),
                const SizedBox(height: 15,),
                Text(
                  lang_key.changeNumCaution.tr,
                  style: Theme.of(context).textTheme.labelMedium,
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
        });
  }
}

/// Textfield for phone number. Contains two fields but one is set to be onlyRead because it is for country code
class PhoneNoTextField extends StatelessWidget {
  PhoneNoTextField({super.key});

  final ChangePhoneNumberViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(kContainerRadius),
                        border: Border.all(
                            color: Get.isDarkMode ? darkThemeLightGrey : lightThemeBorderGrey,
                            width: 1.2
                        )
                    ),
                    child: Text(
                      '+966',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '-',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Expanded(
                flex: 7,
                child: CustomTextField(
                  keyboardType: TextInputType.number,
                  controller: viewModel.phoneController,
                  autoValidateMode: AutovalidateMode.disabled,
                  hintText: '1234567',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if(CommonFunctions.validateDefaultField(value) == null) {
                      if(value!.length < 10) {
                        return lang_key.enterValidPhoneNo.tr;
                      } else {
                        return null;
                      }
                    } else {
                      return CommonFunctions.validateDefaultField(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}