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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    Get.find<LoginViewModel>().initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Image.asset(appLogoLong, width: 120.0),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GetBuilder<LoginViewModel>(builder: (loginVM) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'the_strength_nation'.tr,
                      style: fontBold.copyWith(
                          color: midnightBlue, fontSize: fontSize18),
                    ),
            
                    const SizedBox(height: paddingSize40),
            
                    // ── Email ──
                    CommonTextFormField(
                      controller: loginVM.emailController,
                      hintText: 'enter_email'.tr,
                      inputType: TextInputType.emailAddress,
                      padding: EdgeInsets.all(paddingSize20),
                    ),
            
                    const SizedBox(height: paddingSize25),
            
                    // ── Password ──
                    CommonTextFormField(
                      controller: loginVM.passwordController,
                      hintText: 'enter_password'.tr,
                      isPassword: true,
                      padding: EdgeInsets.all(paddingSize20),
                    ),
            
                    const SizedBox(height: paddingSize10),
            
                    // ── Forgot Password link ──
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.getForgotPasswordPageRoute());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: paddingSize8),
                          child: Text(
                            'forgot_password'.tr,
                            style: fontMedium.copyWith(
                              color: bluishPurple,
                              fontSize: fontSize13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
            
                    const SizedBox(height: paddingSize25),
            
                    // ── Terms & Conditions ──
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                        color: black, fontSize: fontSize14),
                                  ),
                                  TextSpan(
                                    text: 'terms'.tr,
                                    style: fontRegular.copyWith(
                                        color: bluishPurple,
                                        fontSize: fontSize14,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.getWebViewPageRoute(
                                            queryWebUrl));
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            
                    const SizedBox(height: paddingSize40),
            
                    // ── Login button ──
                    Obx(
                      () => loginVM.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CommonButton(
                              bgColor: loginVM.isAgreeTerms.value == true
                                  ? bluishPurple
                                  : greyText,
                              buttonText: 'continue'.tr,
                              onPressed: () async {
                                await _login(loginVM);
                              },
                              textColor: white,
                            ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(LoginViewModel loginVM) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String email = loginVM.emailController.value.text.trim();
    String password = loginVM.passwordController.value.text.trim();
    if (email.isEmpty) {
      showSnackBar('enter_email_address'.tr);
    } else if (!GetUtils.isEmail(email)) {
      showSnackBar('enter_a_valid_email_address'.tr);
    } else if (password.isEmpty) {
      showSnackBar('enter_password'.tr);
    } else if (password.length < 6) {
      showSnackBar('password_should_be'.tr);
    } else if (loginVM.isAgreeTerms.value == false) {
      showSnackBar("accept_terms".tr);
    } else {
      final status = await loginVM.login(email, password);

      if (status.status == "OK") {
        Get.offAllNamed(Routes.getHomePageRoute());
      } else {
        if (!mounted) return;

        showSnackBar(
          status.message ?? "Invalid credentials. Please try again.",
        );
      }
    }
  }
}
