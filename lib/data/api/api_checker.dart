import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      // Get.find<AuthenticationViewModel>().clearSharedData();
      Get.offAllNamed(Routes.getAuthenticationPageRoute());
    } else if (response.statusCode == 403) {
      // Get.offAllNamed(Routes.getAuthenticationPageRoute());
    }
  }
}
