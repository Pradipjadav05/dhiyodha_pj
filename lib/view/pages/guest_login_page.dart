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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

class GuestLoginPage extends StatefulWidget {
  const GuestLoginPage({Key? key}) : super(key: key);

  @override
  GuestLoginPageState createState() => GuestLoginPageState();
}

class GuestLoginPageState extends State<GuestLoginPage> {
  // Focus nodes for 6-digit OTP auto-advance
  final FocusNode _otp1Focus = FocusNode();
  final FocusNode _otp2Focus = FocusNode();
  final FocusNode _otp3Focus = FocusNode();
  final FocusNode _otp4Focus = FocusNode();
  final FocusNode _otp5Focus = FocusNode();
  final FocusNode _otp6Focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _initAPIs();
  }

  Future<void> _initAPIs() async {
    Get.find<LoginViewModel>().initData();
  }

  @override
  void dispose() {
    _otp1Focus.dispose();
    _otp2Focus.dispose();
    _otp3Focus.dispose();
    _otp4Focus.dispose();
    _otp5Focus.dispose();
    _otp6Focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GetBuilder<LoginViewModel>(
                builder: (loginVM) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Headline ──
                      Text(
                        'the_strength_nation'.tr,
                        style: fontBold.copyWith(
                          color: midnightBlue,
                          fontSize: fontSize18,
                        ),
                      ),

                      const SizedBox(height: 80.0),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Phone Number + Send OTP ──
                          Obx(
                                () => Column(
                              children: [
                                // Phone input
                                CommonTextFormField(
                                  controller: loginVM.mobileNoController,
                                  hintText: 'enter_phone_number'.tr,
                                  maxLength: 10,
                                  maxLines: 1,
                                  inputType: TextInputType.number,
                                  isNumber: true,
                                  textStyle: fontMedium.copyWith(
                                    fontSize: fontSize14,
                                    color: bluishPurple,
                                  ),
                                  padding: EdgeInsets.all(paddingSize20),
                                  prefixIcon: Align(
                                    widthFactor: 0,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        '+91',
                                        style: fontMedium.copyWith(
                                          fontSize: fontSize14,
                                          color: bluishPurple,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: paddingSize25),

                                // Send OTP button / loader
                                loginVM.isLoading
                                    ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                    : CommonButton(
                                  bgColor:
                                  loginVM.isAgreeTerms.value == true
                                      ? bluishPurple
                                      : greyText,
                                  buttonText: 'send_otp'.tr,
                                  onPressed: () async {
                                    await _onSendOtpPressed(loginVM);
                                  },
                                  textColor: white,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: paddingSize25),

                          // ── 6-Digit OTP Section ──
                          Obx(
                                () => Visibility(
                              visible: loginVM.isMobileNumberValid.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'enter_otp_code'.tr,
                                    style: fontRegular.copyWith(
                                      fontSize: fontSize14,
                                      color: midnightBlue,
                                    ),
                                  ),

                                  const SizedBox(height: paddingSize10),

                                  // 6 OTP boxes
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Box 1
                                      Expanded(
                                        child: CommonTextFormField(
                                          controller: loginVM.otp1Controller,
                                          hintText: '0',
                                          maxLength: 1,
                                          maxLines: 1,
                                          isOTP: true,
                                          isNumber: true,
                                          focusNode: _otp1Focus,
                                          nextFocus: _otp2Focus,
                                          inputType: TextInputType.number,
                                          textStyle: fontMedium.copyWith(
                                            fontSize: fontSize14,
                                            color: bluishPurple,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          onChanged: (val) {
                                            if (val.toString().isNotEmpty) {
                                              FocusScope.of(context).requestFocus(_otp2Focus);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: paddingSize8),
                                      // Box 2
                                      Expanded(
                                        child: CommonTextFormField(
                                          controller: loginVM.otp2Controller,
                                          hintText: '0',
                                          maxLength: 1,
                                          maxLines: 1,
                                          isOTP: true,
                                          isNumber: true,
                                          focusNode: _otp2Focus,
                                          nextFocus: _otp3Focus,
                                          inputType: TextInputType.number,
                                          textStyle: fontMedium.copyWith(
                                            fontSize: fontSize14,
                                            color: bluishPurple,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          onChanged: (val) {
                                            if (val.toString().isNotEmpty) {
                                              FocusScope.of(context).requestFocus(_otp3Focus);
                                            } else {
                                              FocusScope.of(context).requestFocus(_otp1Focus);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: paddingSize8),
                                      // Box 3
                                      Expanded(
                                        child: CommonTextFormField(
                                          controller: loginVM.otp3Controller,
                                          hintText: '0',
                                          maxLength: 1,
                                          maxLines: 1,
                                          isOTP: true,
                                          isNumber: true,
                                          focusNode: _otp3Focus,
                                          nextFocus: _otp4Focus,
                                          inputType: TextInputType.number,
                                          textStyle: fontMedium.copyWith(
                                            fontSize: fontSize14,
                                            color: bluishPurple,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          onChanged: (val) {
                                            if (val.toString().isNotEmpty) {
                                              FocusScope.of(context).requestFocus(_otp4Focus);
                                            } else {
                                              FocusScope.of(context).requestFocus(_otp2Focus);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: paddingSize8),
                                      // Box 4
                                      Expanded(
                                        child: CommonTextFormField(
                                          controller: loginVM.otp4Controller,
                                          hintText: '0',
                                          maxLength: 1,
                                          maxLines: 1,
                                          isOTP: true,
                                          isNumber: true,
                                          focusNode: _otp4Focus,
                                          nextFocus: _otp5Focus,
                                          inputType: TextInputType.number,
                                          textStyle: fontMedium.copyWith(
                                            fontSize: fontSize14,
                                            color: bluishPurple,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          onChanged: (val) {
                                            if (val.toString().isNotEmpty) {
                                              FocusScope.of(context).requestFocus(_otp5Focus);
                                            } else {
                                              FocusScope.of(context).requestFocus(_otp3Focus);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: paddingSize8),
                                      // Box 5
                                      Expanded(
                                        child: CommonTextFormField(
                                          controller: loginVM.otp5Controller,
                                          hintText: '0',
                                          maxLength: 1,
                                          maxLines: 1,
                                          isOTP: true,
                                          isNumber: true,
                                          focusNode: _otp5Focus,
                                          nextFocus: _otp6Focus,
                                          inputType: TextInputType.number,
                                          textStyle: fontMedium.copyWith(
                                            fontSize: fontSize14,
                                            color: bluishPurple,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          onChanged: (val) {
                                            if (val.toString().isNotEmpty) {
                                              FocusScope.of(context).requestFocus(_otp6Focus);
                                            } else {
                                              FocusScope.of(context).requestFocus(_otp4Focus);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: paddingSize8),
                                      // Box 6
                                      Expanded(
                                        child: CommonTextFormField(
                                          controller: loginVM.otp6Controller,
                                          hintText: '0',
                                          maxLength: 1,
                                          maxLines: 1,
                                          isOTP: true,
                                          isNumber: true,
                                          focusNode: _otp6Focus,
                                          inputType: TextInputType.number,
                                          textStyle: fontMedium.copyWith(
                                            fontSize: fontSize14,
                                            color: bluishPurple,
                                          ),
                                          padding: EdgeInsets.all(0),
                                          onChanged: (val) {
                                            if (val.toString().isEmpty) {
                                              FocusScope.of(context).requestFocus(_otp5Focus);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: paddingSize25),

                                  // Verify OTP button / loader
                                  loginVM.isLoading
                                      ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                      : CommonButton(
                                    bgColor:
                                    loginVM.isAgreeTerms.value == true
                                        ? bluishPurple
                                        : greyText,
                                    buttonText: 'verify_otp'.tr,
                                    onPressed: () async {
                                      await _onVerifyOtpPressed(loginVM);
                                    },
                                    textColor: white,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: paddingSize40),

                          // ── Terms & Conditions ──
                          Center(
                            child: Obx(
                                  () => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GFCheckbox(
                                    inactiveBgColor: lavenderMist,
                                    inactiveBorderColor: bluishPurple,
                                    activeBorderColor: bluishPurple,
                                    value: loginVM.isAgreeTerms.value,
                                    activeBgColor: bluishPurple,
                                    size: 22.0,
                                    onChanged: (value) {
                                      loginVM.isAgreeTerms.value = value;
                                    },
                                  ),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${"i_accept".tr} ',
                                            style: fontRegular.copyWith(
                                              color: black,
                                              fontSize: fontSize14,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'terms'.tr,
                                            style: fontRegular.copyWith(
                                              color: bluishPurple,
                                              fontSize: fontSize14,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.toNamed(
                                                  Routes.getWebViewPageRoute(queryWebUrl),
                                                );
                                              },
                                          ),
                                        ],
                                      ),
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
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Send OTP logic ──
  Future<void> _onSendOtpPressed(LoginViewModel loginVM) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final String phone = loginVM.mobileNoController.text.trim();

    if (phone.isEmpty || phone.length < 10) {
      showSnackBar('enter_a_valid_phone_number'.tr);
      return;
    }

    if (!loginVM.isAgreeTerms.value) {
      showSnackBar('accept_terms'.tr);
      return;
    }

    final bool isSuccess = await loginVM.guestLogin(phone);

    if (isSuccess) {
      final bool isOTPSent = await loginVM.sendOtp(phone, '91');
      if (isOTPSent) {
        loginVM.isMobileNumberValid.value = true;
      } else {
        showSnackBar('otp_fail_msg'.tr);
      }
    } else {
      loginVM.isMobileNumberValid.value = false;
      showSnackBar('wrong_mobile_number'.tr);
    }
  }

  // ── Verify OTP logic ──
  Future<void> _onVerifyOtpPressed(LoginViewModel loginVM) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final bool allFilled = loginVM.otp1Controller.text.isNotEmpty &&
        loginVM.otp2Controller.text.isNotEmpty &&
        loginVM.otp3Controller.text.isNotEmpty &&
        loginVM.otp4Controller.text.isNotEmpty &&
        loginVM.otp5Controller.text.isNotEmpty &&
        loginVM.otp6Controller.text.isNotEmpty;

    if (allFilled && loginVM.isAgreeTerms.value) {
      final String otp = loginVM.otp1Controller.text +
          loginVM.otp2Controller.text +
          loginVM.otp3Controller.text +
          loginVM.otp4Controller.text +
          loginVM.otp5Controller.text +
          loginVM.otp6Controller.text;

      final bool isOTPVerified = await loginVM.verifyOTP(
        loginVM.mobileNoController.text,
        '91',
        otp,
      );

      if (isOTPVerified) {
        Get.toNamed(Routes.getGuestDashboardPageRoute());
      } else {
        showSnackBar('invalid_OTP'.tr);
      }
    } else {
      if (!loginVM.isAgreeTerms.value) {
        showSnackBar('accept_terms'.tr);
      } else {
        showSnackBar('enter_valid_otp'.tr);
      }
    }
  }
}