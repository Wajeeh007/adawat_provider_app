import 'package:adawat_provider_app/custom_widgets/custom_network_image.dart';
import 'package:adawat_provider_app/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:shimmer/shimmer.dart';
import '../helpers/constants.dart';
import 'custom_button.dart';

//TODO: Use this widget at multiple places. Separate widgets have been created instead of using this

/// Service details item container
class ServiceItem extends StatelessWidget {
  const ServiceItem({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: kBorderRadius,
        boxShadow: Get.isDarkMode ? null : kShadow,
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: CustomNetworkImage(
                height: 105,
                width: double.infinity,
                placeholderImagePath: 'assets/vectors/service_example_image.png',
            ),
          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      service.serviceName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      service.serviceCategory!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Get.isDarkMode ? darkThemeLightGrey.withOpacity(0.5) : darkThemeLightGrey
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${service.price.toString()} ${lang_key.sar.tr}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "(${service.measuringUnit})",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Get.isDarkMode ? darkThemeLightGrey.withOpacity(0.6) : darkThemeLightGrey
                                ),
                              )
                            ],
                          ),
                        ),
                        CustomButton(
                          onTap: () {},
                            // => Get.toNamed(AppRoutes.serviceDetails, arguments: {'service': service}),
                          text: lang_key.bookNow.tr,
                          width: 80,
                          textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            color: primaryBlack
                          ),
                          borderRadius: 10,
                          color: Get.isDarkMode ? primaryDullYellow : primaryYellow,
                          height: 30,
                        )
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}

/// Shimmer effect for service item
class ShimmerServiceItem extends StatelessWidget {
  const ShimmerServiceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 105,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.tertiaryContainer,
                highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(kContainerRadius)
                  ),
                ),
              )
          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.tertiaryContainer,
                          highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
                          child: Container(
                            height: 15,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(kContainerRadius)
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.tertiaryContainer,
                          highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
                          child: Container(
                            height: 8,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(kContainerRadius)
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.tertiaryContainer,
                          highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
                          child: Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(kContainerRadius)
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.tertiaryContainer,
                          highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
                          child: Container(
                            height: 8,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(kContainerRadius)
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}