import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/location_container.dart';
import 'package:adawat_provider_app/custom_widgets/status_based_widget.dart';
import 'package:adawat_provider_app/custom_widgets/title_and_text_column.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/screens/single_booking/single_booking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../custom_widgets/price_text.dart';
import '../../custom_widgets/title_and_text_row.dart';

class SingleBookingView extends StatelessWidget {
  SingleBookingView({super.key});

  final SingleBookingViewModel viewModel = Get.put<SingleBookingViewModel>(SingleBookingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showLeading: true,
        titleText: lang_key.bookingDetails.tr,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight - constraintSubtractValue
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const CustomerDetails(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleAndTextColumn(title: lang_key.services.tr),
                          TitleAndTextColumn(title: lang_key.quantity.tr)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Column(
                        children: List.generate(2, (index) {
                          return const ServiceContainer();
                        }),
                      ),
                    ),
                    const LocationAndTime(),
                    const CostDetails(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if(viewModel.bookingType == ContainerType.pending) CustomButton(onTap: () {}, text: lang_key.startActivity.tr, height: 45,),
                            StatusBasedWidget(type: viewModel.bookingType!,
                              starsOffColor: Get.isDarkMode
                                  ? primaryGrey
                                  : darkThemeLightGrey,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

/// Customer basic details widget
class CustomerDetails extends StatelessWidget {
  const CustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20, top: 10),
      child: Column(
        children: [
          TitleAndTextRow(
            title: lang_key.customerName.tr,
            text: 'Syed Wajeeh Ahsan',
          ),
          TitleAndTextRow(
            title: lang_key.phoneNumber.tr,
            text: '+9661234861651',
          ),
        ],
      ),
    );
  }
}

/// Widget to show time, duration and location of the booking
class LocationAndTime extends StatelessWidget {
  const LocationAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleAndTextColumn(
                    title: lang_key.date.tr,
                    text: '15 Jul, 2024',
                  ),
                  TitleAndTextColumn(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    title: lang_key.duration.tr,
                    text: '3 Hours',
                  ),
                ],
              ),
              LocationContainer(margin: const EdgeInsets.symmetric(vertical: 10),),
              TitleAndTextRow(title: lang_key.address.tr, text: 'House No 242, Shaheen Housing Scheme, Warsak Road, Peshawar', textMaxLines: 2,),
              TitleAndTextRow(title: lang_key.additionalPhoneNo.tr, text: '+966874651654'),
            ],
          ),
        )
      ],
    );
  }
}

/// Text to show total cost of services
class CostDetails extends StatelessWidget {
  const CostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: [
          TitleAndTextRow(
              title: lang_key.totalCost.tr,
              detailWidget: const PriceText(price: 150),
          ),
          TitleAndTextRow(
              title: lang_key.paymentMethod.tr,
              text: 'Cash After Activity',
          )
        ],
      ),
    );
  }
}

/// Service name, category, status and quantity widget
class ServiceContainer extends StatelessWidget {
  const ServiceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(right: 15),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: kBorderRadius,
        boxShadow: Get.isDarkMode ? null : kShadow
      ),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Placeholder(
                fallbackWidth: 100,
                fallbackHeight: double.infinity,
              ),
              // const CustomNetworkImage(height: double.infinity, width: 100, placeholderImagePath: 'assets/vectors/example_image.jpg',),
              const SizedBox(width: 15,),
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AC Installation',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16
                        )
                      ),
                      Text(
                        'AC Services',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary
                        ),
                      ),
                      const Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: StatusContainer(
                              color: pendingStatusBgColor,
                              text: 'Pending',
                              textColor: errorRed
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'x1',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Container to show status of the service
class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.color, required this.text, required this.textColor});

  final Color color;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(kContainerRadius),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: textColor
        ),
      ),
    );
  }
}
