import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';
// import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisitorsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  VisitorsRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getVisitors(
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
        '$visitorsUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }

  Future<Response> uploadImageDocument(
      String? documentType, XFile selectedImage) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{});
    return await apiClient.postMultipartData(
        '$uploadDocumentUrl?documentType=$documentType',
        {},
        [MultipartBody('file', selectedImage)]);
  }

  Future<Response> addVisitors(
      String? country,
      String? state,
      String? city,
      String? groupName,
      String? meetingCode,
      String? meetingTitle,
      String? date,
      String? businessCategory,
      String? name,
      String? email,
      String? contactNumber,
      String? companyName,
      String? addedBy,
      String? profileUrl,
      String? uploadFrontVisitingCard,
      String? uploadBackVisitingCard) async {
    return await apiClient.postData(addVisitorsUrl, {
      "country": country,
      "state": state,
      "city": city,
      "groupName": groupName,
      "chapter": groupName, // extra
      "meetingCode": meetingCode,
      "meetingTitle": meetingTitle,
      "title": meetingTitle,
      "date": date,
      "referral": "INSIDE",
      "status": true,
      "businessCategory": businessCategory,
      "name": name,
      "email": email,
      "contactNumber": contactNumber,
      "companyName": companyName,
      "addedBy": addedBy,
      "profileUrl": profileUrl,
      "uploadFrontVisitingCard": uploadFrontVisitingCard,
      "uploadBackVisitingCard": uploadBackVisitingCard,
    });
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

  Future<Response> getCountries() async {
    return await apiClient.getData(countryListUrl);
  }

  Future<Response> getStates(String countryName) async {
    return await apiClient.getData('${stateListUrl}${countryName}/ACTIVE');
  }

  Future<Response> getCities(String stateName) async {
    return await apiClient.getData('${cityListUrl}${stateName}/ACTIVE');
  }

  Future<Response> getBusinessCategories() async {
    return await apiClient.getData(businessCategoriesUrl);
  }

  Future<Response> markVisitorAttendance({
    required String visitorUuid,
    required double latitude,
    required double longitude,
  }) async {
    return await apiClient.postData(
      visitorAttendanceUrl,
      {
        "visitorUuid": visitorUuid,
        "latitude": latitude,
        "longitude": longitude,
      },
    );
  }
}
