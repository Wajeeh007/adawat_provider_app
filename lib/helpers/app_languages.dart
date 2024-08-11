import 'package:get/get.dart';
import 'languages/english.dart';

class AppLanguages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': English().translations,
  };
}