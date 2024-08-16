import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/screens/support/support_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

final SupportViewModel viewModel = Get.put<SupportViewModel>(SupportViewModel());

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.support.tr,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: Svg('assets/svg_vectors/support.svg')),
              const SizedBox(height: 20,),
              SupportOptionItem(title: lang_key.liveChat.tr, icon: Icons.chat_outlined),
              SupportOptionItem(title: lang_key.sendEmail.tr, icon: Icons.email_outlined),
              SupportOptionItem(title: lang_key.faq.tr, icon: Icons.question_mark_rounded)
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for creating an option for type of support
class SupportOptionItem extends StatelessWidget {
  const SupportOptionItem({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: Get.isDarkMode ? null : kLightShadow,
          borderRadius: kBorderRadius
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 25,
              ),
              const SizedBox(width: 15,),
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          )
        ],
      ),
    );
  }
}
