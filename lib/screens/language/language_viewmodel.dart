import 'package:adawat_provider_app/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../models/bottom_sheet_item_model.dart';

class LanguageViewModel extends GetxController {

  /// Controller(s)
  TextEditingController searchController = TextEditingController();
  LanguageController languageController = Get.find();

  RxList<MapEntry<String, dynamic>> languagesList = <MapEntry<String, dynamic>>[].obs;

  /// Filter bottom sheet items to display
  RxList<BottomSheetItemModel> bottomSheetItems = <BottomSheetItemModel>[
    BottomSheetItemModel(text: lang_key.name.tr, isSelected: true),
    BottomSheetItemModel(text: lang_key.languageCode.tr, isSelected: false),
  ].obs;

  /// Filter value to show on search field
  RxString chosenFilter = ''.obs;

  @override
  void onReady() {
    chosenFilter.value = bottomSheetItems.first.text!;
    languagesList.addAll(languageController.optionsLocales.entries);
    languagesList.refresh();
    super.onReady();
  }

  @override
  void onClose() {
    disposeVariables();
    super.onClose();
  }

  disposeVariables() {
    searchController.clear();
    chosenFilter.value = '';
    for (var element in bottomSheetItems) {
      element.isSelected = false;
    }
    bottomSheetItems.first.isSelected = true;
  }

  /// Search language by language's english name or by language code
  searchItem(String value) {
    languagesList.clear();
    for(var element in languageController.optionsLocales.entries) {
      if(chosenFilter.value == lang_key.name.tr) {
        if(element.value['englishName'].toString().toLowerCase().contains(value.toLowerCase())) {
          languagesList.add(element);
          languagesList.refresh();
        }
      } else {
        if(element.value['languageCode'].toString().toLowerCase().contains(value.toLowerCase())) {
          languagesList.add(element);
          languagesList.refresh();
        }
      }
    }
  }

  /// Repopulate list when no text is in textfield
  repopulateList() {
    languagesList.clear();
    languagesList.addAll(languageController.optionsLocales.entries);
    languagesList.refresh();
  }
}