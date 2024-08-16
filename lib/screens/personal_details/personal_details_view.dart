import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/image_avatar.dart';
import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/screens/personal_details/personal_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class PersonalDetailsView extends StatelessWidget {
  PersonalDetailsView({super.key});

  final PersonalDetailsViewModel viewModel = Get.put<PersonalDetailsViewModel>(PersonalDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.personalDetails.tr,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight - constraintSubtractValue
              ),
              child: IntrinsicHeight(
                child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditImage(),
                        Form(
                          key: viewModel.formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                asterisk: true,
                                title: lang_key.fullName.tr,
                                controller: viewModel.nameController,
                                validator: (value) => CommonFunctions.validateDefaultField(value),
                                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9@!~`$%^&*(){}=+;><?\/]'))],
                              ),
                              CustomTextField(
                                keyboardType: TextInputType.emailAddress,
                                asterisk: true,
                                title: lang_key.email.tr,
                                controller: viewModel.emailController,
                                validator: (value) => CommonFunctions.validateEmail(value),
                              ),
                              CustomTextField(
                                title: lang_key.iqamaNo.tr,
                                asterisk: true,
                                controller: viewModel.iqamaController,
                                validator: (value) {
                                  if(CommonFunctions.validateDefaultField(value) == null) {
                                    if(value!.length < 8) {
                                      return lang_key.invalidIqamaNo.tr;
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return CommonFunctions.validateDefaultField(value);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              )
                            ],
                          ),
                        ),
                        BottomButtons()
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
}

/// Image and edit icon widgets
class EditImage extends StatelessWidget {
  EditImage({super.key});

  final PersonalDetailsViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ImageAvatar(heightAndWidth: 70,),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: const CircleAvatar(
              backgroundColor: darkThemeLightGrey,
              radius: 13,
              child: Icon(
                Icons.edit_outlined,
                size: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}

/// Buttons at the bottom of screen
class BottomButtons extends StatelessWidget {
  BottomButtons({super.key});

  final PersonalDetailsViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  onTap: () {},
                  text: lang_key.saveAndUpdate.tr
              ),
              CustomButton(
                onTap: () => Get.back(),
                text: lang_key.discard.tr,
                color: Colors.transparent,
                borderStyle: Border.all(
                    color: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
                    width: 0.5
                ),
                textColor: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
              )
            ],
          ),
        ),
      ),
    );
  }
}
