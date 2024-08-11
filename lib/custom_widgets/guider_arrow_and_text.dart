import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../helpers/constants.dart';

class GuiderArrowAndText extends StatelessWidget {
  const GuiderArrowAndText({
    super.key, required this.text,
    required this.arrowIcon,
    this.shimmerDirection = ShimmerDirection.rtl,
    this.iconSize = 30,
    this.textStyle
  });

  final String text;
  final IconData arrowIcon;
  final ShimmerDirection? shimmerDirection;
  final double iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
            period: const Duration(milliseconds: 750),
            direction: shimmerDirection!,
            baseColor: Theme.of(context).colorScheme.tertiaryContainer,
            highlightColor: Theme.of(context).colorScheme.tertiaryFixedDim,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Icon(arrowIcon, size: iconSize,);
                }),
              ),
            )
        ),
        Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.labelSmall?.copyWith(
              color: backgroundWhite
          ),
        )
      ],
    );
  }
}
