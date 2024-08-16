import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/location_container.dart';
import 'package:adawat_provider_app/custom_widgets/status_based_widget.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_column.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:shimmer/shimmer.dart';
import 'bookings_listing_viewmodel.dart';

class BookingsListingView extends StatelessWidget {
  BookingsListingView({super.key});

  final BookingsListingViewModel viewModel = Get.put<BookingsListingViewModel>(BookingsListingViewModel());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 80,
        titleText: lang_key.bookings.tr,
        bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.only(top: 20),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary
            ),
            unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
            controller: viewModel.tabController,
            tabs: [
              Text(lang_key.scheduled.tr),
              Text(lang_key.completed.tr),
              Text(lang_key.cancelled.tr)
            ]
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
            controller: viewModel.tabController,
            children: [
              BookingsList(type: ContainerType.pending, loadingBool: viewModel.showScheduledList),
              BookingsList(type: ContainerType.completed, loadingBool: viewModel.showCompletedList),
              BookingsList(type: ContainerType.cancelled, loadingBool: viewModel.showCancelledList)
            ]),
          )]
      ),
    );
  }
}

/// Listview builder for bookings lists
class BookingsList extends StatelessWidget {
  BookingsList({super.key, required this.type, required this.loadingBool});

  final RxBool loadingBool;
  final ContainerType type;

  final BookingsListingViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: ListView.builder(
        itemCount: loadingBool.value ? 1 : 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return loadingBool.value ? BookingContainer(type: type,) : const BookingContainerShimmer();
        },
      ),
    )
    );
  }
}

/// Booking details widget. Can be used for all types of bookings
class BookingContainer extends StatelessWidget {
  const BookingContainer({super.key, required this.type});

  final ContainerType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: Get.isDarkMode ? null : kShadow,
        borderRadius: kBorderRadius,
      ),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.bookingDetails, arguments: {'bookingType': type}),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: kBorderRadius,
                      child: const SizedBox(
                        width: 100,
                        height: 80,
                        child: Placeholder(),
                      )
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AC Installation',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        Text(
                          'AC Services',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Text(
                                  lang_key.otherServices.tr,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Container(
                                  height: 20,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: kBorderRadius,
                                  ),
                                  child: Text(
                                    '1 more',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: backgroundWhite
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleAndTextColumn(
                          title: lang_key.date.tr,
                        text: '15 Jul, 2024',
                      ),
                      type == ContainerType.cancelled ? TitleAndTextColumn(
                        title: lang_key.cancellationDate.tr,
                        text: '14 Jul, 2024',
                      ) : TitleAndTextColumn(
                        title: lang_key.duration.tr,
                        text: '3 hours',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            LocationContainer(),
            StatusBasedWidget(type: type),
          ],
        ),
      ),
    );
  }
}

/// Booking Shimmer container
class BookingContainerShimmer extends StatelessWidget {
  const BookingContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer
        )
      ),
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.tertiaryContainer,
          highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
             children: [
               Row(
                 children: [
                   SizedBox(
                     height: 80,
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           width: 100,
                           height: 80,
                           decoration: kShimmerContainerDecoration
                         ),
                         const SizedBox(width: 15,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                               width: Get.width * 0.45,
                               height: 35,
                               decoration: kShimmerContainerDecoration,
                             ),
                             const SizedBox(height: 5,),
                             Container(
                               width: Get.width * 0.25,
                               height: 20,
                               decoration: kShimmerContainerDecoration,
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10,),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                               height: 10,
                               width: 30,
                               decoration: kShimmerContainerDecoration,
                             ),
                             const SizedBox(height: 5,),
                             Container(
                               height: 15,
                               width: 80,
                               decoration: kShimmerContainerDecoration,
                             ),
                           ],
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Container(
                               height: 10,
                               width: 30,
                               decoration: kShimmerContainerDecoration,
                             ),
                             const SizedBox(height: 5,),
                             Container(
                               height: 15,
                               width: 80,
                               decoration: kShimmerContainerDecoration,
                             ),
                           ],
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
               Container(
                 width: double.infinity,
                 height: 120,
                 decoration: kShimmerContainerDecoration,
               ),
             ],
            ),
          )
      ),
    );
  }
}