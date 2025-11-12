import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/login_repo.dart';
import 'package:dhiyodha/model/response_model/login_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginViewModel extends GetxController implements GetxService {
  final LoginRepo loginRepo;

  LoginViewModel({required this.loginRepo}) {
    // _notification = loginRepo.isNotificationActive();
  }

  RxBool _isAgreeTerms = false.obs;
  RxBool _isMobileNumberValid = false.obs;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileNoController = TextEditingController();
  TextEditingController _otp1Controller = TextEditingController();
  TextEditingController _otp2Controller = TextEditingController();
  TextEditingController _otp3Controller = TextEditingController();
  TextEditingController _otp4Controller = TextEditingController();
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

  Future<void> initData() async {
    _isAgreeTerms = false.obs;
    isMobileNumberValid = false.obs;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _mobileNoController = TextEditingController();
    _otp1Controller = TextEditingController();
    _otp2Controller = TextEditingController();
    _otp3Controller = TextEditingController();
    _otp4Controller = TextEditingController();
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

  TextEditingController get otp1Controller => _otp1Controller;

  set otp1Controller(TextEditingController value) {
    _otp1Controller = value;
  }

  TextEditingController get mobileNoController => _mobileNoController;

  set mobileNoController(TextEditingController value) {
    _mobileNoController = value;
  }

  RxBool get isMobileNumberValid => _isMobileNumberValid;

  set isMobileNumberValid(RxBool value) {
    _isMobileNumberValid = value;
  }

  bool get isLoading => _isLoading;

  bool get notification => _notification;

  XFile? get pickedFile => _pickedFile;

  XFile? get pickedLogo => _pickedLogo;

  XFile? get pickedCover => _pickedCover;

  bool get loading => _loading;

  // List<ModuleModel>? get moduleList => _moduleList;
  bool get lengthCheck => _lengthCheck;

  bool get numberCheck => _numberCheck;

  bool get uppercaseCheck => _uppercaseCheck;

  bool get lowercaseCheck => _lowercaseCheck;

  bool get spatialCheck => _spatialCheck;

  set isAgreeTerms(value) {
    _isAgreeTerms = value;
  }

  get isAgreeTerms => _isAgreeTerms;

  void validPassCheck(String pass, {bool isUpdate = true}) {
    _lengthCheck = false;
    _numberCheck = false;
    _uppercaseCheck = false;
    _lowercaseCheck = false;
    _spatialCheck = false;

    if (pass.length > 7) {
      _lengthCheck = true;
    }
    if (pass.contains(RegExp(r'[a-z]'))) {
      _lowercaseCheck = true;
    }
    if (pass.contains(RegExp(r'[A-Z]'))) {
      _uppercaseCheck = true;
    }
    if (pass.contains(RegExp(r'[ .!@#$&*~^%]'))) {
      _spatialCheck = true;
    }
    if (pass.contains(RegExp(r'[\d+]'))) {
      _numberCheck = true;
    }
    if (isUpdate) {
      update();
    }
  }

  Future<LoginResponse> login(String? email, String password) async {
    _isLoading = true;
    update();
    Response response = await loginRepo.login(email, password);
    LoginResponse responseModel;
    if (response.statusCode == 200) {
      // // getProfile();
      responseModel = new LoginResponse(
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

  Future<bool> guestLogin(String mobileNumber) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    Response response = await loginRepo.guestLogin(mobileNumber);
    _isLoading = false;
    if (response.statusCode == 201) {
      isSuccess = true;
      // // getProfile();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  Future<bool> sendOtp(String mobileNumber, String countryCode) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    Response response = await loginRepo.sendOTP(mobileNumber, countryCode);
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  Future<bool> verifyOTP(
      String mobileNumber, String countryCode, String OTP) async {
    _isLoading = true;
    update();
    bool isSuccess = false;
    Response response =
        await loginRepo.verifyOTP(mobileNumber, countryCode, OTP);
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  // Future<void> getProfile() async {
  //   Response response = await loginRepo.getProfileInfo();
  //   if (response.statusCode == 200) {
  //     _profileModel = ProfileModel.fromJson(response.body);
  //     Get.find<SplashController>().setModule(_profileModel!.stores![0].module!.id, _profileModel!.stores![0].module!.moduleType);
  //     loginRepo.updateHeader(_profileModel!.stores![0].module!.id);
  //     allowModulePermission(_profileModel!.roles);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  // Future<bool> updateUserInfo(ProfileModel updateUserModel, String token) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await loginRepo.updateProfile(updateUserModel, _pickedFile, token);
  //   _isLoading = false;
  //   bool isSuccess;
  //   if (response.statusCode == 200) {
  //     _profileModel = updateUserModel;
  //     showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
  //     isSuccess = true;
  //   } else {
  //     ApiChecker.checkApi(response);
  //     isSuccess = false;
  //   }
  //   update();
  //   return isSuccess;
  // }

  void pickImage() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _pickedFile = picked;
    }
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

  // Future<bool> changePassword(ProfileModel updatedUserModel, String password) async {
  //   _isLoading = true;
  //   update();
  //   bool isSuccess;
  //   Response response = await loginRepo.changePassword(updatedUserModel, password);
  //   _isLoading = false;
  //   if (response.statusCode == 200) {
  //     Get.back();
  //     showCustomSnackBar('password_updated_successfully'.tr, isError: false);
  //     isSuccess = true;
  //   } else {
  //     ApiChecker.checkApi(response);
  //     isSuccess = false;
  //   }
  //   update();
  //   return isSuccess;
  // }

  // Future<ResponseModel> forgetPassword(String? email) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await loginRepo.forgetPassword(email);
  //
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }
  //
  // Future<void> updateToken() async {
  //   await loginRepo.updateToken();
  // }

  // Future<ResponseModel> verifyToken(String? email) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await loginRepo.verifyToken(email, _verificationCode);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> resetPassword(String? resetToken, String? email, String password, String confirmPassword) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await loginRepo.resetPassword(resetToken, email, password, confirmPassword);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return loginRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    // Get.find<SplashController>().setModule(null, null);
    return await loginRepo.clearSharedData();
  }

  // void saveUserNumberAndPassword(String number, String password, String type) {
  //   loginRepo.saveUserNumberAndPassword(number, password, type);
  // }
  //
  // String getUserNumber() {
  //   return loginRepo.getUserNumber();
  // }
  //
  // String getUserPassword() {
  //   return loginRepo.getUserPassword();
  // }
  //
  // String getUserType() {
  //   return loginRepo.getUserType();
  // }
  //
  // Future<bool> clearUserNumberAndPassword() async {
  //   return loginRepo.clearUserNumberAndPassword();
  // }
  //
  // String getUserToken() {
  //   return loginRepo.getUserToken();
  // }
  //
  // bool setNotificationActive(bool isActive) {
  //   _notification = isActive;
  //   loginRepo.setNotificationActive(isActive);
  //   update();
  //   return _notification;
  // }

  TextEditingController get passwordController => _passwordController;

  set passwordController(TextEditingController value) {
    _passwordController = value;
  }

  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController value) {
    _emailController = value;
  }

  TextEditingController get otp2Controller => _otp2Controller;

  set otp2Controller(TextEditingController value) {
    _otp2Controller = value;
  }

  TextEditingController get otp3Controller => _otp3Controller;

  set otp3Controller(TextEditingController value) {
    _otp3Controller = value;
  }

  TextEditingController get otp4Controller => _otp4Controller;

  set otp4Controller(TextEditingController value) {
    _otp4Controller = value;
  }
}
