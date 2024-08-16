import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;
import '../../../custom_widgets/or_text_and_line.dart';
import '../../../helpers/routes.dart';
import 'login_options_viewmodel.dart';

class LoginOptionsView extends StatelessWidget {
  LoginOptionsView({super.key});

  final LoginOptionsViewModel viewModel = Get.put(LoginOptionsViewModel());

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!, /// Make sure SystemUiOverlayStyle property is not empty in theme_helper file
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lang_key.login.tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Obx(() => Visibility(
                      visible: viewModel.makeVisible.value,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
                          child: Image(image: Svg('assets/svg_vectors/login_options.svg')),
                        ),
                      ),
                    ),
                    Obx(() => Visibility(
                        visible: viewModel.makeVisible.value,
                          child: const ContinueWithEmail()),
                    ),
                    const OrTextAndLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialAccButton(platformName: 'Google', onPressed: () {}),
                        SocialAccButton(platformName: 'Apple', onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: lang_key.dontHaveAccount.tr,
                        style: Theme.of(context).textTheme.labelMedium,
                        children: [
                          TextSpan(
                            text: lang_key.signUp.tr,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                color: primaryYellow
                            ),
                            // recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(AppRoutes.signUpScreenOne)
                          )
                        ]
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Button for routing to email credentials screen
class ContinueWithEmail extends StatelessWidget {
  const ContinueWithEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: Get.width * 0.8,
      color: Colors.transparent,
      onTap: () => Get.offAllNamed(AppRoutes.appBarAndDrawer),
      borderStyle: Border.all(
          color: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
          width: 1.5
      ),
      textColor: Get.isDarkMode ? darkThemeLightGrey : primaryBlack,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 25,
              ),
              const SizedBox(width: 10,),
              Text(
                lang_key.continueWithEmail.tr,
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
    );
  }
}

/// Button for adding social auth
class SocialAccButton extends StatelessWidget {
  const SocialAccButton({super.key, required this.platformName, required this.onPressed});

  final String platformName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: onPressed,
        child: Image.asset(
                'assets/logos/${platformName.toLowerCase()}_logo.png',
              height: 35,
              width: 35,
              color: platformName.toLowerCase() == 'apple' ? Get.isDarkMode ? primaryWhite : null : null,
            ),
      ),
    );
  }
}