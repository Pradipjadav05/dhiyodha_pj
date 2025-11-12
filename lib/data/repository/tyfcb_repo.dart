import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TyfcbRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TyfcbRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> createAppreciateNote(String? recipientId, String? giftAmount,
      String? businessType, String? referralType, String? comments) async {
    return await apiClient.postData(addTyfcbUrl, {
      "recipientId": recipientId,
      "giftAmount": giftAmount,
      "businessType": businessType,
      "referralType": referralType,
      "comments": comments,
    });
  }

  Future<Response> getTyfcbData(
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
        '$tyfcbListUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }
}
