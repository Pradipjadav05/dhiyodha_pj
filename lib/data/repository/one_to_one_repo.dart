import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/model/response_model/tyfcb_response_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OneToOneRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OneToOneRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> addOneToOneData(
      String? connectedWith,
      String? initiatedBy,
      Location oneToOneLocation,
      String? oneToOneDate,
      String? oneToOneNotes) async {
    return await apiClient.postData(addOneToOneUrl, {
      "connectedWith": connectedWith,
      "initiatedBy": initiatedBy,
      "oneToOneLocation": oneToOneLocation.toJson(),
      "oneToOneDate": oneToOneDate,
      "oneToOneNotes": oneToOneNotes
    });
    // , headers: {
    // "Accept": "application/json",
    // "Content-Type": "application/json",
    // }
  }

  // Future<Response> getReferralData(
  //     int page, int size, String? sort, String? orderBy, String? search) async {
  //   Map<String, dynamic> queryParameters = Map<String, dynamic>();
  //   queryParameters.addAll(<String, dynamic>{
  //     "page": page,
  //     "size": size,
  //     "sort": sort,
  //     "sortDirection": orderBy,
  //     "search": search
  //   });
  //   return await apiClient.getData('$referralUrl?page=$page&size=$size');
  //   // return await apiClient.getData('$askListUrl?page=$page&size=$size');
  // }
}
