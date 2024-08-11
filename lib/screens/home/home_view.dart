import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/location_container.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/screens/home/home_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

final HomeViewModel viewModel = Get.put<HomeViewModel>(HomeViewModel());

/// Enum for bookings statistics containers
enum ContainerType {cancelled, newBooking, scheduled}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WelcomeText(),
          BookingsStats(),
          TextStats(),
          EarningsChart(),
          NextBooking(),
        ],
      ),
    );
  }
}

/// Customer name and divider
class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lang_key.welcome.tr,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600
              ),
            ),
            Text(
              'Provider Name',
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 0.5,
        )
      ],
    );
  }
}

/// Bookings statistics block
class BookingsStats extends StatelessWidget {
  const BookingsStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => viewModel.showBookingsData.value ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => viewModel.switchDate(context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() => Text(
                      viewModel.selectedDateString.value,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  const Icon(Icons.keyboard_arrow_down_rounded,)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleStatTile(type: ContainerType.cancelled),
                SingleStatTile(type: ContainerType.newBooking),
                SingleStatTile(type: ContainerType.scheduled)
              ],
            ),
          ],
        ),
      ) : const BookingsDataShimmer()
    );
  }
}

class BookingsDataShimmer extends StatelessWidget {
  const BookingsDataShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.tertiaryContainer,
            highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
            child: Container(
              height: 10,
              width: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                borderRadius: kBorderRadius
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleStatTile(isShimmer: true),
              SingleStatTile(isShimmer: true,),
              SingleStatTile(isShimmer: true,)
            ],
          ),
        ],
      ),
    );
  }
}

/// Single Stats tile for New, Cancelled and Scheduled bookings
class SingleStatTile extends StatelessWidget {
  const SingleStatTile({
    super.key,
    this.type,
    this.isShimmer = false
  }) : assert(type != null || (isShimmer != null && isShimmer != false), 'Either both properties are null or only shimmer property is provided which is set to false\n\nProvide either of the two properties, and don\'t set shimmer to false'),
        assert(type == null || (isShimmer == null || isShimmer == false), 'Cannot provide type and set isShimmer: true. Either remove type or remove isShimmer or set it to false');

  final ContainerType? type;
  final bool? isShimmer;

  @override
  Widget build(BuildContext context) {
    return isShimmer! ? Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.tertiaryContainer,
      highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
        child: Container(
          width: Get.width * 0.28,
          height: Get.height * 0.11,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
            borderRadius: kBorderRadius
          ),
        ),
    ) : Container(
      padding: const EdgeInsets.symmetric(vertical: 15,),
      alignment: Alignment.center,
      width: Get.width * 0.28,
      height: Get.height * 0.11,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: type == ContainerType.cancelled ? pendingStatusBgColor.withOpacity(0.3)
            : type == ContainerType.newBooking ? Colors.tealAccent.withOpacity(0.1)
            : Colors.lightBlueAccent.withOpacity(0.1),
        borderRadius: kBorderRadius
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: type == ContainerType.cancelled ? pendingStatusBgColor.withOpacity(0.4)
                : type == ContainerType.newBooking ? Colors.tealAccent.withOpacity(0.2)
                : Colors.lightBlueAccent.withOpacity(0.2),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: type == ContainerType.cancelled ? errorRed
                      : type == ContainerType.newBooking ? Colors.teal : Colors.lightBlue,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                type == ContainerType.newBooking ? lang_key.newBooking.tr : type!.name.capitalizeFirst!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: type == ContainerType.cancelled ? errorRed
                      : type == ContainerType.newBooking ? Colors.teal : Colors.lightBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Textual Statistics
class TextStats extends StatelessWidget {
  const TextStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: [
          SingleTextStat(title: lang_key.totalJobs.tr, value: viewModel.showTotalAmounts.value ? '8' : null, isShimmer: !viewModel.showTotalAmounts.value),
          SingleTextStat(title: lang_key.totalAmount.tr, value: viewModel.showTotalAmounts.value ? '400 ${lang_key.sar.tr}' : null, isShimmer: !viewModel.showTotalAmounts.value,),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

/// Text Stat widget
class SingleTextStat extends StatelessWidget {
  const SingleTextStat({
    super.key,
    required this.title,
    this.value,
    this.isShimmer = false /// This value is set to false to avoid the null check operator error. Go through assert statements for better understanding
  }) : assert(value != null || (isShimmer != null && isShimmer != false), 'Either both values are null or only shimmer property is provided which is set to false.\n\nTo resolve this issue either set isShimmer: true or provide value property'),
      assert(value == null || (isShimmer == null || isShimmer == false), 'Cannot provide value and set isShimmer: true. Either remove value or remove isShimmer or set it to false');

  final String title;
  final String? value;
  final bool? isShimmer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          isShimmer! ? Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.tertiaryContainer,
            highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
              child: Container(
                height: 10,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                  borderRadius: kBorderRadius
                ),
              ),
          ) : Text(
            value!,
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}

/// Chart statistics for Bookings
class EarningsChart extends StatelessWidget {
  const EarningsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 15),
          child: Text(
            lang_key.last60DaysEarning.tr,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16
            ),
          ),
        ),
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Obx(() => viewModel.showEarningGraph.value ? LineChart(
                LineChartData(
                  lineTouchData: const LineTouchData(
                    enabled: false
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary
                    )
                  ),
                  gridData: FlGridData(
                      show: true,
                    horizontalInterval: 1,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                          strokeWidth: 0.5
                        );
                    },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                          strokeWidth: 0.5
                        );
                      }
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) => BottomTitleWidget(value: value, meta: meta,),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) => LeftTitleWidget(value: value, meta: meta),
                        reservedSize: 42,
                      ),
                    ),
                  ),
                  minX: 0,
                  maxX: 11,
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(2.6, 2),
                        FlSpot(4.9, 5),
                        FlSpot(6.8, 3.1),
                        FlSpot(8, 4),
                        FlSpot(9.5, 3),
                        FlSpot(11, 4),
                      ],
                      isCurved: true,
                      barWidth: 2,
                      color: Theme.of(context).colorScheme.primary,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.15)
                      ),
                    ),
                  ],
                )
            ) : Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.tertiaryContainer,
              highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                    borderRadius: kBorderRadius
                  ),
                ),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.secondary,
          thickness: 0.5,
          height: 20,
        )
      ],
    );
  }
}

/// Widget for returning text at the bottom of chart
class BottomTitleWidget extends StatelessWidget {
  const BottomTitleWidget({super.key, required this.value, required this.meta});

  final double value;
  final TitleMeta meta;

  @override
  Widget build(BuildContext context) {

    String text;
    final style = Theme.of(context).textTheme.labelMedium;

    switch (value.toInt()) {
      case 1:
        text = months[DateTime.now().subtract(const Duration(days: 60)).month-1];
        break;
      case 5:
        text = months[DateTime.now().subtract(const Duration(days: 30)).month-1];
        break;
      case 9:
        text = months[DateTime.now().month-1];
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style,),
    );
  }
}

/// Widget for returning text at left side of the chart
class LeftTitleWidget extends StatelessWidget {
  const LeftTitleWidget({super.key, required this.value, required this.meta});

  final double value;
  final TitleMeta meta;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium;
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30K';
        break;
      case 5:
        text = '50K';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}

/// Container which shows next booking details
class NextBooking extends StatelessWidget {
  const NextBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang_key.nextBooking.tr,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16
            ),
          ),
          Obx(() => viewModel.showNextBooking.value ? LocationContainer(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: primaryBlack.withOpacity(0.4),
                      borderRadius: kBorderRadius
                  ),
                ),
                Positioned(
                  bottom: 7,
                  right: 7,
                  child: CustomButton(
                    onTap: () {},
                    text: lang_key.showDetails.tr,
                    width: Get.width * 0.35,
                    height: 30,
                    textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: primaryBlack
                    ),
                    borderRadius: 10,
                  ),
                ),
                Positioned(
                    bottom: 7,
                    left: 7,
                    child: RichText(
                      text: TextSpan(
                          text: "${lang_key.duration.tr}: ",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: backgroundWhite
                          ),
                          children: [
                            TextSpan(
                                text: '1.5 hours',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: backgroundWhite
                                )
                            )
                          ]
                      ),
                    )
                ),
                Positioned(
                    top: 7,
                    left: 7,
                    child: RichText(
                      text: TextSpan(
                          text: "${lang_key.date.tr}: ",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: backgroundWhite
                          ),
                          children: [
                            TextSpan(
                                text: DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now().add(const Duration(days: 1))),
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: backgroundWhite
                                )
                            )
                          ]
                      ),
                    )
                )
              ],
            ),
          ) : Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.tertiaryContainer,
            highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                borderRadius: kBorderRadius
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}