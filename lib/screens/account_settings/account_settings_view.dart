import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../custom_widgets/custom_button.dart';
import 'account_settings_viewmodel.dart';

class AccountSettingsView extends StatelessWidget {
  AccountSettingsView({super.key});

  final AccountSettingsViewModel viewModel = Get.put<AccountSettingsViewModel>(AccountSettingsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.settings.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeadingText(text: lang_key.account.tr),
            SettingItem(
              title: lang_key.personalDetails.tr,
              onPressed: () => Get.toNamed(AppRoutes.personalDetails),
              suffixIcon: CupertinoIcons.person,
            ),
            SettingItem(
              title: lang_key.changePassword.tr,
              onPressed: () => Get.toNamed(AppRoutes.changePassword),
              suffixIcon: Icons.password_rounded,
            ),
            SettingItem(
                title: lang_key.changePhoneNumber.tr,
                onPressed: () => Get.toNamed(AppRoutes.changePhoneNumber),
              suffixIcon: CupertinoIcons.phone,
            ),
            SettingItem(
                title: lang_key.deleteAccount.tr,
              suffixIcon: CupertinoIcons.delete,
              titleTextColor: errorRed,
              suffixIconColor: errorRed,
              onPressed: () => showCautionDialog(context),
            ),
            HeadingText(text: lang_key.general.tr),
            SettingItem(
              title: lang_key.language.tr,
              onPressed: () => Get.toNamed(AppRoutes.language),
              suffixIcon: Icons.language_rounded,
            ),
            const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }

  /// Caution dialog for bank account delete confirmation
  showCautionDialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            iconPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            icon: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/delete_details.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    lang_key.proceedWithCaution.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  lang_key.accountDeleteCaution.tr,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        onTap: (){},
                        text: lang_key.yes.tr
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: CustomButton(
                      onTap: () => Get.back(),
                      text: lang_key.no.tr,
                      color: Colors.transparent,
                      borderStyle: Border.all(
                          color: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
                          width: 0.5
                      ),
                      textColor: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
                    ),
                  ),
                ],
              )
            ],
          );
        }
    );
  }
}

/// Settings item container
class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    this.onPressed,
    this.borderRadius = kContainerRadius,
    this.margin  = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    this.padding = const EdgeInsets.all(15),
    this.includeShadow = true,
    this.includeButton = true,
    this.descText,
    this.suffixIcon,
    this.suffixWidget,
    this.titleTextColor,
    this.suffixIconColor,
  });

  final double borderRadius;
  final EdgeInsets margin, padding;
  final String title;
  final bool includeShadow;
  final bool includeButton;
  final String? descText;
  final VoidCallback? onPressed;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final Color? titleTextColor;
  final Color? suffixIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: includeShadow ? Get.isDarkMode ? null : kShadow : null,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Column(
              children: [
                descText != null ? Text(
                  descText!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.grey.shade400
                  ),
                ) : const SizedBox(),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: titleTextColor,
                  ),
                ),
              ],
            ),
            includeButton ? Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: suffixWidget ?? (suffixIcon != null ? Icon(
                  suffixIcon,
                  color: suffixIconColor,
                ) : const CircleAvatar(
                    radius: 10,
                    backgroundColor: darkThemeLightGrey,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13,
                      color: primaryBlack,
                    ),
                  )),
                ),
              ) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

/// Settings category heading text
class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}