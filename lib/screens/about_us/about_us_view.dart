import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.aboutUs.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                lang_key.whoAreWe.tr,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8,),
            RichText(
              text: TextSpan(
                text: 'ADAWAT',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600
                ),
                children: [
                  TextSpan(
                    text: ' is a home appliances and services company based in Riyadh, Saudi Arabia. Founded in 1990, we manufacture home appliances like AC, Refrigerators etc, and also provide cleaning and repair services for them.',
                    style: Theme.of(context).textTheme.labelMedium
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
