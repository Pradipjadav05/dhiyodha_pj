import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AddressRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    return await apiClient.putData(
        editProfileUrl, updateProfileRequestModel.toJson());
  }

  Future<Response> getCountries() async {
    return await apiClient.getData(countryListUrl);
  }

  Future<Response> getStates(String countryName) async {
    return await apiClient.getData('${stateListUrl}${countryName}');
  }

  Future<Response> getCities(String stateName) async {
    return await apiClient.getData('${cityListUrl}${stateName}');
  }
}
