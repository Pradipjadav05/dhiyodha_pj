import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';

// import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/request_model/update_profile_request_model.dart';

class PostsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PostsRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> uploadImageDocument(
      String? documentType, XFile selectedImage) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{});
    return await apiClient.postMultipartData(
        '$uploadDocumentUrl?documentType=$documentType',
        {},
        [MultipartBody('file', selectedImage)]);
  }

  Future<Response> addPost(String? content, String? documentUuid,
      String? postRegion, bool? active) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{});
    return await apiClient.postData(addPostUrl, {
      "content": content,
      "documentUuid": documentUuid,
      "postRegion": postRegion,
      "active": active,
    });
  }

  Future<Response> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    return await apiClient.putData(
        editProfileUrl, updateProfileRequestModel.toJson());
  }
}
