import 'package:dhiyodha/utils/helper/get_di.dart' as di;
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/helper/translation_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/viewModel/localization_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  const MyApp({Key? key, required this.languages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationViewModel>(builder: (localizationVM) {
      return GetMaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        locale: localizationVM.locale,
        translations: TranslationModel(languages: languages),
        fallbackLocale: Locale(languagesList[0].languageCode ?? "en",
            languagesList[0].countryCode),
        initialRoute: Routes.getSplashRoute(),
        getPages: Routes.routes,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 500),
        builder: (BuildContext context, widget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: widget!);
        },
      );
    });
  }
}
