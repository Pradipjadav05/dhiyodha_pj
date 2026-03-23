import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/login_repo.dart';
import 'package:dhiyodha/model/response_model/login_response.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginViewModel extends GetxController implements GetxService {
  final LoginRepo loginRepo;

  LoginViewModel({required this.loginRepo});

  RxBool _isAgreeTerms = false.obs;
  RxBool _isMobileNumberValid = false.obs;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileNoController = TextEditingController();
  TextEditingController _otp1Controller = TextEditingController();
  TextEditingController _otp2Controller = TextEditingController();
  TextEditingController _otp3Controller = TextEditingController();
  TextEditingController _otp4Controller = TextEditingController();
  TextEditingController _otp5Controller = TextEditingController();
  TextEditingController _otp6Controller = TextEditingController();
  bool _isLoading = false;
  bool _notification = true;
  XFile? _pickedFile;
  XFile? _pickedLogo;
  XFile? _pickedCover;
  bool _loading = false;
  bool _lengthCheck = false;
  bool _numberCheck = false;
  bool _uppercaseCheck = false;
  bool _lowercaseCheck = false;
  bool _spatialCheck = false;

  // ── Getters ──
  RxBool get isAgreeTerms => _isAgreeTerms;
  RxBool get isMobileNumberValid => _isMobileNumberValid;
  bool get isLoading => _isLoading;
  bool get notification => _notification;
  XFile? get pickedFile => _pickedFile;
  XFile? get pickedLogo => _pickedLogo;
  XFile? get pickedCover => _pickedCover;
  bool get loading => _loading;
  bool get lengthCheck => _lengthCheck;
  bool get numberCheck => _numberCheck;
  bool get uppercaseCheck => _uppercaseCheck;
  bool get lowercaseCheck => _lowercaseCheck;
  bool get spatialCheck => _spatialCheck;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get mobileNoController => _mobileNoController;
  TextEditingController get otp1Controller => _otp1Controller;
  TextEditingController get otp2Controller => _otp2Controller;
  TextEditingController get otp3Controller => _otp3Controller;
  TextEditingController get otp4Controller => _otp4Controller;
  TextEditingController get otp5Controller => _otp5Controller;
  TextEditingController get otp6Controller => _otp6Controller;
  String get verificationCode => _verificationCode;
  bool get isActiveRememberMe => _isActiveRememberMe;

  // ── Setters ──
  set isAgreeTerms(value) => _isAgreeTerms = value;
  set isMobileNumberValid(RxBool v) => _isMobileNumberValid = v;
  set emailController(TextEditingController v) => _emailController = v;
  set passwordController(TextEditingController v) => _passwordController = v;
  set mobileNoController(TextEditingController v) => _mobileNoController = v;
  set otp1Controller(TextEditingController v) => _otp1Controller = v;
  set otp2Controller(TextEditingController v) => _otp2Controller = v;
  set otp3Controller(TextEditingController v) => _otp3Controller = v;
  set otp4Controller(TextEditingController v) => _otp4Controller = v;
  set otp5Controller(TextEditingController v) => _otp5Controller = v;
  set otp6Controller(TextEditingController v) => _otp6Controller = v;

  Future<void> initData() async {
    _isAgreeTerms = false.obs;
    _isMobileNumberValid = false.obs;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _mobileNoController = TextEditingController();
    _otp1Controller = TextEditingController();
    _otp2Controller = TextEditingController();
    _otp3Controller = TextEditingController();
    _otp4Controller = TextEditingController();
    _otp5Controller = TextEditingController();
    _otp6Controller = TextEditingController();
    _isLoading = false;
    _notification = true;
    _pickedFile = null;
    _pickedLogo = null;
    _pickedCover = null;
    _loading = false;
    _lengthCheck = false;
    _numberCheck = false;
    _uppercaseCheck = false;
    _lowercaseCheck = false;
    _spatialCheck = false;
  }

  void validPassCheck(String pass, {bool isUpdate = true}) {
    _lengthCheck = pass.length > 7;
    _lowercaseCheck = pass.contains(RegExp(r'[a-z]'));
    _uppercaseCheck = pass.contains(RegExp(r'[A-Z]'));
    _spatialCheck = pass.contains(RegExp(r'[ .!@#$&*~^%]'));
    _numberCheck = pass.contains(RegExp(r'[\d+]'));
    if (isUpdate) update();
  }

  // ────────────────────────────────────────────────────────────
  // Login
  // ────────────────────────────────────────────────────────────
  Future<LoginResponse> login(String? email, String password) async {
    _isLoading = true;
    update();
    final Response response = await loginRepo.login(email, password);
    LoginResponse responseModel;
    if (response.statusCode == 200) {
      responseModel = LoginResponse(
          timestamp: response.body['timestamp'],
          status: response.body['status'],
          message: response.body['message']);
      await loginRepo.saveAuthToken(response.body['data']['accessToken'],
          response.body['data']['refreshToken'], email, password);
    } else {
      responseModel = LoginResponse(
          timestamp: response.body['timestamp'],
          status: response.body['status'],
          message: response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // ────────────────────────────────────────────────────────────
  // Guest login
  // ────────────────────────────────────────────────────────────
  Future<bool> guestLogin(String mobileNumber) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    final Response response = await loginRepo.guestLogin(mobileNumber);
    _isLoading = false;
    if (response.statusCode == 201) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  // ────────────────────────────────────────────────────────────
  // Guest OTP (used by GuestLoginPage)
  // ────────────────────────────────────────────────────────────
  Future<bool> sendOtp(String mobileNumber, String countryCode) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    final Response response =
    await loginRepo.sendOTP(mobileNumber, countryCode);
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
      showSnackBar('${response.body["message"]}', isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  Future<bool> verifyOTP(
      String mobileNumber, String countryCode, String otp) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    final Response response =
    await loginRepo.verifyOTP(mobileNumber, countryCode, otp);
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  // ────────────────────────────────────────────────────────────
  // Forgot Password — Step 1
  // POST /api/users/forgot/send-otp  →  { "email": "string" }
  // ────────────────────────────────────────────────────────────
  Future<bool> forgotSendOtp(String email) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    final Response response = await loginRepo.forgotSendOtp(email);
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
      showSnackBar('${response.body["message"]}', isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  // ────────────────────────────────────────────────────────────
  // Forgot Password — Step 2
  // POST /api/users/forgot/verify-otp  →  { "email": "string", "otp": "string" }
  // ────────────────────────────────────────────────────────────
  Future<bool> forgotVerifyOtp(String email, String otp) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    final Response response = await loginRepo.forgotVerifyOtp(email, otp);
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  // ────────────────────────────────────────────────────────────
  // Forgot Password — Step 3
  // PATCH /api/users/forgotPassword
  //   → { "email": "string", "setPassword": "string", "reTypePassword": "string" }
  // ────────────────────────────────────────────────────────────
  Future<bool> forgotResetPassword({
    required String email,
    required String setPassword,
    required String reTypePassword,
  }) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    final Response response = await loginRepo.forgotResetPassword(
      email: email,
      setPassword: setPassword,
      reTypePassword: reTypePassword,
    );
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  // ────────────────────────────────────────────────────────────
  // Update Password (logged-in user)
  // PUT /api/users/update-password
  // Body: { "oldPassword", "newPassword", "retypePassword" }
  // ────────────────────────────────────────────────────────────
  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String retypePassword,
  }) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    final Response response = await loginRepo.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      retypePassword: retypePassword,
    );
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  void pickImage() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) _pickedFile = picked;
    update();
  }

  void pickImageForReg(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickedLogo = null;
      _pickedCover = null;
    } else {
      if (isLogo) {
        _pickedLogo =
        await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        _pickedCover =
        await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      update();
    }
  }

  String _verificationCode = '';
  bool _isActiveRememberMe = false;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() => loginRepo.isLoggedIn();
  Future<bool> clearSharedData() async => await loginRepo.clearSharedData();
}