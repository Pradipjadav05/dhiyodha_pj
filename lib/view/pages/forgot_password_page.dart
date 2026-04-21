import 'package:dhiyodha/utils/resource/app_colors.dart';
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

enum ForgotPasswordStep { enterEmail, verifyOtp, resetPassword }

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final Rx<ForgotPasswordStep> _step =
      ForgotPasswordStep.enterEmail.obs;

  // Email controller (step 1)
  final TextEditingController _emailController = TextEditingController();

  // OTP controllers (step 2)
  final TextEditingController _otp1Controller = TextEditingController();
  final TextEditingController _otp2Controller = TextEditingController();
  final TextEditingController _otp3Controller = TextEditingController();
  final TextEditingController _otp4Controller = TextEditingController();
  final TextEditingController _otp5Controller = TextEditingController();
  final TextEditingController _otp6Controller = TextEditingController();

  // Focus nodes for OTP auto-advance
  final FocusNode _otp1Focus = FocusNode();
  final FocusNode _otp2Focus = FocusNode();
  final FocusNode _otp3Focus = FocusNode();
  final FocusNode _otp4Focus = FocusNode();
  final FocusNode _otp5Focus = FocusNode();
  final FocusNode _otp6Focus = FocusNode();

  // New password controllers (step 3)
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    // Don't call initData() — we don't want to reset the login VM state
    // when navigating back from forgot password to login page
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otp1Controller.dispose();
    _otp2Controller.dispose();
    _otp3Controller.dispose();
    _otp4Controller.dispose();
    _otp5Controller.dispose();
    _otp6Controller.dispose();
    _otp1Focus.dispose();
    _otp2Focus.dispose();
    _otp3Focus.dispose();
    _otp4Focus.dispose();
    _otp5Focus.dispose();
    _otp6Focus.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Image.asset(appLogoLong, width: 120.0),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: GetBuilder<LoginViewModel>(
              builder: (loginVM) {
                return Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'forgot_password'.tr,
                        style: fontBold.copyWith(
                            color: midnightBlue, fontSize: fontSize18),
                      ),
                      const SizedBox(height: paddingSize8),
                      Text(
                        _stepSubtitle(),
                        style: fontRegular.copyWith(
                            color: greyText, fontSize: fontSize14),
                      ),
                      const SizedBox(height: paddingSize40),

                      // ── Step indicator ──
                      _buildStepIndicator(),
                      const SizedBox(height: paddingSize40),

                      // ── Step content ──
                      if (_step.value == ForgotPasswordStep.enterEmail)
                        _buildEnterEmailStep(loginVM),
                      if (_step.value == ForgotPasswordStep.verifyOtp)
                        _buildVerifyOtpStep(loginVM),
                      if (_step.value == ForgotPasswordStep.resetPassword)
                        _buildResetPasswordStep(loginVM),
                    ],
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  String _stepSubtitle() {
    switch (_step.value) {
      case ForgotPasswordStep.enterEmail:
        return 'enter_email_to_reset'.tr;
      case ForgotPasswordStep.verifyOtp:
        return 'enter_otp_sent_to_email'.tr;
      case ForgotPasswordStep.resetPassword:
        return 'enter_new_password'.tr;
    }
  }

  // ── Step indicator ──
  Widget _buildStepIndicator() {
    return Row(
      children: [
        _stepCircle(1, _step.value.index >= 0),
        _stepLine(_step.value.index >= 1),
        _stepCircle(2, _step.value.index >= 1),
        _stepLine(_step.value.index >= 2),
        _stepCircle(3, _step.value.index >= 2),
      ],
    );
  }

  Widget _stepCircle(int number, bool isActive) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? bluishPurple : lavenderMist,
        border: Border.all(
          color: isActive ? bluishPurple : greyText.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '$number',
          style: fontMedium.copyWith(
            fontSize: fontSize14,
            color: isActive ? white : greyText,
          ),
        ),
      ),
    );
  }

  Widget _stepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? bluishPurple : greyText.withOpacity(0.3),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Step 1 — Enter email
  // POST /api/users/forgot/send-otp  →  { "email": "string" }
  // ────────────────────────────────────────────────────────────
  Widget _buildEnterEmailStep(LoginViewModel loginVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'enter_email'.tr,
          style:
          fontMedium.copyWith(color: bluishPurple, fontSize: fontSize14),
        ),
        const SizedBox(height: paddingSize8),
        CommonTextFormField(
          controller: _emailController,
          hintText: 'enter_email_address'.tr,
          inputType: TextInputType.emailAddress,
          padding: EdgeInsets.all(paddingSize20),
          textStyle:
          fontMedium.copyWith(fontSize: fontSize14, color: midnightBlue),
        ),
        const SizedBox(height: paddingSize30),
        loginVM.isLoading
            ? const Center(child: CircularProgressIndicator())
            : CommonButton(
          bgColor: bluishPurple,
          buttonText: 'send_otp'.tr,
          textColor: white,
          onPressed: () async => await _onSendOtp(loginVM),
        ),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────
  // Step 2 — Verify OTP
  // POST /api/users/forgot/verify-otp  →  { "email": "string", "otp": "string" }
  // ────────────────────────────────────────────────────────────
  Widget _buildVerifyOtpStep(LoginViewModel loginVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show masked email for reference
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'otp_sent_to'.tr + ' ',
                style: fontRegular.copyWith(
                    color: greyText, fontSize: fontSize13),
              ),
              TextSpan(
                text: _emailController.text,
                style: fontMedium.copyWith(
                    color: midnightBlue, fontSize: fontSize13),
              ),
            ],
          ),
        ),
        const SizedBox(height: paddingSize20),

        Text(
          'enter_otp_code'.tr,
          style: fontRegular.copyWith(
              fontSize: fontSize14, color: midnightBlue),
        ),
        const SizedBox(height: paddingSize10),

        // 6 OTP boxes
        Row(
          children: [
            _otpBox(_otp1Controller, _otp1Focus, _otp2Focus, null),
            const SizedBox(width: paddingSize8),
            _otpBox(_otp2Controller, _otp2Focus, _otp3Focus, _otp1Focus),
            const SizedBox(width: paddingSize8),
            _otpBox(_otp3Controller, _otp3Focus, _otp4Focus, _otp2Focus),
            const SizedBox(width: paddingSize8),
            _otpBox(_otp4Controller, _otp4Focus, _otp5Focus, _otp3Focus),
            const SizedBox(width: paddingSize8),
            _otpBox(_otp5Controller, _otp5Focus, _otp6Focus, _otp4Focus),
            const SizedBox(width: paddingSize8),
            _otpBox(_otp6Controller, _otp6Focus, null, _otp5Focus),
          ],
        ),

        const SizedBox(height: paddingSize15),

        // Resend OTP
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () async => await _onSendOtp(loginVM, isResend: true),
            child: Text(
              'resend_otp'.tr,
              style: fontMedium.copyWith(
                  fontSize: fontSize13,
                  color: bluishPurple,
                  decoration: TextDecoration.underline),
            ),
          ),
        ),

        const SizedBox(height: paddingSize20),

        loginVM.isLoading
            ? const Center(child: CircularProgressIndicator())
            : CommonButton(
          bgColor: bluishPurple,
          buttonText: 'verify_otp'.tr,
          textColor: white,
          onPressed: () async => await _onVerifyOtp(loginVM),
        ),
      ],
    );
  }

  Widget _otpBox(
      TextEditingController controller,
      FocusNode focusNode,
      FocusNode? nextFocus,
      FocusNode? prevFocus,
      ) {
    return Expanded(
      child: CommonTextFormField(
        controller: controller,
        hintText: '0',
        maxLength: 1,
        maxLines: 1,
        isOTP: true,
        isNumber: true,
        focusNode: focusNode,
        nextFocus: nextFocus,
        inputType: TextInputType.number,
        textStyle:
        fontMedium.copyWith(fontSize: fontSize14, color: bluishPurple),
        padding: EdgeInsets.all(paddingSize14),
        onChanged: (val) {
          if (val.toString().isNotEmpty && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else if (val.toString().isEmpty && prevFocus != null) {
            FocusScope.of(context).requestFocus(prevFocus);
          }
        },
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Step 3 — Reset password
  // PATCH /api/users/forgotPassword
  //   → { "email": "string", "setPassword": "string", "reTypePassword": "string" }
  // ────────────────────────────────────────────────────────────
  Widget _buildResetPasswordStep(LoginViewModel loginVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'new_password'.tr,
          style:
          fontMedium.copyWith(color: bluishPurple, fontSize: fontSize14),
        ),
        const SizedBox(height: paddingSize8),
        CommonTextFormField(
          controller: _newPasswordController,
          hintText: 'enter_new_password'.tr,
          isPassword: true,
          padding: EdgeInsets.all(paddingSize20),
          textStyle:
          fontMedium.copyWith(fontSize: fontSize14, color: midnightBlue),
          onChanged: (val) {
            // validPassCheck calls update() → GetBuilder rebuilds checklist
            loginVM.validPassCheck(val.toString());
          },
        ),

        const SizedBox(height: paddingSize15),

        // Password strength checklist — reads plain bools, inside GetBuilder
        _buildPasswordChecklist(loginVM),

        const SizedBox(height: paddingSize20),

        Text(
          'confirm_password'.tr,
          style:
          fontMedium.copyWith(color: bluishPurple, fontSize: fontSize14),
        ),
        const SizedBox(height: paddingSize8),
        CommonTextFormField(
          controller: _confirmPasswordController,
          hintText: 'confirm_new_password'.tr,
          isPassword: true,
          padding: EdgeInsets.all(paddingSize20),
          textStyle:
          fontMedium.copyWith(fontSize: fontSize14, color: midnightBlue),
        ),

        const SizedBox(height: paddingSize30),

        loginVM.isLoading
            ? const Center(child: CircularProgressIndicator())
            : CommonButton(
          bgColor: bluishPurple,
          buttonText: 'reset_password'.tr,
          textColor: white,
          onPressed: () async => await _onResetPassword(loginVM),
        ),
      ],
    );
  }

  Widget _buildPasswordChecklist(LoginViewModel loginVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _checkItem('min_8_chars'.tr, loginVM.lengthCheck),
        _checkItem('contains_uppercase'.tr, loginVM.uppercaseCheck),
        _checkItem('contains_lowercase'.tr, loginVM.lowercaseCheck),
        _checkItem('contains_number'.tr, loginVM.numberCheck),
        _checkItem('contains_special'.tr, loginVM.spatialCheck),
      ],
    );
  }

  Widget _checkItem(String label, bool isPassed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(
            isPassed ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: isPassed ? Colors.green : greyText,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: fontRegular.copyWith(
              fontSize: fontSize12,
              color: isPassed ? Colors.green : greyText,
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Actions
  // ────────────────────────────────────────────────────────────

  Future<void> _onSendOtp(LoginViewModel loginVM,
      {bool isResend = false}) async {
    final String email = _emailController.text.trim();
    if (email.isEmpty) {
      showSnackBar('enter_email_address'.tr);
      return;
    }
    if (!GetUtils.isEmail(email)) {
      showSnackBar('enter_a_valid_email_address'.tr);
      return;
    }

    final bool isOTPSent = await loginVM.forgotSendOtp(email);
    if (isOTPSent) {
      if (!isResend) {
        _step.value = ForgotPasswordStep.verifyOtp;
      } else {
        // Clear OTP boxes on resend
        _otp1Controller.clear();
        _otp2Controller.clear();
        _otp3Controller.clear();
        _otp4Controller.clear();
        _otp5Controller.clear();
        _otp6Controller.clear();
      }
    } else {
      showSnackBar('forgot_otp_fail_msg'.tr);
    }
  }

  Future<void> _onVerifyOtp(LoginViewModel loginVM) async {
    final bool allFilled = _otp1Controller.text.isNotEmpty &&
        _otp2Controller.text.isNotEmpty &&
        _otp3Controller.text.isNotEmpty &&
        _otp4Controller.text.isNotEmpty &&
        _otp5Controller.text.isNotEmpty &&
        _otp6Controller.text.isNotEmpty;

    if (!allFilled) {
      showSnackBar('enter_valid_otp'.tr);
      return;
    }

    final String otp = _otp1Controller.text +
        _otp2Controller.text +
        _otp3Controller.text +
        _otp4Controller.text +
        _otp5Controller.text +
        _otp6Controller.text;

    final bool isVerified =
    await loginVM.forgotVerifyOtp(_emailController.text.trim(), otp);

    if (isVerified) {
      _step.value = ForgotPasswordStep.resetPassword;
    } else {
      showSnackBar('invalid_OTP'.tr);
    }
  }

  Future<void> _onResetPassword(LoginViewModel loginVM) async {
    final String newPass = _newPasswordController.text;
    final String confirmPass = _confirmPasswordController.text;

    if (newPass.isEmpty) {
      showSnackBar('enter_new_password'.tr);
      return;
    }
    if (!loginVM.lengthCheck ||
        !loginVM.uppercaseCheck ||
        !loginVM.lowercaseCheck ||
        !loginVM.numberCheck ||
        !loginVM.spatialCheck) {
      showSnackBar('password_should_be'.tr);
      return;
    }
    if (newPass != confirmPass) {
      showSnackBar('passwords_do_not_match'.tr);
      return;
    }

    final bool isSuccess = await loginVM.forgotResetPassword(
      email: _emailController.text.trim(),
      setPassword: newPass,
      reTypePassword: confirmPass,
    );

    if (isSuccess) {
      showSnackBar('password_reset_success'.tr, isError: false);
      Get.back();
    } else {
      showSnackBar('errorMessage'.tr);
    }
  }
}
