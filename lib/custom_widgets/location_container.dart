import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationContainer extends StatelessWidget {
  LocationContainer({
    super.key,
    this.child,
    this.showShadow = true,
    this.margin = const EdgeInsets.symmetric(vertical: 8)
  }) : assert(margin.isNonNegative, 'Margin cannot be a negative value');

  final Widget? child;
  final bool? showShadow;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: Get.isDarkMode ? [] : kShadow,
        borderRadius: kBorderRadius,
        image: const DecorationImage(
            image: AssetImage('assets/images/location_example_image.png'),
          fit: BoxFit.fill
        )
      ), child: child,
    );
  }
}