import 'dart:async';

import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/visiting_card_repo.dart';
import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/model/response_model/visitor_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_viewmodel.dart';

class VisitingCardViewModel extends GetxController implements GetxService {
  final VisitingCardRepo visitingCardRepo;

  VisitingCardViewModel({required this.visitingCardRepo});

  TextEditingController _contactController = TextEditingController();
  TextEditingController _meetingChapterNameController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _businessCategoryController = TextEditingController();

  // ── Separate address controllers (replaces single _locationController) ──
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  TextEditingController _yearOfBusinessController = TextEditingController();
  TextEditingController _previousTypesOfJobsController = TextEditingController();
  TextEditingController _partnerController = TextEditingController();
  TextEditingController _childrenController = TextEditingController();
  TextEditingController _petsController = TextEditingController();
  TextEditingController _hobbiesController = TextEditingController();
  TextEditingController _cityResidenceController = TextEditingController();
  TextEditingController _yearInTheCityController = TextEditingController();
  TextEditingController _burningDesireController = TextEditingController();
  TextEditingController _knowAboutMeController = TextEditingController();
  TextEditingController _keyToSuccessController = TextEditingController();

  CurrentUserData _currentUserData = CurrentUserData();
  VisitorChildData _visitorData = VisitorChildData();

  RxBool _isEditData = false.obs;
  RxBool _isVisitorData = false.obs;
  bool _isLoading = false;

  // ── Getters ──
  TextEditingController get contactController => _contactController;
  TextEditingController get meetingChapterNameController => _meetingChapterNameController;
  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get designationController => _designationController;
  TextEditingController get businessCategoryController => _businessCategoryController;
  TextEditingController get pinCodeController => _pinCodeController;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  TextEditingController get countryController => _countryController;
  TextEditingController get yearOfBusinessController => _yearOfBusinessController;
  TextEditingController get previousTypesOfJobsController => _previousTypesOfJobsController;
  TextEditingController get partnerController => _partnerController;
  TextEditingController get childrenController => _childrenController;
  TextEditingController get petsController => _petsController;
  TextEditingController get hobbiesController => _hobbiesController;
  TextEditingController get cityResidenceController => _cityResidenceController;
  TextEditingController get yearInTheCityController => _yearInTheCityController;
  TextEditingController get burningDesireController => _burningDesireController;
  TextEditingController get knowAboutMeController => _knowAboutMeController;
  TextEditingController get keyToSuccessController => _keyToSuccessController;
  CurrentUserData get currentUserData => _currentUserData;
  VisitorChildData get visitorData => _visitorData;
  RxBool get isEditData => _isEditData;
  RxBool get isVisitorData => _isVisitorData;
  bool get isLoading => _isLoading;

  // ── Setters ──
  set contactController(TextEditingController v) => _contactController = v;
  set meetingChapterNameController(TextEditingController v) => meetingChapterNameController = v;
  set companyNameController(TextEditingController v) => _companyNameController = v;
  set designationController(TextEditingController v) => _designationController = v;
  set businessCategoryController(TextEditingController v) => _businessCategoryController = v;
  set pinCodeController(TextEditingController v) => _pinCodeController = v;
  set cityController(TextEditingController v) => _cityController = v;
  set stateController(TextEditingController v) => _stateController = v;
  set countryController(TextEditingController v) => _countryController = v;
  set yearOfBusinessController(TextEditingController v) => _yearOfBusinessController = v;
  set previousTypesOfJobsController(TextEditingController v) => _previousTypesOfJobsController = v;
  set partnerController(TextEditingController v) => _partnerController = v;
  set childrenController(TextEditingController v) => _childrenController = v;
  set petsController(TextEditingController v) => _petsController = v;
  set hobbiesController(TextEditingController v) => _hobbiesController = v;
  set cityResidenceController(TextEditingController v) => _cityResidenceController = v;
  set yearInTheCityController(TextEditingController v) => _yearInTheCityController = v;
  set burningDesireController(TextEditingController v) => _burningDesireController = v;
  set knowAboutMeController(TextEditingController v) => _knowAboutMeController = v;
  set keyToSuccessController(TextEditingController v) => _keyToSuccessController = v;
  set isEditData(RxBool v) => _isEditData = v;
  set isVisitorData(RxBool v) => _isVisitorData = v;
  set isLoading(bool v) => _isLoading = v;

  // ────────────────────────────────────────────────────────────
  // visitorData setter
  // ────────────────────────────────────────────────────────────
  set visitorData(VisitorChildData value) {
    _visitorData = value;
    _contactController.text = value.contactNumber?.toString() ?? '';
    _meetingChapterNameController.text = value.chapterName?.toString() ?? '';
    _companyNameController.text = value.companyName ?? '';
    _designationController.text = value.designation ?? '';
    _businessCategoryController.text = value.businessCategory ?? '';
    _pinCodeController.text = value.pinCode ?? '';
    _cityController.text = value.city ?? '';
    _stateController.text = value.state ?? '';
    _countryController.text = value.country ?? '';
    _isVisitorData = true.obs;
  }

  // ────────────────────────────────────────────────────────────
  // currentUserData setter
  // ────────────────────────────────────────────────────────────
  set currentUserData(CurrentUserData value) {
    _currentUserData = value;
    _refreshControllers(value);
  }

  // ── Refresh each controller from its own dedicated field ──
  void _refreshControllers(CurrentUserData data) {
    _contactController.text = data.mobileNo ?? '';
    _companyNameController.text = data.currentUserOrganization?.companyName ?? '';
    _designationController.text = data.currentUserOrganization?.designation ?? '';
    _businessCategoryController.text = data.currentUserOrganization?.businessCategory ?? '';
    _pinCodeController.text = data.currentUserAddress?.pinCode ?? '';
    _cityController.text = data.currentUserAddress?.city ?? '';
    _stateController.text = data.currentUserAddress?.state ?? '';
    _countryController.text = data.currentUserAddress?.country ?? '';
  }

  // ────────────────────────────────────────────────────────────
  // initData
  // ────────────────────────────────────────────────────────────
  Future<void> initData() async {
    _isEditData = false.obs;
    _isVisitorData = false.obs;
    _currentUserData = CurrentUserData();
    _visitorData = VisitorChildData();
    _contactController = TextEditingController();
    _meetingChapterNameController = TextEditingController();
    _companyNameController = TextEditingController();
    _designationController = TextEditingController();
    _businessCategoryController = TextEditingController();
    _pinCodeController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _countryController = TextEditingController();
    _yearOfBusinessController = TextEditingController();
    _previousTypesOfJobsController = TextEditingController();
    _partnerController = TextEditingController();
    _childrenController = TextEditingController();
    _petsController = TextEditingController();
    _hobbiesController = TextEditingController();
    _cityResidenceController = TextEditingController();
    _yearInTheCityController = TextEditingController();
    _burningDesireController = TextEditingController();
    _knowAboutMeController = TextEditingController();
    _keyToSuccessController = TextEditingController();
  }

  // ────────────────────────────────────────────────────────────
  // updateProfile
  // ────────────────────────────────────────────────────────────
  Future<bool> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    _isLoading = true;
    update();

    bool isSuccess = false;

    final Response response =
    await visitingCardRepo.updateProfile(updateProfileRequestModel);

    _isLoading = false;

    if (response.statusCode == 200) {
      final CurrentUserData latestUserData =
      await Get.find<HomeViewModel>().getCurrentUser();

      final CurrentUserData updatedData = toCurrentUserData(
        currentUserData: latestUserData,
        existingData: updateProfileRequestModel,
      );

      _currentUserData = updatedData;
      _refreshControllers(updatedData);
      _isEditData = false.obs;
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(response);
    }

    update();
    return isSuccess;
  }
}