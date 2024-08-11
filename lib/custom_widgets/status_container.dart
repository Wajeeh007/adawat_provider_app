import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:flutter/material.dart';

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