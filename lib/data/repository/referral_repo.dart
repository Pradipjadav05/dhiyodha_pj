import 'dart:async';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ReferralRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> addReferralsData(
      String? referralTo,
      String? meetingUuid,
      String? type,
      List<String?> status,
      String? referral,
      String? telephone,
      String? email,
      String? address,
      String? comment,
      String? hotRating,
      int? rate) async {
    return await apiClient.postData(addReferralsUrl, {
      "referralTo": referralTo,
      "meetingUuid": meetingUuid, // Now using the actual passed value
      "type": type,
      "comment": comment,
      "status": status,
      "referral": referral,
      "telephone": telephone,
      "email": email,
      "address": address,
      "rate": rate?.toDouble().toString(),
      "hotRating": hotRating,
    });
  }

  Future<Response> getReferralData(
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
        '$referralUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }

  // TODO: Replace with actual API call when backend is ready
  Future<Response> getMeetings(int page, int size, String? sort, String? sortDirection) async {
    return await apiClient.getData(
        '$getMeetingsListUrl?page=$page&size=$size&sort=$sort&sortDirection=$sortDirection');
    // Mock response - simulating API call
    await Future.delayed(Duration(milliseconds: 500));

    // Mock meetings data
    return Response(
      statusCode: 200,
      body: {
        "timestamp": DateTime.now().toIso8601String(),
        "status": "OK",
        "message": "Meetings retrieved successfully",
        "data": [
          {
            "uuid": "meeting-001",
            "title": "Weekly Chapter Meeting - Jan 2026",
            "date": "2026-01-15",
            "meetingType": "CHAPTER"
          },
          {
            "uuid": "meeting-002",
            "title": "Monthly Networking Event",
            "date": "2026-01-20",
            "meetingType": "NETWORKING"
          },
          {
            "uuid": "meeting-003",
            "title": "Business Development Workshop",
            "date": "2026-01-25",
            "meetingType": "WORKSHOP"
          },
        ]
      }
    );
  }

  // TODO: Replace with actual API call when backend is ready
  Future<Response> getMeetingAttendees(String meetingId) async {
    // Mock response - simulating API call
    await Future.delayed(Duration(milliseconds: 500));

    // Mock attendees data - different users for different meetings
    Map<String, List<Map<String, dynamic>>> mockAttendees = {
      "meeting-001": [
        {
          "uuid": "user-001",
          "firstName": "John",
          "lastName": "Smith",
          "email": "john.smith@example.com",
          "mobileNo": "+1234567890",
          "address": {"city": "Mumbai", "state": "Maharashtra", "country": "India"}
        },
        {
          "uuid": "user-002",
          "firstName": "Sarah",
          "lastName": "Johnson",
          "email": "sarah.j@example.com",
          "mobileNo": "+1234567891",
          "address": {"city": "Pune", "state": "Maharashtra", "country": "India"}
        },
        {
          "uuid": "user-003",
          "firstName": "Michael",
          "lastName": "Williams",
          "email": "michael.w@example.com",
          "mobileNo": "+1234567892",
          "address": {"city": "Mumbai", "state": "Maharashtra", "country": "India"}
        },
      ],
      "meeting-002": [
        {
          "uuid": "user-004",
          "firstName": "Emma",
          "lastName": "Brown",
          "email": "emma.b@example.com",
          "mobileNo": "+1234567893",
          "address": {"city": "Delhi", "state": "Delhi", "country": "India"}
        },
        {
          "uuid": "user-005",
          "firstName": "David",
          "lastName": "Davis",
          "email": "david.d@example.com",
          "mobileNo": "+1234567894",
          "address": {"city": "Bangalore", "state": "Karnataka", "country": "India"}
        },
      ],
      "meeting-003": [
        {
          "uuid": "user-006",
          "firstName": "Lisa",
          "lastName": "Anderson",
          "email": "lisa.a@example.com",
          "mobileNo": "+1234567895",
          "address": {"city": "Chennai", "state": "Tamil Nadu", "country": "India"}
        },
        {
          "uuid": "user-007",
          "firstName": "Robert",
          "lastName": "Taylor",
          "email": "robert.t@example.com",
          "mobileNo": "+1234567896",
          "address": {"city": "Hyderabad", "state": "Telangana", "country": "India"}
        },
      ],
    };

    return Response(
      statusCode: 200,
      body: {
        "timestamp": DateTime.now().toIso8601String(),
        "status": "OK",
        "message": "Meeting attendees retrieved successfully",
        "data": mockAttendees[meetingId] ?? []
      }
    );
  }
}
