import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/viewModel/localization_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagePage extends StatefulWidget {
  LanguagePageState createState() => LanguagePageState();
}

class LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    super.initState();
    initLanguages();
  }

  Future<void> initLanguages() async {
    LocalizationViewModel localizationViewModel =
        Get.find<LocalizationViewModel>();
    await localizationViewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("language".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
        menuWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            customBorder: new CircleBorder(),
            onTap: () {
              Get.toNamed(Routes.getWebViewPageRoute(queryWebUrl));
            },
            child: Image.asset(
              query,
              width: 24.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<LocalizationViewModel>(
            builder: (localizationVM) {
              return Padding(
                padding: const EdgeInsets.all(paddingSize15),
                child: Column(
                  children: [
                    Text(
                      "change_language_text".tr,
                      style: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize5),
                      decoration: BoxDecoration(
                        color: lavenderMist,
                        borderRadius: BorderRadius.circular(radius10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(0, 0))
                        ],
                      ),
                      child: DropdownButton(
                          icon: Image.asset(
                            dropDownArrow,
                            width: 18.0,
                            height: 18.0,
                          ),
                          underline: const SizedBox(),
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                          value: localizationVM.selectedLanguage,
                          isExpanded: true,
                          items: localizationVM.languageList.map((String val) {
                            return DropdownMenuItem(
                                child: Text(
                                  val,
                                  style: fontMedium.copyWith(
                                      color: midnightBlue,
                                      fontSize: fontSize14),
                                ),
                                value: val);
                          }).toList(),
                          onChanged: (val) {
                            localizationVM.selectedLanguage = val.toString();
                            globalSelectedLanguage = val.toString();
                            switch (val.toString()) {
                              case "English":
                                localizationVM.setLanguage(
                                  Locale(
                                    "en",
                                    "US",
                                  ),
                                );
                                break;
                              case "हिंदी":
                                localizationVM.setLanguage(
                                  Locale(
                                    "hi",
                                    "IN",
                                  ),
                                );
                                break;
                            }
                          }),
                    ),
                    SizedBox(height: paddingSize25),
                    CommonButton(
                      buttonText: "confirm".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () {
                        Get.toNamed(Routes.getSplashRoute());
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
