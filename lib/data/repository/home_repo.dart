import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  HomeRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getPosts(
      int page, int size, String? sort, String? orderBy, String? search) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{
      "page": page,
      "size": size,
      "sort": sort,
      "sortDirection": orderBy,
      "search": search
    });
    return await apiClient.getData('$postsUrl?page=$page&size=$size');
    // '$postsUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }

  Future<Response> getMyPosts() async {
    return await apiClient.getData(getMyPostsUrl);
  }

  Future<Response> likeOnPost(String postUuid) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{});
    return await apiClient.postData('$postLikeUrl/$postUuid/like', {});
  }

  Future<Response> commentOnPost(
      String postUuid, String parentCommentId, String comment) async {
    Map<String, dynamic> requestParameters = Map<String, dynamic>();
    requestParameters.addAll(<String, dynamic>{
      "postUuid": postUuid,
      "parentCommentId": parentCommentId,
      "comment": comment
    });
    return await apiClient.postData(postCommentUrl, requestParameters);
  }

  Future<Response> dashboardData(String duration) async {
    return await apiClient.getData('$dashboardUrl?duration=$duration');
  }

  Future<Response> guestDashboardData() async {
    return await apiClient.getData(guestDashboardUrl, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }

  Future<Response> deletePost(String postUuid) async {
    return await apiClient.deleteData('$deletePostUrl$postUuid');
  }

  Future<Response> deleteCommentOnPost(
      String postUuid, String commentId) async {
    return await apiClient
        .deleteData('$deletePostCommentUrl$postUuid/comments/$commentId');
  }

  Future<Response> getCurrentUser() async {
    return await apiClient.getData(currentUserUrl);
  }

  Future<bool> clearSharedPreferenceAndLogout() async {
    sharedPreferences.remove(accessToken);
    sharedPreferences.remove(refreshToken);
    sharedPreferences.clear();
    return true;
  }
}
