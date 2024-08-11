import 'package:flutter/material.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../helpers/constants.dart';
import 'custom_button.dart';
import 'package:get/get.dart';

import 'custom_text_button.dart';
import 'custom_textfield.dart';

class StatusBasedWidget extends StatelessWidget {
  StatusBasedWidget({super.key, required this.type, this.starsOffColor});
  
  final ContainerType type;
  RxDouble starValue = 0.0.obs;
  TextEditingController textEditingController = TextEditingController();
  final Color? starsOffColor;
  
  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ContainerType.pending =>
          CustomButton(onTap: () {}, text: lang_key.cancel.tr, color: errorRed, textColor: backgroundWhite, height: 45,),
      ContainerType.completed =>
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => RatingStars(
                      starOffColor: starsOffColor ?? primaryBlack,
                      starColor: Get.isDarkMode ? primaryDullYellow : primaryYellow,
                      starSize: 17,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                      value: starValue.value,
                      onValueChanged: (value) => starValue.value = value,
                    ),
                    ),
                    CustomTextButton(onTap: () {}, text: lang_key.viewEReceipt.tr),
                  ],
                ),
              ),
              CustomTextField(
                controller: textEditingController,
                maxLines: 5,
                hintText: lang_key.addComments.tr,
              ),
              CustomButton(
                onTap: () {},
                text: lang_key.submit.tr,
                color: Get.isDarkMode ? primaryDullYellow : primaryYellow,
                height: 45,
                margin: const EdgeInsets.only(top: 10),
              )
            ],
          ),
      ContainerType.cancelled => const SizedBox()
    };
  }
}
