import 'package:adawat_provider_app/custom_widgets/price_text.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_column.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../helpers/constants.dart';
import '../models/service_category.dart';
import '../models/service_model.dart';
import '../screens/add_service/service_model_extended.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class ServiceCategoryAndServices extends StatelessWidget {
  const ServiceCategoryAndServices({
    super.key,
    required this.item,
    required this.showSubServices,
    this.mySubServicesList,
    this.toAdd,
    this.toAddServiceList
  }) : assert(mySubServicesList != null || toAddServiceList != null, 'Must provide either of the two lists'),
        assert(mySubServicesList == null || toAddServiceList == null, 'Cannot provide both lists.\nRemove one to resolve error'),
        assert(mySubServicesList == null || toAdd == null, 'Must provide toAdd property with toAddServiceList property'),
        assert((mySubServicesList == null && toAddServiceList != null && toAdd != null) || (mySubServicesList != null && toAddServiceList == null && toAdd == null), 'Must provide both toAddServiceList and toAdd property');

  final ServiceCategory item;
  final RxBool showSubServices;
  final RxList<ServiceModel>? mySubServicesList;
  final RxList<ServiceModelExtended>? toAddServiceList;
  final bool? toAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CategoryItemWithImage(
          item: item,
          onTap: () =>
              subServicesBottomSheet(
                  context: context,
                  categoryName: item.name!
              ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: kBorderRadius,
          ),
          height: 22,
          width: Get.width * 0.25,
          child: RichText(
            text: TextSpan(
                text: "${lang_key.services.tr}: ",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600
                ),
                children: [
                  TextSpan(
                      text: item.numberOfServices == null ? '1' : item.numberOfServices.toString(),
                      style: Theme.of(context).textTheme.labelSmall
                  )
                ]
            ),
          ),
        )
      ],
    );
  }

  /// Bottom Sheet for listing sub-services
  Future subServicesBottomSheet({required BuildContext context, required String categoryName}) {
    if (showSubServices.isFalse) {
      Future.delayed(const Duration(seconds: 3), () => showSubServices.value = true);
    } else {
      showSubServices.value = false;
      Future.delayed(const Duration(seconds: 3), () => showSubServices.value = true);
    }

    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 5, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                            lang_key.selectedServices.tr,
                            style: Theme.of(context).textTheme.labelMedium
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                        showSubServices.value = false;
                      },
                      icon: const Icon(Icons.close, color: errorRed,),
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
              ),
              const Divider(height: 10,),
              Obx(() =>
              showSubServices.value ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                    children: List.generate(
                        mySubServicesList == null ? toAddServiceList!.length : mySubServicesList!.length,
                            (index) {
                          final myServiceItem = mySubServicesList == null ? null : mySubServicesList![index];
                          final toAddServiceItem = toAddServiceList == null ? null : toAddServiceList![index];

                          return SubServiceBottomSheetItem(
                            myServiceItem: myServiceItem,
                            toBeAddedServiceItem: toAddServiceItem,
                            isFinal: mySubServicesList == null ? index == toAddServiceList!.length - 1 : index == mySubServicesList!.length - 1,
                            isAdded: toAddServiceItem?.isAdded,
                            onPressed: myServiceItem == null ? toAddServiceItem!.isAdded! ? () {} : () => print('Added') : () => print('Deleted'),
                          );
                        })
                ),
              ) : const SizedBox(
                height: 150,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              )
            ],
          );
        }
    );
  }
}

/// Category / Service item widget
class CategoryItemWithImage extends StatelessWidget {
  const CategoryItemWithImage({super.key, required this.item, this.onTap});

  final ServiceCategory item;
  final VoidCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.transparent,
                      width: 1.2
                  ),
                  borderRadius: kBorderRadius,
                  color: Colors.transparent,
                ),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: kBorderRadius,
                    child: Image.asset(
                      'assets/images/category_example_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 65,
                child: Text(
                  item.name!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sub-service item widget for bottom sheet
class SubServiceBottomSheetItem extends StatelessWidget {
  const SubServiceBottomSheetItem({
    super.key,
    this.myServiceItem,
    this.toBeAddedServiceItem,
    required this.isFinal,
    this.isAdded,
    this.onPressed,
  });

  final ServiceModel? myServiceItem;
  final ServiceModelExtended? toBeAddedServiceItem;
  final bool isFinal;
  final bool? isAdded;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: kBorderRadius,
                  child: Image.asset(
                    'assets/images/example_image.jpg',
                    fit: BoxFit.fill,
                    height: 60,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        myServiceItem != null ? myServiceItem!.categoryName! : toBeAddedServiceItem!.serviceModel!.categoryName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall
                    ),
                    TitleAndTextRow(
                      title: "${lang_key.duration.tr}:",
                      text: "${myServiceItem != null ? myServiceItem!.duration : toBeAddedServiceItem!.serviceModel!.categoryName} ${lang_key.hourOrHours.tr}",
                      mainAxisAlignment: MainAxisAlignment.start,
                      textStyle: Theme.of(context).textTheme.labelSmall,
                      rowPadding: EdgeInsets.zero,
                    )
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  alignment: Alignment.topRight,
                  onPressed: onPressed,
                  icon: Icon(
                    isAdded == null ? Icons.delete_outline_rounded : isAdded! ? CupertinoIcons.checkmark_circle : CupertinoIcons.add,
                    color: isAdded == null ? errorRed : isAdded! ? Colors.green : Theme.of(context).iconTheme.color,
                    size: 25,
                  ),
                  padding: EdgeInsets.zero,
                ),
              )
            ],
          ),
        ),
        PriceAndMeasuringUnitText(
          price: myServiceItem != null ? myServiceItem!.price! : toBeAddedServiceItem!.serviceModel!.price!,
          measuringUnit: myServiceItem != null ? myServiceItem!.measuringUnit! : toBeAddedServiceItem!.serviceModel!.measuringUnit!,
        ),
        if(!isFinal) const Divider(
          height: 25,
        ),
      ],
    );
  }
}

/// Price and Measuring Unit Widget for bottom sheet sub-service item
class PriceAndMeasuringUnitText extends StatelessWidget {
  const PriceAndMeasuringUnitText({super.key, required this.price, required this.measuringUnit});

  final double price;
  final String measuringUnit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleAndTextColumn(
            title: lang_key.price.tr,
            detailWidget: PriceText(
                price: price),
          ),
          TitleAndTextColumn(
            title: lang_key.measuringUnit.tr,
            text: measuringUnit,
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ],
      ),
    );
  }
}

class ServiceCategoryShimmer extends StatelessWidget {
  const ServiceCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.tertiaryContainer,
        highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8, top: 10),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: kBorderRadius
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              width: 40,
              height: 10,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: kBorderRadius
              ),
            ),
            Container(
              width: 60,
              height: 10,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: kBorderRadius
              ),
            )
          ],
        )
    );
  }
}
