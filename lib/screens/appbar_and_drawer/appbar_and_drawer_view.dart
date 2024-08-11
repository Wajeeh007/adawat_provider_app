import 'package:adawat_provider_app/custom_widgets/custom_appbar.dart';
import 'package:adawat_provider_app/custom_widgets/custom_network_image.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/helpers/routes.dart';
import 'package:adawat_provider_app/screens/appbar_and_drawer/appbar_and_drawer_viewmodel.dart';
import 'package:adawat_provider_app/screens/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

final AppbarAndDrawerViewModel viewModel = Get.put<AppbarAndDrawerViewModel>(AppbarAndDrawerViewModel());

class AppbarAndDrawerView extends StatelessWidget {
  const AppbarAndDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(
        includeNotification: true,
        backBtn: false,
        elevation: 1,
        titleWidget: Image(
            image: AssetImage(
                Get.isDarkMode ? 'assets/logos/company_logo_dark.png' : 'assets/logos/company_logo_light.png',
            ),
          width: 180,
        )
      ),
      body: const HomeView(),
    );
  }
}

/// Side drawer widget
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.65,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          const DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: DrawerHeadContent(),
          ),
          const WalletOption(),
          const SizedBox(height: 15,),
          SideDrawerTile(
              leadingIcon: Icons.list_alt_rounded,
              titleText: lang_key.bookings.tr,
            onTap: () => Get.toNamed(AppRoutes.bookingsList),
          ),
          SideDrawerTile(
              leadingIcon: CupertinoIcons.rectangle_grid_2x2,
              titleText: lang_key.myServices.tr,
              onTap: () => Get.toNamed(AppRoutes.myServicesListing)
          ),
          SideDrawerTile(
              leadingIcon: Icons.chat_outlined,
              titleText: lang_key.inbox.tr,
              onTap: () {}
          ),
          SideDrawerTile(
              leadingIcon: CupertinoIcons.creditcard,
              titleText: lang_key.bank.tr,
              onTap: (){}
          ),
          SideDrawerTile(
              leadingIcon: Icons.support_agent_rounded,
              titleText: lang_key.support.tr,
              onTap: () {}
          ),
          SideDrawerTile(
              leadingIcon: CupertinoIcons.doc_append,
              titleText: lang_key.termsAndConditions.tr,
              onTap: () {}
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SideDrawerTile(
                  leadingIcon: Icons.logout_rounded,
                  titleText: lang_key.logout.tr,
                  onTap: () {},
                leadingIconColor: errorRed,
                titleTextColor: errorRed,
                tileColor: errorRed.withOpacity(0.15),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Provider image, name and email for drawer head
class DrawerHeadContent extends StatelessWidget {
  const DrawerHeadContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomNetworkImage(
          height: double.infinity,
          width: double.infinity,
          placeholderImagePadding: 50,
          placeholderImagePath: 'assets/images/person_circle.png',
        ),
        Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.gear),
            )
        ),
        Positioned(
          bottom: 5,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Provider Name',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                'wajeeh.gillani335@gmail.com',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// Wallet tile for drawer
class WalletOption extends StatelessWidget {
  const WalletOption({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 20,
      tileColor: Theme.of(context).colorScheme.secondary.withOpacity(Get.isDarkMode ? 0.15 : 0.3),
      leading: Icon(
        Icons.wallet_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        lang_key.wallet.tr,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      trailing: RichText(
        //TODO: Limit amount to show e.g 9999+ SAR
        text: TextSpan(
          text: '250 ',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600
        ),
          children: [
            TextSpan(
              text: lang_key.sar.tr,
              style: Theme.of(context).textTheme.labelSmall
            )
          ]
      ),
      )
    );
  }
}

/// Custom ListTile widget for side drawer
class SideDrawerTile extends StatelessWidget {
  const SideDrawerTile({
    super.key,
    required this.leadingIcon,
    required this.titleText,
    required this.onTap,
    this.leadingIconColor,
    this.titleTextColor,
    this.tileColor
  });

  final IconData leadingIcon;
  final String titleText;
  final VoidCallback onTap;
  final Color? leadingIconColor;
  final Color? titleTextColor;
  final Color? tileColor;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      onTap: onTap,
      leading: Icon(
        leadingIcon,
        color: leadingIconColor ?? Theme.of(context).iconTheme.color,
      ),
      title: Text(
        titleText,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: titleTextColor
        ),
      ),
      minLeadingWidth: 20,
    );
  }
}