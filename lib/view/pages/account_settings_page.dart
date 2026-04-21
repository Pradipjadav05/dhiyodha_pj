import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/viewModel/account_settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingsPage extends StatefulWidget {
  AccountSettingsPageState createState() => AccountSettingsPageState();
}

class AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text(
          "account_settings".tr,
          style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: paddingSize10, horizontal: paddingSize15),
            child: GetBuilder<AccountSettingsViewmodel>(builder: (settingsVM) {
              return Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: paddingSize15),
                    Text(
                      "show_my_bio".tr,
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnThreeRadioWidget(
                        "All", "My Connections", "None", settingsVM, 1),
                    SizedBox(height: paddingSize15),
                    Text(
                      "Show my connections to :",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnThreeRadioWidget(
                        "All", "My Connections", "None", settingsVM, 2),
                    SizedBox(height: paddingSize15),
                    Text(
                      "Show my testimonials to :",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnThreeRadioWidget(
                        "All", "My Connections", "None", settingsVM, 3),
                    SizedBox(height: paddingSize15),
                    Text(
                      "Show my picture gallery to :",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnThreeRadioWidget(
                        "All", "My Connections", "None", settingsVM, 4),
                    SizedBox(height: paddingSize15),
                    Text(
                      "Show my email to :",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnThreeRadioWidget(
                        "All", "My Connections", "None", settingsVM, 5),
                    SizedBox(height: paddingSize15),
                    Text(
                      "Show my contact details to :",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnThreeRadioWidget(
                        "All", "My Connections", "None", settingsVM, 6),
                    SizedBox(height: paddingSize15),
                    Text(
                      "Show on public sites",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnTwoRadioWidget("Yes", "No", settingsVM, 1),
                    SizedBox(height: paddingSize15),
                    Text(
                      "Receive marketing emails",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnTwoRadioWidget("Yes", "No", settingsVM, 2),
                    SizedBox(height: paddingSize15),
                    Text(
                      "I would like to share my revenue received data with my dhiyodha Director",
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    SizedBox(height: paddingSize5),
                    returnTwoRadioWidget("Yes", "No", settingsVM, 3),
                    SizedBox(height: paddingSize25),
                    CommonButton(
                      buttonText: "confirm".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        await _collectDataAndSave(settingsVM);
                      },
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  returnThreeRadioWidget(String itemOneTitle, itemTwoTitle, itemThreeTitle,
      AccountSettingsViewmodel settingsVM, int position) {
    int? groupValues;
    switch (position) {
      case 1:
        groupValues = settingsVM.showBioValue.value;
        break;
      case 2:
        groupValues = settingsVM.showConnectionValue.value;
        break;
      case 3:
        groupValues = settingsVM.showTestimonialValue.value;
        break;
      case 4:
        groupValues = settingsVM.showGalleryValue.value;
        break;
      case 5:
        groupValues = settingsVM.showEmailValue.value;
        break;
      case 6:
        groupValues = settingsVM.showContactValue.value;
        break;
      default:
        groupValues = settingsVM.showBioValue.value;
        break;
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: 1,
              groupValue: groupValues,
              onChanged: (value) {
                switch (position) {
                  case 1:
                    settingsVM.setShowBioValue(value!);
                    break;
                  case 2:
                    settingsVM.setShowConnectionValue(value!);
                    break;
                  case 3:
                    settingsVM.setShowTestimonialValue(value!);
                    break;
                  case 4:
                    settingsVM.setShowGalleryValue(value!);
                    break;
                  case 5:
                    settingsVM.setShowEmailValue(value!);
                    break;
                  case 6:
                    settingsVM.setShowContactValue(value!);
                    break;
                  default:
                    settingsVM.setShowBioValue(value!);
                    break;
                }
              },
              activeColor: bluishPurple,
            ),
            Text(
              itemOneTitle,
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize14),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: 2,
              groupValue: groupValues,
              onChanged: (value) {
                switch (position) {
                  case 1:
                    settingsVM.setShowBioValue(value!);
                    break;
                  case 2:
                    settingsVM.setShowConnectionValue(value!);
                    break;
                  case 3:
                    settingsVM.setShowTestimonialValue(value!);
                    break;
                  case 4:
                    settingsVM.setShowGalleryValue(value!);
                    break;
                  case 5:
                    settingsVM.setShowEmailValue(value!);
                    break;
                  case 6:
                    settingsVM.setShowContactValue(value!);
                    break;
                  default:
                    settingsVM.setShowBioValue(value!);
                    break;
                }
              },
              activeColor: bluishPurple,
            ),
            Text(
              itemTwoTitle,
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize14),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: 3,
              groupValue: groupValues,
              onChanged: (value) {
                switch (position) {
                  case 1:
                    settingsVM.setShowBioValue(value!);
                    break;
                  case 2:
                    settingsVM.setShowConnectionValue(value!);
                    break;
                  case 3:
                    settingsVM.setShowTestimonialValue(value!);
                    break;
                  case 4:
                    settingsVM.setShowGalleryValue(value!);
                    break;
                  case 5:
                    settingsVM.setShowEmailValue(value!);
                    break;
                  case 6:
                    settingsVM.setShowContactValue(value!);
                    break;
                  default:
                    settingsVM.setShowBioValue(value!);
                    break;
                }
              },
              activeColor: bluishPurple,
            ),
            Text(
              itemThreeTitle,
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize14),
            )
          ],
        ),
      ],
    );
  }

  returnTwoRadioWidget(String itemOneTitle, itemTwoTitle,
      AccountSettingsViewmodel settingsVM, int position) {
    int? groupValues;
    switch (position) {
      case 1:
        groupValues = settingsVM.showPublicSiteValue.value;
        break;
      case 2:
        groupValues = settingsVM.showMarketingEmailsValue.value;
        break;
      case 3:
        groupValues = settingsVM.showShareDataValue.value;
        break;
      default:
        groupValues = settingsVM.showPublicSiteValue.value;
        break;
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: 1,
              groupValue: groupValues,
              onChanged: (value) {
                switch (position) {
                  case 1:
                    settingsVM.setShowPublicSiteValue(value!);
                    break;
                  case 2:
                    settingsVM.setShowMarketingEmailsValue(value!);
                    break;
                  case 3:
                    settingsVM.setShowShareDataValue(value!);
                    break;
                  default:
                    settingsVM.setShowPublicSiteValue(value!);
                    break;
                }
              },
              activeColor: bluishPurple,
            ),
            Text(
              itemOneTitle,
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize14),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: 2,
              groupValue: groupValues,
              onChanged: (value) {
                switch (position) {
                  case 1:
                    settingsVM.setShowPublicSiteValue(value!);
                    break;
                  case 2:
                    settingsVM.setShowMarketingEmailsValue(value!);
                    break;
                  case 3:
                    settingsVM.setShowShareDataValue(value!);
                    break;
                  default:
                    settingsVM.setShowPublicSiteValue(value!);
                    break;
                }
              },
              activeColor: bluishPurple,
            ),
            Text(
              itemTwoTitle,
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize14),
            )
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _collectDataAndSave(AccountSettingsViewmodel settingVM) async {
    debugPrint("${settingVM.showBioValue.value}");
    debugPrint("${settingVM.showConnectionValue.value}");
    debugPrint("${settingVM.showTestimonialValue.value}");
    debugPrint("${settingVM.showGalleryValue.value}");
    debugPrint("${settingVM.showEmailValue.value}");
    debugPrint("${settingVM.showContactValue.value}");
    debugPrint("${settingVM.showPublicSiteValue.value}");
    debugPrint("${settingVM.showMarketingEmailsValue.value}");
    debugPrint("${settingVM.showShareDataValue.value}");
  }
}
