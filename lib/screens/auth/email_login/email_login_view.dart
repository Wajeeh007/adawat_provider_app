import 'package:adawat_provider_app/custom_widgets/custom_button.dart';
import 'package:adawat_provider_app/custom_widgets/custom_textfield.dart';
import 'package:adawat_provider_app/custom_widgets/password_visibility_icon.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:adawat_provider_app/screens/auth/email_login/email_login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:adawat_provider_app/helpers/languages/translations_key.dart' as lang_key;

class EmailLoginView extends StatelessWidget {
  EmailLoginView({super.key});

  final EmailLoginViewModel viewModel = Get.put(EmailLoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              physics: const ScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - constraintSubtractValue,
                  minWidth: constraints.maxWidth
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lang_key.enterCredentials.tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                        child: Image(image: Svg('assets/svg_vectors/email_login.svg',)),
                      ),
                      Form(
                        key: viewModel.formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: viewModel.emailController,
                              title: lang_key.email.tr,
                              asterisk: true,
                              hintText: 'abc@example.com',
                            ),
                            const SizedBox(height: 10,),
                            Obx(() => CustomTextField(
                              controller: viewModel.passwordController,
                              title: lang_key.password.tr,
                              asterisk: true,
                              hintText: '******',
                              obscureText: viewModel.obscurePassword.value,
                              suffixIcon: PasswordVisibilityIcon(visibility: viewModel.obscurePassword)
                            ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomButton(
                            onTap: () {},
                              // => Get.offAllNamed(AppRoutes.bottomBar),
                            text: lang_key.login.tr,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}