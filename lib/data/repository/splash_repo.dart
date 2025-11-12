import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login() async {
    return await apiClient.postData(loginUrl, {
      "email": sharedPreferences.getString(storedEmail),
      "password": sharedPreferences.getString(storedPassword)
    }, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
  }

  Future<bool> saveAuthToken(
      String accessTokenData, String refreshTokenData) async {
    sharedPreferences.setString(accessToken, accessTokenData);
    sharedPreferences.setString(refreshToken, refreshTokenData);
    sharedPreferences.setString(
        storedEmail, sharedPreferences.getString(storedEmail) ?? "");
    sharedPreferences.setString(
        storedPassword, sharedPreferences.getString(storedPassword) ?? "");
    sharedPreferences.setBool(isLogin, true);
    apiClient.updateHeader(sharedPreferences.getString(accessToken),
        sharedPreferences.getString(languageCode), null, type);
    return true;
  }

  // void updateHeader(int? moduleID) {
  //   apiClient.updateHeader(
  //     sharedPreferences.getString(AppConstants.token),
  //     sharedPreferences.getString(AppConstants.languageCode),
  //     moduleID,
  //     sharedPreferences.getString(AppConstants.type),
  //   );
  // }

  // Future<bool> saveUserToken(
  //     String token, String zoneTopic, String type) async {
  //   apiClient.updateHeader(token,
  //       sharedPreferences.getString(AppConstants.languageCode), null, type);
  //   sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
  //   sharedPreferences.setString(AppConstants.type, type);
  //   return await sharedPreferences.setString(AppConstants.token, token);
  // }
  //
  // String getUserToken() {
  //   return sharedPreferences.getString(AppConstants.token) ?? "";
  // }

  bool isLoggedIn() {
    debugPrint("Token :: ${sharedPreferences.getString(accessToken)}");
    return sharedPreferences.containsKey(accessToken);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(accessToken);
    await sharedPreferences.remove(refreshToken);
    await sharedPreferences.clear();
    return true;
  }
}
