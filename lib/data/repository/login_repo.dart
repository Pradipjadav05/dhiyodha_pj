import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LoginRepo({required this.apiClient, required this.sharedPreferences});

  // ── Login ──
  Future<Response> login(String? email, String password) async {
    return await apiClient.postData(
      loginUrl,
      {'email': email, 'password': password},
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  // ── Guest login ──
  Future<Response> guestLogin(String mobileNumber) async {
    return await apiClient.postData(
      guestSignupUrl,
      {
        'mobileNo': mobileNumber,
        'location': {'latitude': 0, 'longitude': 0},
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  // ── Guest OTP — Send ──
  Future<Response> sendOTP(String mobileNumber, String countryCode) async {
    return await apiClient.postData(
      '$sendOtpUrl?mobileNo=$mobileNumber&countryCode=$countryCode',
      {},
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  // ── Guest OTP — Verify ──
  Future<Response> verifyOTP(
      String mobileNumber, String countryCode, String otp) async {
    return await apiClient.postData(
      '$verifyOtpUrl?mobileNo=$mobileNumber&countryCode=$countryCode&otp=$otp',
      {},
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  // ────────────────────────────────────────────────────────────
  // Forgot Password — Step 1
  // POST /api/users/forgot/send-otp
  // Body: { "email": "string" }
  // ────────────────────────────────────────────────────────────
  Future<Response> forgotSendOtp(String email) async {
    return await apiClient.postData(
      sentOtp,
      {'email': email},
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  // ────────────────────────────────────────────────────────────
  // Forgot Password — Step 2
  // POST /api/users/forgot/verify-otp
  // Body: { "email": "string", "otp": "string" }
  // ────────────────────────────────────────────────────────────
  Future<Response> forgotVerifyOtp(String email, String otp) async {
    return await apiClient.postData(
      verifyOtp,
      {'email': email, 'otp': otp},
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  // ────────────────────────────────────────────────────────────
  // Forgot Password — Step 3
  // PATCH /api/users/forgotPassword
  // Body: { "email": "string", "setPassword": "string", "reTypePassword": "string" }
  // ────────────────────────────────────────────────────────────
  Future<Response> forgotResetPassword({
    required String email,
    required String setPassword,
    required String reTypePassword,
  }) async {
    return await apiClient.putData(
      forgotPasswordUrl,
      {
        'email': email,
        'setPassword': setPassword,
        'reTypePassword': reTypePassword,
      },
    );
  }

  // ── Save auth token ──
  Future<bool> saveAuthToken(String accessTokenData, String refreshTokenData,
      String? email, String? password) async {
    debugPrint('accessToken : $accessTokenData');
    sharedPreferences.setString(accessToken, accessTokenData);
    debugPrint('refreshToken : $refreshTokenData');
    sharedPreferences.setString(refreshToken, refreshTokenData);
    sharedPreferences.setString(storedEmail, email ?? '');
    sharedPreferences.setString(storedPassword, password ?? '');
    sharedPreferences.setBool(isLogin, true);
    apiClient.updateHeader(sharedPreferences.getString(accessToken),
        sharedPreferences.getString(languageCode), null, type);
    return true;
  }

  // ────────────────────────────────────────────────────────────
  // Update Password (logged-in user)
  // PUT /api/users/update-password
  // Body: { "oldPassword": "string", "newPassword": "string", "retypePassword": "string" }
  // ────────────────────────────────────────────────────────────
  Future<Response> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String retypePassword,
  }) async {
    return await apiClient.putData(
      updatePasswordUrl,
      // add to app_constants.dart: baseUrl + 'api/users/update-password'
      {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'retypePassword': retypePassword,
      },
    );
  }

  bool isLoggedIn() => sharedPreferences.containsKey(accessToken);

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(accessToken);
    await sharedPreferences.remove(refreshToken);
    return true;
  }
}
