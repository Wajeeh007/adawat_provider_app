import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autoValidateMode;
  final bool asterisk;
  final bool? showCursor;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;
  final double borderRadius;

  const CustomTextField({
    super.key,
    this.asterisk = false,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.onTap,
    this.minLines,
    this.showCursor,
    this.errorText,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.inputFormatters,
    this.padding,
    this.borderRadius = kContainerRadius
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: title == null ? 5.0 : 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (title == null)
              ? const SizedBox()
              : Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 10),
            child: RichText(
              text: TextSpan(
                text: title,
                style: Theme.of(context).textTheme.labelMedium,
                children: [
                  (asterisk)
                      ? TextSpan(
                    text: '*',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: errorRed),
                  )
                      : const TextSpan(text: '')
                ],
              ),
            ),
          ),
          TextFormField(
            onTapOutside: (onTap) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            cursorColor: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
            cursorHeight: 20,
            inputFormatters: inputFormatters,
            controller: controller,
            initialValue: initialValue,
            keyboardType: keyboardType,
            minLines: minLines,
            maxLines: maxLines,
            onChanged: onChanged,
            readOnly: readOnly,
            autovalidateMode: autoValidateMode,
            obscureText: obscureText,
            validator: validator,
            onTap: onTap,
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Get.isDarkMode ? darkThemeLightGrey.withOpacity(0.6) : lightThemeBorderGrey
              ),
              errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: errorRed
              ),
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon
            ),
          ),
        ],
      ),
    );
  }
}