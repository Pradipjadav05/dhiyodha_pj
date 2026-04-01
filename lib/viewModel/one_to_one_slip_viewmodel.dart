import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/one_to_one_repo.dart';
import 'package:dhiyodha/model/response_model/one_to_one_response_model.dart';
import 'package:dhiyodha/model/response_model/tyfcb_response_model.dart';
import 'package:dhiyodha/utils/helper/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/response_model/current_user_response_model.dart';
import '../utils/resource/app_constants.dart';

class OneToOneSlipViewModel extends GetxController implements GetxService {
  final OneToOneRepo oneToOneRepo;

  OneToOneSlipViewModel({required this.oneToOneRepo});

  // ── State ──
  RxBool _isExpanded = false.obs;
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedInitiatedBy = "Initiated By".tr;
  Location _location = Location(latitude: 0, longitude: 0);

  // ── Controllers ──
  TextEditingController _metWithController = TextEditingController();
  TextEditingController _whereMeetController = TextEditingController();
  TextEditingController _whenMeetController = TextEditingController();
  TextEditingController _conversionTopicController = TextEditingController();

  // ── One-to-One list ──
  List<OneToOneChildData> _oneToOneDataList = [];

  // ── Getters ──
  bool get isLoading => _isLoading;

  get isExpanded => _isExpanded;

  DateTime get selectedDate => _selectedDate;

  TimeOfDay get selectedTime => _selectedTime;

  String get selectedInitiatedBy => _selectedInitiatedBy;

  Location get location => _location;

  List<OneToOneChildData> get oneToOneDataList => _oneToOneDataList;

  TextEditingController get metWithController => _metWithController;

  TextEditingController get whereMeetController => _whereMeetController;

  TextEditingController get whenMeetController => _whenMeetController;

  TextEditingController get conversionTopicController =>
      _conversionTopicController;

  // ── Setters ──
  set isLoading(bool v) => _isLoading = v;

  set isExpanded(v) => _isExpanded = v;

  set selectedDate(DateTime v) => _selectedDate = v;

  set selectedTime(TimeOfDay v) => _selectedTime = v;

  set selectedInitiatedBy(String v) => _selectedInitiatedBy = v;

  set location(Location v) => _location = v;

  set oneToOneDataList(List<OneToOneChildData> v) => _oneToOneDataList = v;

  set metWithController(TextEditingController v) => _metWithController = v;

  set whereMeetController(TextEditingController v) => _whereMeetController = v;

  set whenMeetController(TextEditingController v) => _whenMeetController = v;

  set conversionTopicController(TextEditingController v) =>
      _conversionTopicController = v;

  String initiatedBy = "";
  String connectedWith = "";
  CurrentUserData _currentUserData = CurrentUserData();

  // ────────────────────────────────────────────────────────────
  // initData — resets ADD FORM state only, never clears the list
  // ────────────────────────────────────────────────────────────
  Future<void> initData() async {
    _isExpanded = false.obs;
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _selectedInitiatedBy = "Initiated By".tr;
    _metWithController = TextEditingController();
    _whereMeetController = TextEditingController();
    _whenMeetController = TextEditingController();
    _conversionTopicController = TextEditingController();
    _location = Location(latitude: 0, longitude: 0);
    resetForm();
  }

  // ────────────────────────────────────────────────────────────
  // getOneToOneData — fetches list from GET /api/one-to-one/
  // ────────────────────────────────────────────────────────────
  Future<void> getOneToOneData(
      int page, int size, String? sort, String? sortDirection) async {
    _isLoading = true;
    update();

    final Response response =
        await oneToOneRepo.getOneToOneData(page, size, sort, sortDirection);

    _isLoading = false;
    if (response.statusCode == 200) {
      final OneToOneResponseModel model =
          OneToOneResponseModel.fromJson(response.body);
      _oneToOneDataList = model.data?.data ?? [];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // addOneToOneData
  // ────────────────────────────────────────────────────────────
  Future<bool> addOneToOneData(
    // String? meetingUuid,
    String? connectedWith,
    String? initiatedBy,
    // Location oneToOneLocation,
    String? oneToOneDate,
    String? oneToOneNotes,
    String? locationName,
    String? senderName,
  ) async {
    _isLoading = true;
    bool isSuccess = false;
    update();

    final Response response = await oneToOneRepo.addOneToOneData(
      // meetingUuid,
      connectedWith,
      initiatedBy,
      // oneToOneLocation,
      oneToOneDate,
      oneToOneNotes,
      locationName,
      senderName,
    );

    _isLoading = false;

    if (response.statusCode == 201) {
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }

    update();
    return isSuccess;
  }

  // ────────────────────────────────────────────────────────────
  // Date & Time pickers
  // ────────────────────────────────────────────────────────────
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      whenMeetController.text =
          DateConverter.convertDateToNumMonth(selectedDate);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      selectedTime = picked;
      whenMeetController.text =
          '${whenMeetController.text} ${selectedTime.hour}:${selectedTime.minute}';
    }
  }

  void resetForm() {
    metWithController.clear();
    whereMeetController.clear();
    whenMeetController.clear();
    conversionTopicController.clear();

    selectedInitiatedBy = '';
    connectedWith = '';
    initiatedBy = '';
    selectedDate = DateTime.now();

    update(); // important for GetBuilder
  }

  void setDashboardOneToOne(Map<String, dynamic> weekly) {

    _isLoading = true;
    update();

    _oneToOneDataList = [];

    if (weekly['oneToOne'] != null) {
      for (var v in weekly['oneToOne']['list']) {

        _oneToOneDataList.add(
          OneToOneChildData.fromJson({
            "uuid": v['uuid'],
            "connectedWith": {
              "firstName": v['fullName']?.split(" ").first,
              "lastName": v['fullName']?.split(" ").length > 1
                  ? v['fullName']?.split(" ").last
                  : "",
              "profileUrl": v['profileImage'],
              "mobileNo": v['mobileNo'],
            },
            "initiatedBy": {
              "firstName": v['initiatedBy'] ?? "",
            },
            "oneToOneNotes": v['notes'],
            "location": v['location'],
            "topicOfConversation": v['topicOfConversation'],
            "oneToOneDate": v['date'],
          }),
        );
      }
    }

    _isLoading = false;
    update();
  }
}
