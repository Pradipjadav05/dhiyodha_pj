import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembersRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  MembersRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getUsersOrMembers(
      int page, int size, String? sort, String? orderBy, String? search) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{
      "page": page,
      "size": size,
      "sort": sort,
      "sortDirection": orderBy,
      "search": search
    });
    return await apiClient.getData(
        '$getMembersUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }

  Future<Response> searchType(String? searchType, String? search) async {
    return await apiClient
        .getData('$searchTypeUrl?searchType=$searchType&name=$search');
  }

  Future<Response> getGroups(
      int page, int size, String? sort, String? orderBy, String? search) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{
      "page": page,
      "size": size,
      "sort": sort,
      "sortDirection": orderBy,
      "search": search
    });
    return await apiClient.getData(
        '$groupsUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }

  Future<Response> getWorldWideSearchedUsersOrMembers(
      String? city,
      String? state,
      String? country,
      String? name,
      String? businessCategory,
      String? chapter) async {
    String queryParams = "";
    if (city != null && city.isNotEmpty) {
      queryParams = "city=$city";
    }
    if (state != null && state.isNotEmpty) {
      queryParams = queryParams.isNotEmpty
          ? queryParams + "&state=$state"
          : "state=$state";
    }
    if (country != null && country.isNotEmpty) {
      queryParams = queryParams.isNotEmpty
          ? queryParams + "&country=$country"
          : "country=$country";
    }
    if (name != null && name.isNotEmpty) {
      queryParams =
          queryParams.isNotEmpty ? queryParams + "&name=$name" : "name=$name";
    }
    if (businessCategory != null && businessCategory.isNotEmpty) {
      queryParams = queryParams.isNotEmpty
          ? queryParams +
              "&businessCategory=${businessCategory.trim().replaceAll(" ", "")}"
          : "businessCategory=${businessCategory.trim().replaceAll(" ", "")}";
    }
    if (chapter != null && chapter.isNotEmpty) {
      queryParams = queryParams.isNotEmpty
          ? queryParams + "&chapter=${chapter.trim().replaceAll(" ", "")}"
          : "chapter=${chapter.trim().replaceAll(" ", "")}";
    }

    return await apiClient.getData('$filtersUrl?$queryParams');
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

  Future<Response> getUserTestimonial(String userid) async {
    return await apiClient.getData('${userTestimonialUrl}${userid}');
  }
}
