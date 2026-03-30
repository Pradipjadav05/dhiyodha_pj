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

  // ── Add new one-to-one record ──
  Future<Response> addOneToOneData(
      String? meetingUuid,
      String? connectedWith,
      String? initiatedBy,
      Location oneToOneLocation,
      String? oneToOneDate,
      String? oneToOneNotes,
      String? locationName,
      String? senderName,
      ) async {
    return await apiClient.postData(addOneToOneUrl, {
      "meetingUuid": meetingUuid,
      "connectedWith": connectedWith,
      "initiatedBy": initiatedBy,
      "oneToOneLocation": oneToOneLocation.toJson(),
      "oneToOneDate": oneToOneDate,
      "oneToOneNotes": oneToOneNotes,
      "locationName": locationName,
      "senderName": senderName,
    });
  }

  // ── Fetch paginated one-to-one list ──
  Future<Response> getOneToOneData(
      int page, int size, String? sort, String? sortDirection) async {
    return await apiClient.getData(
        '$oneToOneListUrl?page=$page&size=$size&sort=$sort&sortDirection=$sortDirection');
  }

  // ── Posts (unchanged) ──
  Future<Response> getPosts(
      int page, int size, String? sort, String? orderBy, String? search) async {
    return await apiClient.getData('$postsUrl?page=$page&size=$size');
  }
}