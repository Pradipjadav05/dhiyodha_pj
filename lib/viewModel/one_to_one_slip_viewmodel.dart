import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/one_to_one_repo.dart';
import 'package:dhiyodha/model/response_model/tyfcb_response_model.dart';
import 'package:dhiyodha/utils/helper/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneToOneSlipViewModel extends GetxController implements GetxService {
  final OneToOneRepo oneToOneRepo;

  OneToOneSlipViewModel({required this.oneToOneRepo}) {}

  RxBool _isExpanded = false.obs;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedInitiatedBy = "Initiated By".tr;
  TextEditingController _metWithController = TextEditingController();
  TextEditingController _whereMeetController = TextEditingController();
  TextEditingController _whenMeetController = TextEditingController();
  TextEditingController _conversionTopicController = TextEditingController();
  Location _location = new Location(latitude: 0, longitude: 0);

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
  }

  String get selectedInitiatedBy => _selectedInitiatedBy;

  set selectedInitiatedBy(String value) {
    _selectedInitiatedBy = value;
  }

  Location get location => _location;

  set location(Location value) {
    _location = value;
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  get isExpanded => _isExpanded;

  set isExpanded(value) {
    _isExpanded = value;
  }

  TextEditingController get metWithController => _metWithController;

  TextEditingController get whereMeetController => _whereMeetController;

  TextEditingController get whenMeetController => _whenMeetController;

  TextEditingController get conversionTopicController =>
      _conversionTopicController;

  Future<void> initData() async {
    _isExpanded = false.obs;
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _selectedInitiatedBy = "Initiated By".tr;
    _metWithController = TextEditingController();
    _whereMeetController = TextEditingController();
    _whenMeetController = TextEditingController();
    _conversionTopicController = TextEditingController();
    _location = new Location(latitude: 0, longitude: 0);
  }

  Future<bool> addOneToOneData(
      String? connectedWith,
      String? initiatedBy,
      Location oneToOneLocation,
      String? oneToOneDate,
      String? oneToOneNotes) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await oneToOneRepo.addOneToOneData(connectedWith,
        initiatedBy, oneToOneLocation, oneToOneDate, oneToOneNotes);
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      whenMeetController.text =
          DateConverter.convertDateToNumMonth(selectedDate);
      //selectTime(context);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != selectedDate) {
      selectedTime = picked;
      whenMeetController.text = whenMeetController.text +
          " " +
          selectedTime.hour.toString() +
          ":" +
          selectedTime.minute.toString();
    }
  }

  TimeOfDay get selectedTime => _selectedTime;

  set selectedTime(TimeOfDay value) {
    _selectedTime = value;
  }
}
