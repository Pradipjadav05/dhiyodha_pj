import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/referral_repo.dart';
import 'package:dhiyodha/model/response_model/meeting_lis_response_model.dart';
import 'package:dhiyodha/model/response_model/referral_response_model.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReferralSlipViewModel extends GetxController implements GetxService {
  final ReferralRepo referralRepo;

  ReferralSlipViewModel({required this.referralRepo}) {}
  RxBool _referralTypeInside = false.obs,
      _referralTypeOutside = true.obs,
      _referralStatusByCall = false.obs,
      _referralStatusByCards = false.obs,
      _referralStatusByHotness1 = false.obs,
      _referralStatusByHotness2 = false.obs,
      _referralStatusByHotness3 = false.obs,
      _referralStatusByHotness4 = false.obs,
      _referralStatusByHotness5 = false.obs,
      _isExpanded = false.obs;

  String _selectedMemberId = "";
  String _selectedMeetingId = "";
  String _selectedMeetingName = "Select Meeting (Optional)";
  List<Map<String, String>> _meetingsList = [];
  List<MeetingListResponseModel> _meetingDataList = [];
  List<MembersChildData> _meetingUsersList = [];

  String get selectedMemberId => _selectedMemberId;

  set selectedMemberId(String value) {
    _selectedMemberId = value;
  }

  String get selectedMeetingId => _selectedMeetingId;

  set selectedMeetingId(String value) {
    _selectedMeetingId = value;
  }

  String get selectedMeetingName => _selectedMeetingName;

  set selectedMeetingName(String value) {
    _selectedMeetingName = value;
  }

  List<Map<String, String>> get meetingsList => _meetingsList;

  set meetingsList(List<Map<String, String>> value) {
    _meetingsList = value;
  }

  List<MembersChildData> get meetingUsersList => _meetingUsersList;

  set meetingUsersList(List<MembersChildData> value) {
    _meetingUsersList = value;
  }

  TextEditingController _toController = TextEditingController();

  RxInt _referralHotnessRate = 0.obs;

  RxInt get referralHotnessRate => _referralHotnessRate;

  set referralHotnessRate(RxInt value) {
    _referralHotnessRate = value;
  }

  get referralStatusByHotness1 => _referralStatusByHotness1;

  set referralStatusByHotness1(value) {
    _referralStatusByHotness1 = value;
  }

  TextEditingController _referralsController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  TextEditingController get commentController => _commentController;

  List<ReferralChildData> _referralDataList = [];

  List<ReferralChildData> get referralDataList => _referralDataList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  set referralDataList(List<ReferralChildData> value) {
    _referralDataList = value;
  }

  get isExpanded => _isExpanded;

  set isExpanded(value) {
    _isExpanded = value;
  }

  get referralTypeOutside => _referralTypeOutside;

  set referralTypeOutside(value) {
    _referralTypeOutside = value;
  }

  get referralTypeInside => _referralTypeInside;

  set referralTypeInside(value) {
    _referralTypeInside = value;
  }

  TextEditingController get addressController => _addressController;

  set addressController(TextEditingController value) {
    _addressController = value;
  }

  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController value) {
    _emailController = value;
  }

  TextEditingController get telephoneController => _telephoneController;

  set telephoneController(TextEditingController value) {
    _telephoneController = value;
  }

  TextEditingController get referralsController => _referralsController;

  set referralsController(TextEditingController value) {
    _referralsController = value;
  }

  TextEditingController get toController => _toController;

  set toController(TextEditingController value) {
    _toController = value;
  }

  get referralStatusByCards => _referralStatusByCards;

  set referralStatusByCards(value) {
    _referralStatusByCards = value;
  }

  get referralStatusByCall => _referralStatusByCall;

  set referralStatusByCall(value) {
    _referralStatusByCall = value;
  }

  get referralStatusByHotness2 => _referralStatusByHotness2;

  set referralStatusByHotness2(value) {
    _referralStatusByHotness2 = value;
  }

  get referralStatusByHotness3 => _referralStatusByHotness3;

  set referralStatusByHotness3(value) {
    _referralStatusByHotness3 = value;
  }

  get referralStatusByHotness4 => _referralStatusByHotness4;

  set referralStatusByHotness4(value) {
    _referralStatusByHotness4 = value;
  }

  get referralStatusByHotness5 => _referralStatusByHotness5;

  set referralStatusByHotness5(value) {
    _referralStatusByHotness5 = value;
  }

  Future<void> initData() async {
    _referralTypeInside = false.obs;
    _referralTypeOutside = true.obs;
    _isExpanded = false.obs;
    _selectedMemberId = "";
    _selectedMeetingId = "";
    _selectedMeetingName = "Select Meeting (Optional)";
    _meetingsList = [];
    _meetingUsersList = [];
    _isLoading = false;
    _referralStatusByCall = false.obs;
    _referralStatusByCards = false.obs;
    _referralStatusByHotness1 = false.obs;
    _referralStatusByHotness2 = false.obs;
    _referralStatusByHotness3 = false.obs;
    _referralStatusByHotness4 = false.obs;
    _referralStatusByHotness5 = false.obs;
    _isExpanded = false.obs;
    _selectedMemberId = "";
    _referralDataList = [];
    _referralsController = TextEditingController();
    _telephoneController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _commentController = TextEditingController();

    // Fetch meetings list
    await getMeetingsList();
  }

  Future<void> getReferralData(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    Response response =
        await referralRepo.getReferralData(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      _referralDataList = [];
      response.body['data']['data'].forEach((order) {
        ReferralChildData tyfcbData = ReferralChildData.fromJson(order);
        _referralDataList.add(tyfcbData);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // TODO: Replace with actual API call when backend is ready
  Future<void> getMeetingsList() async {
    _isLoading = true;
    update();

    Response response = await referralRepo.getMeetings(0, 1000, "updatedAt", "DESC");

    _isLoading = false;
    if (response.statusCode == 200) {
      _meetingsList = [];
      _meetingDataList = [];
      _meetingDataList.add(MeetingListResponseModel(uuid: "", title: "Select Meeting (Optional)"));
      // Add default option
      _meetingsList.add({
        "uuid": "",
        "title": "Select Meeting (Optional)",
      });

      // Parse meetings data
      if (response.body['data'] != null) {
        response.body['data']['data'].forEach((order) {
          MeetingListResponseModel meetingRecord = MeetingListResponseModel.fromJson(order);
          _meetingsList.add({
            "uuid": meetingRecord.uuid ?? "",
            "title": meetingRecord.title ?? "",
          });
          _meetingDataList.add(meetingRecord);
        });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  List<TeamUser> getMeetingWiseUsers(String meetingId) {
    _meetingDataList.length;
    return _meetingDataList.firstWhere((element) => element.uuid == meetingId).team?.users  ?? [];
  }

  List<String> getMeetingWiseUsersName(String meetingId) {
    return getMeetingWiseUsers(meetingId)?.map((toElement) => ((toElement.firstName ?? "") + " " + (toElement.lastName ?? ""))).toList()  ?? [];
  }

  TeamUser getMeetingWiseSelectedUsers(String meetingId, String userName) {
    return getMeetingWiseUsers(meetingId).firstWhere((element) => (element.firstName ?? "") + " " + (element.lastName ?? "") == userName);
  }

  // TODO: Replace with actual API call when backend is ready
  Future<void> getMeetingUsers(String meetingId) async {
    if (meetingId.isEmpty) {
      _meetingUsersList = [];
      update();
      return;
    }

    _isLoading = true;
    update();

    Response response = await referralRepo.getMeetingAttendees(meetingId);

    _isLoading = false;
    if (response.statusCode == 200) {
      _meetingUsersList = [];
      if (response.body['data'] != null) {
        for (var user in response.body['data']) {
          MembersChildData memberData = MembersChildData.fromJson(user);
          _meetingUsersList.add(memberData);
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> addReferralsData(
      String? referralTo,
      String? meetingUuid,
      String? type,
      List<String?> status,
      String? referral,
      String? telephone,
      String? email,
      String? address,
      String? comment,
      int? rate) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await referralRepo.addReferralsData(referralTo, meetingUuid, type,
        status, referral, telephone, email, address, comment, NumberConverter.convertToWord(rate ?? 1), rate);
    _isLoading = false;
    if (response.statusCode == 201) {
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }
}

class NumberConverter {
  static const Map<int, String> _numberWords = {
    1: 'ONE',
    2: 'TWO',
    3: 'THREE',
    4: 'FOUR',
    5: 'FIVE',
  };

  static String convertToWord(int number) {
    return _numberWords[number] ?? '';
  }
}
