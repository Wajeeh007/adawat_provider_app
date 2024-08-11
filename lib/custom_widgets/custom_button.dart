import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    this.text,
    this.color,
    this.textColor,
    this.width = double.infinity,
    this.textStyle,
    this.height = 55,
    this.borderRadius = kContainerRadius,
    this.margin = const EdgeInsets.only(top: 20),
    this.borderStyle,
    this.child,
  }) : assert(text != null || child != null, 'Either text or child must be provided'),
      assert(text == null || child == null, 'Cannot provide both text and child');

  final VoidCallback onTap;
  final String? text;
  final Color? color;
  final Color? textColor;
  final double width, height;
  final TextStyle? textStyle;
  final double borderRadius;
  final EdgeInsets margin;
  final Border? borderStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderStyle,
      ),
      child: InkWell(
        onTap: onTap,
        splashFactory: NoSplash.splashFactory,
        child: Center(
          child: child ?? Text(
              text!,
              style: textStyle ?? Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: textColor ?? (Get.isDarkMode ? backgroundWhite : primaryBlack)
              ),
            ),
        ),
      ),
    );
  }
}