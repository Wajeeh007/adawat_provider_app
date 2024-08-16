import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_network_image.dart';
import 'package:adawat_provider_app/custom_widgets/custom_radio_button.dart';
import 'package:adawat_provider_app/custom_widgets/no_data_found.dart';
import 'package:adawat_provider_app/screens/language/language_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart'  as lang_key;
import '../../custom_widgets/bottom_sheet_item.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../helpers/constants.dart';

final LanguageViewModel viewModel = Get.put<LanguageViewModel>(LanguageViewModel());

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.language.tr,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - constraintSubtractValue,
                    minWidth: constraints.maxWidth
                ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SearchField(),
                    Obx(() => viewModel.languagesList.isEmpty ? NoDataFound(
                        text: lang_key.noLanguageFound.tr
                    ) : Column(
                        children: List.generate(viewModel.languagesList.length, (index) {
                          return LanguageTile(item: viewModel.languagesList[index]);
                        }),
                      ),
                    ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Bottom sheet for choosing filter type
  static showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
        elevation: 8,
        Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: kBorderRadius,
              color: Theme.of(context).colorScheme.primaryContainer
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lang_key.searchBy.tr,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: errorRed,
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: darkThemeLightGrey,
              ),
              Obx(() => Column(
                children: List.generate(viewModel.bottomSheetItems.length, (int index) {
                  return BottomSheetItem(itemsList: viewModel.bottomSheetItems, index: index, chosenFilterValue: viewModel.chosenFilter,);
                }),
              ),
              ),
              CustomButton(onTap: () => Get.back(), text: lang_key.cont.tr,)
            ],
          ),
        )
    );
  }
}

/// Search and filter field at the top
class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Obx(() => Row(
          children: [
            Expanded(
              flex: 7,
              child: CustomTextField(
                keyboardType: viewModel.chosenFilter.value == lang_key.number.tr ? TextInputType.number : TextInputType.text,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                controller: viewModel.searchController,
                hintText: "${lang_key.searchLanguage.tr} ${lang_key.by.tr} ${viewModel.chosenFilter.value}",
                isSearchField: true,
                onChanged: (value) {
                  if(value == '' || value.isEmpty) {
                    viewModel.repopulateList();
                  } else {
                    viewModel.searchItem(value);
                  }
                },
              ),
            ),
            Expanded(
              child: CustomTextField(
                prefixIcon: const Icon(
                  Icons.filter_alt_outlined,
                  size: 18,
                ),
                readOnly: true,
                onTap: () => LanguageView.showFilterBottomSheet(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Language tile widget
class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key, required this.item});

  final MapEntry<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: kBorderRadius,
          boxShadow: Get.isDarkMode ? [] : kShadow
      ),
      child: Obx(() => ListTile(
          onTap: () => viewModel.languageController.setLanguage(key: item.key),
          leading: CountryFlag(
            countryCode: item.value['countryCode'],
          ),
          title: Text(
            item.value["name"],
            style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          trailing: CustomRadioButton(isSelected: viewModel.languageController.languageKey.value == item.key)),
      ),
    );
  }
}

/// Fetch country flag image and display it
class CountryFlag extends StatelessWidget {
  const CountryFlag({super.key, required this.countryCode});

  final String countryCode;

  @override
  Widget build(BuildContext context) {

      return CustomNetworkImage(
        height: 40,
        width: 40,
        boxShape: BoxShape.circle,
        imageUrl: "https://raw.githubusercontent.com/hampusborgos/country-flags/main/png1000px/${countryCode.toLowerCase()}.png",
        fit: BoxFit.cover,
      );
  }
}