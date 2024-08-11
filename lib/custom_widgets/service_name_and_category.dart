import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/constants.dart';

class ServiceNameAndCategory extends StatelessWidget {
  const ServiceNameAndCategory({super.key, required this.serviceCategory, required this.serviceName});

  final String serviceName;
  final String serviceCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          serviceName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          serviceCategory,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Get.isDarkMode ? darkThemeLightGrey.withOpacity(0.5) : lightModeTextGreyAndShadow
          ),
        ),
      ],
    );
  }
}