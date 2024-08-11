import 'package:adawat_provider_app/custom_widgets/custom_radio_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/bottom_sheet_item_model.dart';

/// Individual item in bottom sheet
class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    super.key,
    required this.itemsList,
    required this.index,
    required this.chosenFilterValue
  });

  final int index;
  final RxList<BottomSheetItemModel> itemsList;
  final RxString chosenFilterValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(!itemsList[index].isSelected!) {
          for (var element in itemsList) {
            element.isSelected = false;
          }
          itemsList[index].isSelected = true;
          itemsList.refresh();
          chosenFilterValue.value = itemsList[index].text!;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            itemsList[index].text!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          CustomRadioButton(isSelected: itemsList[index].isSelected!),
        ],
      ),
    );
  }
}