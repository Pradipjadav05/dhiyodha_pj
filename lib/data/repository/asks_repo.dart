import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AsksRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AsksRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> addAsks(
      String askType, String region, String content) async {
    return await apiClient.postData(addAskUrl, {
      "askType": askType,
      "region": region,
      "content": content,
    });
  }

  Future<Response> getAsksList(
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
        '$askListUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }

  Future<Response> getAsksAnswerList(String askUuid) async {
    return await apiClient.getData('$getAskAnswersUrl$askUuid/answers');
  }

  Future<Response> addAsksReply(String askUuid, String comment) async {
    return await apiClient
        .putData('$addAskUrl$askUuid/answer', {"answer": comment});
  }

  Future<bool> saveAuthToken(
      String accessTokenData, String refreshTokenData) async {
    debugPrint("accessToken : ${accessTokenData.toString()}");
    sharedPreferences.setString(accessToken, accessTokenData);
    debugPrint("refreshToken : ${refreshTokenData.toString()}");
    sharedPreferences.setString(refreshToken, refreshTokenData);
    return true;
  }
}
