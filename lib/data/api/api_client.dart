import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dhiyodha/model/response_model/error_response.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  // final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String? myToken;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.sharedPreferences}) {
    //required this.appBaseUrl,
    myToken = sharedPreferences.getString(accessToken);
    debugPrint('Token: $accessToken');
    updateHeader(sharedPreferences.getString(accessToken),
        sharedPreferences.getString(languageCode), null, type);
  }

  void updateHeader(
      String? token, String? languageCode, int? moduleID, String? type) {
    _mainHeaders = {
      'accept': '*/*',
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      http.Response response = await http
          .get(
            Uri.parse(uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      http.Response response = await http
          .post(
            Uri.parse(uri),
            body: json.encode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> patchData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');

      http.Response response = await http
          .patch(
        Uri.parse(uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      )
          .timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body with ${multipartBody.length}');
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          if (foundation.kIsWeb) {
            Uint8List list = await multipart.file!.readAsBytes();
            http.MultipartFile part = http.MultipartFile(
              multipart.key,
              multipart.file!.readAsBytes().asStream(),
              list.length,
              filename: basename(multipart.file!.path),
              contentType: MediaType('image', 'jpeg'),
            );
            request.files.add(part);
          } else {
            File file = File(multipart.file!.path);
            request.files.add(http.MultipartFile(
              multipart.key,
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split('/').last,
            ));
          }
        }
      }
      request.fields.addAll(body);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      debugPrint('====> API Body: $body');
      http.Response response = await http
          .put(
            Uri.parse(uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
      http.Response response = await http
          .delete(
            Uri.parse(uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.errors![0].message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    debugPrint(
        '====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    return response0;
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
