import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonFunctions {

  /// Validate email entered in textfield
  static String? validateEmail(String? value) {
    if (GetUtils.isBlank(value)!) {
      return lang_key.fieldIsRequired.tr;
    } else if (!GetUtils.isEmail(value!)) {
      return lang_key.enterValidEmail.tr;
    } else {
      return null;
    }
  }

  /// Validate textfield if it is empty
  static String? validateDefaultField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return lang_key.fieldIsRequired.tr;
    } else {
      return null;
    }
  }

  /// Show error toast in case an error occurs
  static showErrorToast({
    required BuildContext context,
    required String desc,
    double? height,
}) {
    CherryToast.error(
      height: height,
      displayCloseButton: false,
      description: Text(
        desc,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      toastDuration: const Duration(milliseconds: 2300),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Theme.of(context).shadowColor,
      toastPosition: Position.bottom,
      animationType: AnimationType.fromBottom,
    ).show(context);
  }

  /// Get time difference and convert it into hours, minutes or days
  String getTimeDifference(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if(difference.inHours > 0 && difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if(difference.inDays < 1 && difference.inHours < 1){
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  /// Repopulate contents of observable list from actual data list
  static repopulateList(List<dynamic> contentList, RxList<dynamic> listToPopulate) {
    listToPopulate.clear();
    listToPopulate.addAll(contentList);
    listToPopulate.refresh();
  }
}