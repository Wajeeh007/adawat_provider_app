import 'package:adawat_provider_app/custom_widgets/category_item_with_image.dart';
import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/price_text.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_column.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_row.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/models/service_category.dart';
import 'package:adawat_provider_app/screens/my_services_listing/my_services_listing_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../models/service_model.dart';

class MyServicesListingView extends StatelessWidget {
  MyServicesListingView({super.key});

  final MyServicesListingViewModel viewModel = Get.put(MyServicesListingViewModel());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.myServices.tr,
        action: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                size: 25,
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            CustomTextField(
              controller: viewModel.searchController,
              hintText: lang_key.searchYourService.tr,
            ),
            GridView.builder(
              shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7
                ),
                itemCount: viewModel.myServicesList.length,
                itemBuilder: (context, index) {
                  return ServiceCategoryContainer(item: viewModel.myServicesList[index]);
                }
            )
          ],
        ),
      ),
    );
  }
}

/// Service Category name and number of sub-services selected
class ServiceCategoryContainer extends StatelessWidget {
  ServiceCategoryContainer({super.key, required this.item});

  final ServiceCategory item;

  final MyServicesListingViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CategoryItemWithImage(item: item, onTap: () => subServicesBottomSheet(context: context, categoryName: item.name!),),
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
                      text: '1',
                      style: Theme.of(context).textTheme.labelSmall
                  )
                ]
            ),
          ),
        )
      ],
    );
  }

  Future subServicesBottomSheet({required BuildContext context, required String categoryName}) {
    if(viewModel.showSubServices.isFalse){
      Future.delayed(const Duration(seconds: 3),
          () => viewModel.showSubServices.value = true);
    } else {
      viewModel.showSubServices.value = false;
      Future.delayed(const Duration(seconds: 3),
              () => viewModel.showSubServices.value = true);
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
                          viewModel.showSubServices.value = false;
                        },
                        icon: const Icon(Icons.close, color: errorRed,),
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
              ),
              const Divider(height: 10,),
              Obx(() => viewModel.showSubServices.value ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                      children: List.generate(viewModel.mySubServicesList.length, (index) {
                        return SubServiceBottomSheetWidget(
                            subServiceItem: viewModel.mySubServicesList[index],
                          isFinal: index == viewModel.mySubServicesList.length - 1,
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

/// Sub-service item widget for bottom sheet
class SubServiceBottomSheetWidget extends StatelessWidget {
  const SubServiceBottomSheetWidget({super.key, required this.subServiceItem, required this.isFinal});

  final ServiceModel subServiceItem;
  final bool isFinal;

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
                        subServiceItem.serviceName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall
                    ),
                    TitleAndTextRow(
                      title: "${lang_key.duration.tr}: ",
                      text: "${subServiceItem.duration} ${lang_key.hourOrHours.tr}",
                      mainAxisAlignment: MainAxisAlignment.start,
                      textStyle: Theme.of(context).textTheme.labelSmall,
                      textAndTextWidgetAlignment: Alignment.centerLeft,
                      rowPadding: EdgeInsets.zero,
                    )
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  alignment: Alignment.topRight,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: errorRed,
                    size: 25,
                  ),
                  padding: EdgeInsets.zero,
                ),
              )
            ],
          ),
        ),
        PriceAndMeasuringUnitText(price: subServiceItem.price!, measuringUnit: subServiceItem.measuringUnit!),
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