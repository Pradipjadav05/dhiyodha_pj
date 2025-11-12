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
import 'package:dhiyodha/viewModel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

class GuestLoginPage extends StatefulWidget {
  GuestLoginPageState createState() => GuestLoginPageState();
}

class GuestLoginPageState extends State<GuestLoginPage> {
  @override
  void initState() {
    super.initState();
    initAPIs();
  }

  Future<void> initAPIs() async {
    Get.find<LoginViewModel>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                appLogoLong,
                width: 120.0,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: GetBuilder<LoginViewModel>(builder: (loginVM) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'the_strength_nation'.tr,
                    style: fontBold.copyWith(
                        color: midnightBlue, fontSize: fontSize18),
                  ),
                  SizedBox(height: 80.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            CommonTextFormField(
                              controller: loginVM.mobileNoController,
                              hintText: "enter_phone_number".tr,
                              maxLength: 10,
                              maxLines: 1,
                              inputType: TextInputType.number,
                              textStyle: fontMedium.copyWith(
                                  fontSize: fontSize14, color: bluishPurple),
                              padding: EdgeInsets.all(paddingSize20),
                              prefixIcon: Align(
                                  widthFactor: 0,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "+91",
                                      style: fontMedium.copyWith(
                                          fontSize: fontSize14,
                                          color: bluishPurple),
                                    ),
                                  )),
                            ),
                            SizedBox(height: paddingSize25),
                            loginVM.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CommonButton(
                                    bgColor: loginVM.isAgreeTerms.value == true
                                        ? bluishPurple
                                        : greyText,
                                    buttonText: "send_otp".tr,
                                    onPressed: () async {
                                      if (loginVM.mobileNoController.text
                                              .isEmpty ||
                                          loginVM.mobileNoController.text
                                                  .length <
                                              10) {
                                        showSnackBar(
                                            "enter_a_valid_phone_number".tr);
                                      } else if (!loginVM.isAgreeTerms.value) {
                                        showSnackBar("accept_terms".tr);
                                      } else {
                                        bool isSuccess =
                                            await loginVM.guestLogin(loginVM
                                                .mobileNoController.text);
                                        if (isSuccess) {
                                          bool isOTPSent =
                                              await loginVM.sendOtp(
                                                  loginVM
                                                      .mobileNoController.text,
                                                  "91");
                                          if (isOTPSent) {
                                            loginVM.isMobileNumberValid.value =
                                                true;
                                          } else {
                                            showSnackBar("otp_fail_msg".tr);
                                          }
                                        } else {
                                          loginVM.isMobileNumberValid.value =
                                              false;
                                          showSnackBar(
                                              "wrong_mobile_number".tr);
                                        }
                                        //sendOTPAPI
                                      }
                                    },
                                    textColor: white,
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: paddingSize25),
                      Obx(
                        () => Visibility(
                          visible: loginVM.isMobileNumberValid.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "enter_otp_code".tr,
                                style: fontRegular.copyWith(
                                    fontSize: fontSize14, color: midnightBlue),
                              ),
                              SizedBox(height: paddingSize10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CommonTextFormField(
                                      controller: loginVM.otp1Controller,
                                      hintText: "0",
                                      maxLength: 1,
                                      maxLines: 1,
                                      isOTP: true,
                                      textStyle: fontMedium.copyWith(
                                          fontSize: fontSize14,
                                          color: bluishPurple),
                                      padding: EdgeInsets.all(paddingSize20),
                                    ),
                                  ),
                                  SizedBox(width: paddingSize30),
                                  Expanded(
                                    child: CommonTextFormField(
                                      controller: loginVM.otp2Controller,
                                      hintText: "0",
                                      maxLength: 1,
                                      maxLines: 1,
                                      isOTP: true,
                                      textStyle: fontMedium.copyWith(
                                          fontSize: fontSize14,
                                          color: bluishPurple),
                                      padding: EdgeInsets.all(paddingSize20),
                                    ),
                                  ),
                                  SizedBox(width: paddingSize30),
                                  Expanded(
                                    child: CommonTextFormField(
                                      controller: loginVM.otp3Controller,
                                      hintText: "0",
                                      maxLength: 1,
                                      maxLines: 1,
                                      isOTP: true,
                                      textStyle: fontMedium.copyWith(
                                          fontSize: fontSize14,
                                          color: bluishPurple),
                                      padding: EdgeInsets.all(paddingSize20),
                                    ),
                                  ),
                                  SizedBox(width: paddingSize30),
                                  Expanded(
                                    child: CommonTextFormField(
                                      controller: loginVM.otp4Controller,
                                      hintText: "0",
                                      maxLength: 1,
                                      maxLines: 1,
                                      isOTP: true,
                                      textStyle: fontMedium.copyWith(
                                          fontSize: fontSize14,
                                          color: bluishPurple),
                                      padding: EdgeInsets.all(paddingSize20),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: paddingSize25),
                              loginVM.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CommonButton(
                                      bgColor:
                                          loginVM.isAgreeTerms.value == true
                                              ? bluishPurple
                                              : greyText,
                                      buttonText: "verify_otp".tr,
                                      onPressed: () async {
                                        if (loginVM.otp1Controller.text.isNotEmpty &&
                                            loginVM.otp2Controller.text
                                                .isNotEmpty &&
                                            loginVM.otp3Controller.text
                                                .isNotEmpty &&
                                            loginVM.otp4Controller.text
                                                .isNotEmpty &&
                                            loginVM.isAgreeTerms.value) {
                                          String OTP =
                                              loginVM.otp1Controller.text +
                                                  loginVM.otp2Controller.text +
                                                  loginVM.otp3Controller.text +
                                                  loginVM.otp4Controller.text;
                                          bool isOTPVerified =
                                              await loginVM.verifyOTP(
                                                  loginVM
                                                      .mobileNoController.text,
                                                  "91",
                                                  OTP);
                                          // callVerifyOTPAPI
                                          if (isOTPVerified) {
                                            Get.toNamed(
                                              Routes
                                                  .getGuestDashboardPageRoute(),
                                            );
                                          } else {
                                            showSnackBar("invalid_OTP".tr);
                                          }
                                        } else {
                                          if (!loginVM.isAgreeTerms.value) {
                                            showSnackBar("accept_terms".tr);
                                          } else {
                                            showSnackBar("enter_valid_otp".tr);
                                          }
                                        }
                                      },
                                      textColor: white,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: paddingSize40),
                      Center(
                        child: Obx(
                          () => Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: lavenderMist,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value: loginVM.isAgreeTerms.value,
                                activeBgColor: bluishPurple,
                                size: 24.0,
                                onChanged: (value) {
                                  loginVM.isAgreeTerms.value = value;
                                },
                              ),
                              Text(
                                '${"i_accept".tr}',
                                style: fontRegular.copyWith(
                                    color: black, fontSize: fontSize13),
                              ),
                              SizedBox(width: 4.0),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      Routes.getWebViewPageRoute(queryWebUrl));
                                },
                                child: Text(
                                  "terms".tr,
                                  style: fontRegular.copyWith(
                                      color: bluishPurple,
                                      fontSize: fontSize13,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
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
