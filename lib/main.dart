import 'package:adawat_provider_app/screens/appbar_and_drawer/appbar_and_drawer_view.dart';
import 'package:adawat_provider_app/screens/auth/login_options/login_options_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings/init_binding.dart';
import 'helpers/app_languages.dart';
import 'helpers/routes.dart';
import 'helpers/theme_helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adawat Provider App',
      home: AppbarAndDrawerView(),
      theme: ThemeHelpers.lightTheme,
      darkTheme: ThemeHelpers.darkTheme,
      themeMode: ThemeMode.system,
      textDirection: TextDirection.ltr,
      translations: AppLanguages(),
      defaultTransition: Transition.rightToLeftWithFade,
      locale: getLocale(initLanguageController.languageKey.value),
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: InitBinding(),
      getPages: AppRoutes.pages,
      // initialRoute: AppRoutes.initRoute,
    );
  }

  Locale getLocale(String languageKey) {
    return Locale(
        initLanguageController.optionsLocales[languageKey]['languageCode'],
        initLanguageController.optionsLocales[languageKey]['countryCode']
    );
  }
}