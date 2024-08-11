import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/location_container.dart';
import 'package:adawat_provider_app/custom_widgets/status_based_widget.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_column.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'bookings_listing_viewmodel.dart';

final BookingsViewModel viewModel = Get.put<BookingsViewModel>(BookingsViewModel());

class BookingsListingView extends StatelessWidget {
  const BookingsListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 80,
        titleText: lang_key.bookings.tr,
        bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Get.isDarkMode ? primaryDullYellow : primaryYellow,
            padding: const EdgeInsets.only(top: 20),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Get.isDarkMode ? primaryDullYellow : primaryYellow
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
            children: const [
              ScheduledList(),
              CompletedList(),
              CancelledList()
            ],
                  ),
          ),
      ]
      ),
    );
  }
}

/// Pending bookings list
class ScheduledList extends StatelessWidget {
  const ScheduledList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => viewModel.showScheduledList.value ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const BookingContainer(type: ContainerType.pending,);
          },
        ),
      ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    ),
    );
  }
}

/// Completed bookings list
class CompletedList extends StatelessWidget {
  const CompletedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => viewModel.showCompletedList.value ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const BookingContainer(type: ContainerType.completed,);
          },
        ),
      ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    ),
    );
  }
}

/// Cancelled bookings list
class CancelledList extends StatelessWidget {
  const CancelledList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => viewModel.showCancelledList.value ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const BookingContainer(type: ContainerType.cancelled,);
          },
        ),
      ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    ),
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
        onTap: () => Get.toNamed(AppRoutes.bookingDetails, arguments: {'isScheduled': type == ContainerType.pending}),
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
                      child: SizedBox(
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