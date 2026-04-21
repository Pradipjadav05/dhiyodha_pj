import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/my_business_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserNamePage extends StatefulWidget {
  UpdateUserNamePageState createState() => UpdateUserNamePageState();
}

class UpdateUserNamePageState extends State<UpdateUserNamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBusinessViewModel>(builder: (myBusinessVM) {
      return Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "update_username".tr,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: paddingSize15),
                  Text(
                    "update_required_login".tr,
                    style:
                        fontMedium.copyWith(color: black, fontSize: fontSize14),
                  ),
                  SizedBox(height: paddingSize15),
                  CommonTextFormField(
                    isEnabled: false,
                    bgColor: lavenderMist,
                    padding: const EdgeInsets.symmetric(
                        vertical: paddingSize15, horizontal: paddingSize15),
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    hintText: "poonamtala@gmail.com",
                  ),
                  SizedBox(height: paddingSize15),
                  CommonTextFormField(
                    bgColor: lavenderMist,
                    padding: const EdgeInsets.symmetric(
                        vertical: paddingSize15, horizontal: paddingSize15),
                    textStyle: fontMedium.copyWith(
                        color: bluishPurple, fontSize: fontSize14),
                    hintText: "new_username".tr,
                  ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "confirm".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
