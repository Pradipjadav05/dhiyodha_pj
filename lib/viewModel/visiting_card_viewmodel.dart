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
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _businessCategoryController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  TextEditingController _yearOfBusinessController = TextEditingController();
  TextEditingController _previousTypesOfJobsController =
      TextEditingController();
  TextEditingController _partnerController = TextEditingController();
  TextEditingController _childrenController = TextEditingController();
  TextEditingController _petsController = TextEditingController();
  TextEditingController _hobbiesController = TextEditingController();
  TextEditingController _cityResidenceController = TextEditingController();
  TextEditingController _yearInTheCityController = TextEditingController();
  TextEditingController _burningDesireController = TextEditingController();
  TextEditingController _knowAboutMeController = TextEditingController();
  TextEditingController _keyToSuccessController = TextEditingController();

  TextEditingController get yearOfBusinessController =>
      _yearOfBusinessController;

  set yearOfBusinessController(TextEditingController value) {
    _yearOfBusinessController = value;
  }

  CurrentUserData _currentUserData = CurrentUserData();
  VisitorChildData _visitorData = VisitorChildData();

  VisitorChildData get visitorData => _visitorData;

  set visitorData(VisitorChildData value) {
    _visitorData = value;
    _contactController.text = value.contactNumber.toString();
    _companyNameController.text = value.companyName ?? "";
    _designationController.text = "";
    _businessCategoryController.text = value.businessCategory ?? "";
    _locationController.text = '${value.city} ${value.state} ${value.country}';
    _isVisitorData = true.obs;
  }

  CurrentUserData get currentUserData => _currentUserData;

  set currentUserData(CurrentUserData value) {
    _currentUserData = value;
    _contactController.text = value.mobileNo ?? "";
    _companyNameController.text =
        value.currentUserOrganization?.companyName ?? "";
    _designationController.text =
        value.currentUserOrganization?.designation ?? "";
    _businessCategoryController.text =
        value.currentUserOrganization?.businessCategory ?? "";
    _locationController.text =
        '${value.currentUserAddress?.pinCode} ${value.currentUserAddress?.city} ${value.currentUserAddress?.state} ${value.countryCode}';
    _isVisitorData = false.obs;
  }

  RxBool _isEditData = false.obs;
  RxBool _isVisitorData = false.obs;
  bool _isLoading = false;

  RxBool get isVisitorData => _isVisitorData;

  set isVisitorData(RxBool value) {
    _isVisitorData = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  Future<void> initData() async {
    _isEditData = false.obs;
    _currentUserData = CurrentUserData();
    _contactController = TextEditingController();
    _companyNameController = TextEditingController();
    _designationController = TextEditingController();
    _businessCategoryController = TextEditingController();
    _locationController = TextEditingController();
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
    _isVisitorData = false.obs;
    _visitorData = VisitorChildData();
  }

  RxBool get isEditData => _isEditData;

  set isEditData(RxBool value) {
    _isEditData = value;
  }

  TextEditingController get locationController => _locationController;

  set locationController(TextEditingController value) {
    _locationController = value;
  }

  TextEditingController get businessCategoryController =>
      _businessCategoryController;

  set businessCategoryController(TextEditingController value) {
    _businessCategoryController = value;
  }

  TextEditingController get designationController => _designationController;

  set designationController(TextEditingController value) {
    _designationController = value;
  }

  TextEditingController get companyNameController => _companyNameController;

  set companyNameController(TextEditingController value) {
    _companyNameController = value;
  }

  TextEditingController get contactController => _contactController;

  set contactController(TextEditingController value) {
    _contactController = value;
  }

  Future<bool> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response =
        await visitingCardRepo.updateProfile(updateProfileRequestModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      currentUserData = (await Get.find<HomeViewModel>().getCurrentUser());
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  TextEditingController get previousTypesOfJobsController =>
      _previousTypesOfJobsController;

  set previousTypesOfJobsController(TextEditingController value) {
    _previousTypesOfJobsController = value;
  }

  TextEditingController get partnerController => _partnerController;

  set partnerController(TextEditingController value) {
    _partnerController = value;
  }

  TextEditingController get childrenController => _childrenController;

  set childrenController(TextEditingController value) {
    _childrenController = value;
  }

  TextEditingController get petsController => _petsController;

  set petsController(TextEditingController value) {
    _petsController = value;
  }

  TextEditingController get hobbiesController => _hobbiesController;

  set hobbiesController(TextEditingController value) {
    _hobbiesController = value;
  }

  TextEditingController get cityResidenceController => _cityResidenceController;

  set cityResidenceController(TextEditingController value) {
    _cityResidenceController = value;
  }

  TextEditingController get yearInTheCityController => _yearInTheCityController;

  set yearInTheCityController(TextEditingController value) {
    _yearInTheCityController = value;
  }

  TextEditingController get burningDesireController => _burningDesireController;

  set burningDesireController(TextEditingController value) {
    _burningDesireController = value;
  }

  TextEditingController get knowAboutMeController => _knowAboutMeController;

  set knowAboutMeController(TextEditingController value) {
    _knowAboutMeController = value;
  }

  TextEditingController get keyToSuccessController => _keyToSuccessController;

  set keyToSuccessController(TextEditingController value) {
    _keyToSuccessController = value;
  }
}
