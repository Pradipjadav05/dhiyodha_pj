import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBusinessRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  MyBusinessRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    return await apiClient.putData(
        editProfileUrl, updateProfileRequestModel.toJson());
  }
}
