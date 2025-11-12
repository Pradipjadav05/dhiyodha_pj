import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProfileRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> updatePassword(
      String oldPassword, String newPassword, String retypePassword) async {
    return await apiClient.putData(
      updatePasswordUrl,
      {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "retypePassword": retypePassword,
      },
    );
  }
}
