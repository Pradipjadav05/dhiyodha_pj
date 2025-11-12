import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LoginRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(String? email, String password) async {
    return await apiClient.postData(loginUrl, {
      "email": email,
      "password": password
    }, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
  }

  Future<Response> guestLogin(String mobileNumber) async {
    return await apiClient.postData(guestSignupUrl, {
      "mobileNo": mobileNumber,
      "location": {"latitude": 0, "longitude": 0}
    }, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
  }

  Future<Response> sendOTP(String mobileNumber, String countryCode) async {
    return await apiClient.postData(
        '$sendOtpUrl?mobileNo=$mobileNumber&countryCode=$countryCode', {},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        });
  }

  Future<Response> verifyOTP(
      String mobileNumber, String countryCode, String OTP) async {
    return await apiClient.postData(
        '$verifyOtpUrl?mobileNo=$mobileNumber&countryCode=$countryCode&otp=$OTP',
        {},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        });
  }

  Future<bool> saveAuthToken(String accessTokenData, String refreshTokenData,
      String? email, String? password) async {
    debugPrint("accessToken : ${accessTokenData.toString()}");
    sharedPreferences.setString(accessToken, accessTokenData);
    debugPrint("refreshToken : ${refreshTokenData.toString()}");
    sharedPreferences.setString(refreshToken, refreshTokenData);
    sharedPreferences.setString(storedEmail, email ?? "");
    sharedPreferences.setString(storedPassword, password ?? "");
    sharedPreferences.setBool(isLogin, true);
    apiClient.updateHeader(sharedPreferences.getString(accessToken),
        sharedPreferences.getString(languageCode), null, type);
    return true;
  }

  // Future<bool> saveUserToken(
  //     String token, String zoneTopic, String type) async {
  //   apiClient.updateHeader(token,
  //       sharedPreferences.getString(AppConstants.languageCode), null, type);
  //   sharedPreferences.setString(AppConstants.zoneTopic, zoneTopic);
  //   sharedPreferences.setString(AppConstants.type, type);
  //   return await sharedPreferences.setString(AppConstants.token, token);
  // }

  // void updateHeader(int? moduleID) {
  //   apiClient.updateHeader(
  //     sharedPreferences.getString(AppConstants.token),
  //     sharedPreferences.getString(AppConstants.languageCode),
  //     moduleID,
  //     sharedPreferences.getString(AppConstants.type),
  //   );
  // }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(accessToken);
  }

  Future<bool> clearSharedData() async {
    if (!GetPlatform.isWeb) {
      // apiClient.postData(tokenUri,
      //     {"_method": "put", "token": getUserToken(), "fcm_token": '@'});
      // FirebaseMessaging.instance.unsubscribeFromTopic(
      //     sharedPreferences.getString(AppConstants.zoneTopic)!);
    }
    await sharedPreferences.remove(accessToken);
    await sharedPreferences.remove(refreshToken);
    return true;
  }
}
