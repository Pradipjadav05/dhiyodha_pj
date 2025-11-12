import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ReferralRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> addReferralsData(
      String? referralTo,
      String? type,
      List<String?> status,
      String? referral,
      String? telephone,
      String? email,
      String? address,
      String? comment,
      int? rate) async {
    return await apiClient.postData(addReferralsUrl, {
      "referralTo": referralTo,
      "type": type,
      "status": status,
      "referral": referral,
      "telephone": telephone,
      "email": email,
      "address": address,
      "rate": rate,
    });
  }

  Future<Response> getReferralData(
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
        '$referralUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }
}
