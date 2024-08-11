import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepperText extends StatelessWidget {
  const StepperText({
    super.key,
    required this.index,
    required this.texts
  }) :  assert(index <= texts.length - 1, 'Index cannot be greater than total number of texts');

  /// List should contain more than one string
  /// Keep the strings as small as possible
  final List<String> texts;

  /// Index range starts from 0 till texts.length - 1
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(texts.length, (index1) {
          if(index1 == texts.length - 1) {
            return Text(
              texts[index1],
              style: Theme.of(context).textTheme.labelMedium,
            );
          } else {
            return Row(
              children: [
                Text(
                  texts[index1],
                  style: index <= index1 ? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Get.isDarkMode ? primaryDullYellow : primaryYellow
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: index <= index1 ? DottedLine(
                    dashColor: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
                    dashLength: 2,
                    dashGapLength: 2,
                    lineLength: Get.width * 0.15,
                  ) : Icon(
                    Icons.check_circle_outline_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}