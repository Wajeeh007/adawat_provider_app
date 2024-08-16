import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import 'package:get/get.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: lang_key.termsAndConditions.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            introductionText(context),
            contractFormationText(context)
          ],
        ),
      ),
    );
  }

  /// Point 1, Introduction text
  Widget introductionText(BuildContext context) {
    return ContractSection(
        title: lang_key.intro.tr,
        desc: Text(
          'Welcome to Adawat, also hereby known as "we" and "us". These terms and conditions govern your access and use of our online platform/site. You acknowledge that you have read and understood and agree to the terms and conditions listed below before using Adawat Mobile App. These terms maybe changed, modified, added or removed at any moment without previous notice by Adawat. If no further notification is given, changes become effective when they are posted.',
          style: Theme.of(context).textTheme.labelMedium,
        )
    );
  }
  
  /// Point 2, contract formation text
  Widget contractFormationText(BuildContext context) {
    return ContractSection(
        title: lang_key.howContractIsFormed.tr,
        desc: Text(
          '• After placing an order, you will receive online notification from us acknowledging that we have received your order. Please note that this does not mean that your order has been accepted. Your order constitutes an offer to us to buy a service. All orders are subject to acceptance by us. The contract will only be formed when you receive the service ordered via this platform',
          style: Theme.of(context).textTheme.labelMedium,
        )
    );
  }
}

class ContractSection extends StatelessWidget {
  const ContractSection({super.key, required this.title, required this.desc});

  final String title;
  final Widget desc;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: DottedLine(
              dashColor: Colors.grey.withOpacity(0.6),
              dashGapLength: 6,
              dashLength: 5,
            ),
          ),
          desc
        ],
      ),
    );
  }
}