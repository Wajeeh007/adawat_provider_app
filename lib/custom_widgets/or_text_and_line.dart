import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:get/get.dart';

class OrTextAndLine extends StatelessWidget {
  const OrTextAndLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DottedLine(
                dashColor: Theme.of(context).colorScheme.secondary,
              dashGapLength: 4,
              dashLength: 6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Text(
              lang_key.or.tr,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Expanded(
            child: DottedLine(
                dashColor: Theme.of(context).colorScheme.secondary,
              dashGapLength: 4,
              dashLength: 6,
            ),
          ),
        ],
      ),
    );
  }
}