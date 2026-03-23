import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/referral_repo.dart';
import 'package:dhiyodha/model/response_model/meeting_lis_response_model.dart';
import 'package:dhiyodha/model/response_model/referral_response_model.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReferralSlipViewModel extends GetxController implements GetxService {
  final ReferralRepo referralRepo;

  ReferralSlipViewModel({required this.referralRepo});

  RxBool _referralTypeInside = false.obs;
  RxBool _referralTypeOutside = true.obs;
  RxBool _referralStatusByCall = false.obs;
  RxBool _referralStatusByCards = false.obs;
  RxBool _referralStatusByHotness1 = false.obs;
  RxBool _referralStatusByHotness2 = false.obs;
  RxBool _referralStatusByHotness3 = false.obs;
  RxBool _referralStatusByHotness4 = false.obs;
  RxBool _referralStatusByHotness5 = false.obs;
  RxBool _isExpanded = false.obs;
  RxInt _referralHotnessRate = 0.obs;

  String _selectedMemberId = '';
  String _selectedMeetingId = '';
  String _selectedMeetingName = 'Select Meeting (Optional)';
  List<Map<String, String>> _meetingsList = [];
  List<MeetingListResponseModel> _meetingDataList = [];
  List<MembersChildData> _meetingUsersList = [];
  List<ReferralChildData> _referralDataList = [];

  TextEditingController _toController = TextEditingController();
  TextEditingController _referralsController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  bool _isLoading = false;

  // ── Getters ──
  String get selectedMemberId => _selectedMemberId;

  String get selectedMeetingId => _selectedMeetingId;

  String get selectedMeetingName => _selectedMeetingName;

  List<Map<String, String>> get meetingsList => _meetingsList;

  List<MembersChildData> get meetingUsersList => _meetingUsersList;

  List<ReferralChildData> get referralDataList => _referralDataList;

  bool get isLoading => _isLoading;

  RxInt get referralHotnessRate => _referralHotnessRate;

  get referralTypeInside => _referralTypeInside;

  get referralTypeOutside => _referralTypeOutside;

  get referralStatusByCall => _referralStatusByCall;

  get referralStatusByCards => _referralStatusByCards;

  get referralStatusByHotness1 => _referralStatusByHotness1;

  get referralStatusByHotness2 => _referralStatusByHotness2;

  get referralStatusByHotness3 => _referralStatusByHotness3;

  get referralStatusByHotness4 => _referralStatusByHotness4;

  get referralStatusByHotness5 => _referralStatusByHotness5;

  get isExpanded => _isExpanded;

  TextEditingController get toController => _toController;

  TextEditingController get referralsController => _referralsController;

  TextEditingController get telephoneController => _telephoneController;

  TextEditingController get emailController => _emailController;

  TextEditingController get addressController => _addressController;

  TextEditingController get commentController => _commentController;

  // ── Setters ──
  set selectedMemberId(String v) => _selectedMemberId = v;

  set selectedMeetingId(String v) => _selectedMeetingId = v;

  set selectedMeetingName(String v) => _selectedMeetingName = v;

  set meetingsList(List<Map<String, String>> v) => _meetingsList = v;

  set meetingUsersList(List<MembersChildData> v) => _meetingUsersList = v;

  set referralDataList(List<ReferralChildData> v) => _referralDataList = v;

  set isLoading(bool v) => _isLoading = v;

  set referralHotnessRate(RxInt v) => _referralHotnessRate = v;

  set referralTypeInside(v) => _referralTypeInside = v;

  set referralTypeOutside(v) => _referralTypeOutside = v;

  set referralStatusByCall(v) => _referralStatusByCall = v;

  set referralStatusByCards(v) => _referralStatusByCards = v;

  set referralStatusByHotness1(v) => _referralStatusByHotness1 = v;

  set referralStatusByHotness2(v) => _referralStatusByHotness2 = v;

  set referralStatusByHotness3(v) => _referralStatusByHotness3 = v;

  set referralStatusByHotness4(v) => _referralStatusByHotness4 = v;

  set referralStatusByHotness5(v) => _referralStatusByHotness5 = v;

  set isExpanded(v) => _isExpanded = v;

  set toController(TextEditingController v) => _toController = v;

  set referralsController(TextEditingController v) => _referralsController = v;

  set telephoneController(TextEditingController v) => _telephoneController = v;

  set emailController(TextEditingController v) => _emailController = v;

  set addressController(TextEditingController v) => _addressController = v;

  // ────────────────────────────────────────────────────────────
  // initData
  // ────────────────────────────────────────────────────────────
  Future<void> initData() async {
    _referralTypeInside = false.obs;
    _referralTypeOutside = true.obs;
    _isExpanded = false.obs;
    _selectedMemberId = '';
    _selectedMeetingId = '';
    _selectedMeetingName = 'Select Meeting (Optional)';
    _meetingsList = [];
    _meetingDataList = [];
    _meetingUsersList = [];
    _isLoading = false;
    _referralStatusByCall = false.obs;
    _referralStatusByCards = false.obs;
    _referralStatusByHotness1 = false.obs;
    _referralStatusByHotness2 = false.obs;
    _referralStatusByHotness3 = false.obs;
    _referralStatusByHotness4 = false.obs;
    _referralStatusByHotness5 = false.obs;
    _referralHotnessRate = 0.obs;
    _referralDataList = [];
    _toController = TextEditingController();
    _referralsController = TextEditingController();
    _telephoneController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _commentController = TextEditingController();

    await getMeetingsList();
  }

  // ────────────────────────────────────────────────────────────
  // getMeetingWiseUsers — FIXED
  //
  // Root cause of "Bad state: No element":
  //   firstWhere() throws when no element matches the predicate.
  //   This happened because:
  //   1. The UI renders getMeetingWiseUsersName() while _meetingDataList
  //      is still loading (empty list → no match → crash).
  //   2. selectedMeetingId could hold a value that no longer exists
  //      in _meetingDataList after a reload.
  //
  // Fix: use orElse: () => MeetingListResponseModel() as safe fallback.
  //   Returns empty team users list when meeting is not found.
  // ────────────────────────────────────────────────────────────
  List<TeamUser> getMeetingWiseUsers(String meetingId) {
    if (meetingId.isEmpty || _meetingDataList.isEmpty) return [];

    final MeetingListResponseModel? meeting = _meetingDataList.firstWhere(
      (element) => element.uuid == meetingId,
      orElse: () => MeetingListResponseModel(), // ← safe fallback, no crash
    );

    return meeting?.team?.users ?? [];
  }

  List<String> getMeetingWiseUsersName(String meetingId) {
    if (meetingId.isEmpty) return [];
    return getMeetingWiseUsers(meetingId)
        .map((u) => '${u.firstName ?? ''} ${u.lastName ?? ''}'.trim())
        .toList();
  }

  // ── FIX: also use orElse here to avoid crash on user selection ──
  TeamUser getMeetingWiseSelectedUsers(String meetingId, String userName) {
    final List<TeamUser> users = getMeetingWiseUsers(meetingId);
    return users.firstWhere(
      (u) => '${u.firstName ?? ''} ${u.lastName ?? ''}'.trim() == userName,
      orElse: () => TeamUser(), // safe fallback
    );
  }

  // ────────────────────────────────────────────────────────────
  // getReferralData
  // ────────────────────────────────────────────────────────────
  Future<void> getReferralData(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    final Response response =
        await referralRepo.getReferralData(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      _referralDataList = [];
      response.body['data']['data'].forEach((order) {
        _referralDataList.add(ReferralChildData.fromJson(order));
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // getMeetingsList
  // ────────────────────────────────────────────────────────────
  Future<void> getMeetingsList() async {
    _isLoading = true;
    update();

    final Response response =
        await referralRepo.getMeetings(0, 1000, 'updatedAt', 'DESC');

    _isLoading = false;
    if (response.statusCode == 200) {
      _meetingsList = [];
      _meetingDataList = [];

      // Default placeholder option
      _meetingsList.add({'uuid': '', 'title': 'Select Meeting (Optional)'});
      _meetingDataList.add(MeetingListResponseModel(
          uuid: '', title: 'Select Meeting (Optional)'));

      if (response.body['data'] != null) {
        response.body['data']['data'].forEach((order) {
          final MeetingListResponseModel meetingRecord =
              MeetingListResponseModel.fromJson(order);
          _meetingsList.add({
            'uuid': meetingRecord.uuid ?? '',
            'title': meetingRecord.title ?? '',
          });
          _meetingDataList.add(meetingRecord);
        });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // getMeetingUsers
  // ────────────────────────────────────────────────────────────
  Future<void> getMeetingUsers(String meetingId) async {
    if (meetingId.isEmpty) {
      _meetingUsersList = [];
      update();
      return;
    }

    _isLoading = true;
    update();

    final Response response = await referralRepo.getMeetingAttendees(meetingId);

    _isLoading = false;
    if (response.statusCode == 200) {
      _meetingUsersList = [];
      if (response.body['data'] != null) {
        for (var user in response.body['data']) {
          _meetingUsersList.add(MembersChildData.fromJson(user));
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // addReferralsData
  // ────────────────────────────────────────────────────────────
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
    final Response response = await referralRepo.addReferralsData(
        referralTo,
        meetingUuid,
        type,
        status,
        referral,
        telephone,
        email,
        address,
        comment,
        NumberConverter.convertToWord(rate ?? 1),
        rate);
    _isLoading = false;
    if (response.statusCode == 201) {
      isSuccess = true;
    } else {
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
