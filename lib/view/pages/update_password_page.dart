import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordPage extends StatefulWidget {
  UpdatePasswordPageState createState() => UpdatePasswordPageState();
}

class UpdatePasswordPageState extends State<UpdatePasswordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ProfileViewModel>(builder: (profileVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text("update_password".tr,
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
          body: SingleChildScrollView(
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
                    "update_password_login_required".tr,
                    style:
                        fontMedium.copyWith(color: black, fontSize: fontSize14),
                  ),
                  SizedBox(height: paddingSize35),
                  CommonTextFormField(
                    controller: profileVM.oldPasswordController,
                    isPassword: true,
                    bgColor: lavenderMist,
                    padding: const EdgeInsets.symmetric(
                        vertical: paddingSize15, horizontal: paddingSize15),
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    hintText: "enter_old_password".tr,
                  ),
                  SizedBox(height: paddingSize15),
                  CommonTextFormField(
                    controller: profileVM.passwordController,
                    isPassword: true,
                    bgColor: lavenderMist,
                    padding: const EdgeInsets.symmetric(
                        vertical: paddingSize15, horizontal: paddingSize15),
                    textStyle: fontMedium.copyWith(
                        color: bluishPurple, fontSize: fontSize14),
                    hintText: "enter_new_password".tr,
                  ),
                  SizedBox(height: paddingSize15),
                  CommonTextFormField(
                    controller: profileVM.reTypePasswordController,
                    isPassword: true,
                    bgColor: lavenderMist,
                    padding: const EdgeInsets.symmetric(
                        vertical: paddingSize15, horizontal: paddingSize15),
                    textStyle: fontMedium.copyWith(
                        color: bluishPurple, fontSize: fontSize14),
                    hintText: "enter_retype_password".tr,
                  ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "confirm".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () async {
                      if (profileVM.oldPasswordController.text.isEmpty) {
                        showSnackBar('enter_old_password'.tr);
                      }
                      if (profileVM.passwordController.text.isEmpty) {
                        showSnackBar('enter_new_password'.tr);
                      } else if (profileVM
                          .reTypePasswordController.text.isEmpty) {
                        showSnackBar('reenter_password'.tr);
                      } else if (profileVM.passwordController.text.toString() !=
                          profileVM.reTypePasswordController.text.toString()) {
                        showSnackBar('new_confirm_same'.tr);
                      } else {
                        ResponseModel resp = await profileVM.updatePassword(
                          profileVM.oldPasswordController.text.toString(),
                          profileVM.passwordController.text.toString(),
                          profileVM.reTypePasswordController.text.toString(),
                        );
                        if (resp.isSuccess) {
                          showSnackBar(resp.message, isError: false);
                          Get.back(
                              result: true, canPop: true, closeOverlays: true);
                        } else {
                          showSnackBar('errorMessage'.tr);
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
