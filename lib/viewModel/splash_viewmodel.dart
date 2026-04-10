import 'package:dhiyodha/data/repository/splash_repo.dart';
import 'package:dhiyodha/model/response_model/login_response.dart';
import 'package:dhiyodha/view/pages/authentication_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SplashViewModel extends GetxController implements GetxService {
  final SplashRepo splashRepo;

  SplashViewModel({required this.splashRepo}) {
    // _notification = loginRepo.isNotificationActive();
  }

  DateTime _currentTime = DateTime.now();
  bool _firstTimeConnectionCheck = true;

  DateTime get currentTime => _currentTime;

  set currentTime(DateTime value) {
    _currentTime = value;
  }

  Future<bool> initData() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return true;
  }

  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  set firstTimeConnectionCheck(bool value) {
    _firstTimeConnectionCheck = value;
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  bool isLoggedIn() {
    return splashRepo.isLoggedIn();
  }

  Future<LoginResponse> login() async {
    update();
    Response response = await splashRepo.login();
    LoginResponse responseModel;
    if (response.statusCode == 200) {
      responseModel = new LoginResponse(
          status: response.body['status'], message: response.body['message']);
      await splashRepo.saveAuthToken(response.body['data']['accessToken'],
          response.body['data']['refreshToken']);
    } else {
      responseModel = new LoginResponse();
      await splashRepo.clearSharedData();
      await Get.offAll(new AuthenticationPage());
    }
    update();
    return responseModel;
  }
}
