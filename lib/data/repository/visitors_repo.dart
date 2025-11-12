import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/model/response_model/add_upload_operation_response_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
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
      String? uuId,
      String? country,
      String? state,
      String? city,
      String? chapter,
      String? date,
      String? businessCategory,
      String? name,
      String? contactNumber,
      String? companyName,
      String? addedBy,
      String? groupName,
      String? title,
      String? meetingCode,
      String? meetingDate,
      String? referral,
      String? email,
      UploadedDocRespModel? uploadedDoc) async {
    return await apiClient.postData(addVisitorsUrl, {
      "country": country,
      "state": state,
      "city": city,
      "chapter": chapter,
      "date": date,
      "businessCategory": businessCategory,
      "name": name,
      "email": email,
      "contactNumber": contactNumber,
      "companyName": companyName,
      "addedBy": addedBy,
      "groupName": groupName,
      "meetingCode": meetingCode,
      "title": title ?? "Team Meeting",
      // "meetingDate": '${meetingDate}T00:00:00.000Z',
      "meetingDate": '',
      // "uuId": uuId,
      // "referral": referral,
      "documents": uploadedDoc != null &&
              uploadedDoc.documentUuid != null &&
              uploadedDoc.documentUuid!.isNotEmpty
          ? uploadedDoc.getOnlyDocUuid() ?? ""
          : null,
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
    return await apiClient.getData('${stateListUrl}${countryName}');
  }

  Future<Response> getCities(String stateName) async {
    return await apiClient.getData('${cityListUrl}${stateName}');
  }
}
