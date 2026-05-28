import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class AttendanceRepo {
  final ApiClient apiClient;

  AttendanceRepo({required this.apiClient});

  Future<Response> getAttendanceList(int page, int size) async {
    return await apiClient.getData('$getAttendanceListUrl?page=$page&size=$size');
  }

  Future<Response> getAttendanceHistory(int page, int size) async {
    return await apiClient.getData('$getAttendanceHistoryUrl?page=$page&size=$size&sort=updatedAt&sortDirection=DESC');
  }
}
