import 'dart:convert';

import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/visitors_repo.dart';
import 'package:dhiyodha/model/response_model/add_upload_operation_response_model.dart';
import 'package:dhiyodha/model/response_model/groups_response_model.dart';
import 'package:dhiyodha/model/response_model/visitor_response_model.dart';
import 'package:dhiyodha/utils/helper/date_converter.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/repository/referral_repo.dart';
import '../model/dummy_model/teams_api_response.dart';
import '../model/response_model/meeting_lis_response_model.dart';

// declare an enum for image upload type
enum ImageUploadType {
  profileImage,
  frontVisitingCard,
  backVisitingCard,
}

class VisitorsViewModel extends GetxController implements GetxService {
  final VisitorsRepo visitorsRepo;
  final ReferralRepo referralRepo;

  VisitorsViewModel({required this.visitorsRepo, required this.referralRepo}) {}

  bool _isLoading = false;
  RxBool _isExpanded = false.obs;
  RxBool _isAgreeTerms = false.obs;
  RxBool _isProfileImageUploadSuccess = false.obs;
  RxBool _isVCardFrontSuccess = false.obs;
  RxBool _isVCardBackSuccess = false.obs;
  RxBool _referralTypeInside = false.obs;
  RxBool _referralTypeOutside = true.obs;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  String _selectedCountry = "",
      _selectedState = "",
      _selectedCity = "",
      _selectedChapter = "",
      _selectedMeeting = "",
      _selectedMeetingCode = "",
      _selectedBusinessCategory = "";
  var profileUrl = "",
      uploadFrontVisitingCard = "",
      uploadBackVisitingCard = "";
  ImageUploadType imageUploadType = ImageUploadType.profileImage;
  List<String> _countryList = [];
  List<String> unSortedList = [];
  List<String> _stateList = [];
  List<String> _cityList = [];
  List<String> _chapterList = [];
  List<String> _businessCatList = [];
  List<GroupChildData> _groupChildData = [];
  List<Map<String, String>> _meetingsList = [];
  List<String> _teamWiseMeetingList = [];
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;

  UploadedDocRespModel _uploadedDocRespModel = new UploadedDocRespModel();

  XFile? _uploadedProfilePictureFile;
  XFile? _uploadedVCardFrontFile;
  XFile? _uploadedVCardBackFile;
  List<VisitorChildData> _visitorData = [];
  DateTime _selectedDate = DateTime.now();

  RxInt get page => _page;

  set page(RxInt value) {
    _page = value;
  }

  UploadedDocRespModel get uploadedDocRespModel => _uploadedDocRespModel;

  set uploadedDocRespModel(UploadedDocRespModel value) {
    _uploadedDocRespModel = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  RxBool get isImageUploadSuccess => _isProfileImageUploadSuccess;

  set isImageUploadSuccess(RxBool value) {
    _isProfileImageUploadSuccess = value;
  }

  RxBool get isVCardFrontSuccess => _isVCardFrontSuccess;

  set isVCardFrontSuccess(RxBool value) {
    _isVCardFrontSuccess = value;
  }

  RxBool get isVCardBackSuccess => _isVCardBackSuccess;

  set isVCardBackSuccess(RxBool value) {
    _isVCardBackSuccess = value;
  }

  get referralTypeOutside => _referralTypeOutside;

  set referralTypeOutside(value) {
    _referralTypeOutside = value;
  }

  get referralTypeInside => _referralTypeInside;

  set referralTypeInside(value) {
    _referralTypeInside = value;
  }

  RxBool get isExpanded => _isExpanded;

  set isExpanded(RxBool value) {
    _isExpanded = value;
  }

  RxBool get isAgreeTerms => _isAgreeTerms;

  set isAgreeTerms(RxBool value) {
    _isAgreeTerms = value;
  }

  TextEditingController get dateController => _dateController;

  set dateController(TextEditingController value) {
    _dateController = value;
  }

  TextEditingController get nameController => _nameController;

  set nameController(TextEditingController value) {
    _nameController = value;
  }
  TextEditingController get emailController => _emailController;

  set emailController(TextEditingController value) {
    _emailController = value;
  }

  TextEditingController get contactNumberController => _contactNumberController;

  set contactNumberController(TextEditingController value) {
    _contactNumberController = value;
  }

  TextEditingController get companyNameController => _companyNameController;

  set companyNameController(TextEditingController value) {
    _companyNameController = value;
  }

  String get selectedCountry => _selectedCountry;

  set selectedCountry(String value) {
    _selectedCountry = value;
  }

  get selectedState => _selectedState;

  set selectedState(value) {
    _selectedState = value;
  }

  get selectedCity => _selectedCity;

  set selectedCity(value) {
    _selectedCity = value;
  }

  get selectedChapter => _selectedChapter;

  set selectedChapter(value) {
    _selectedChapter = value;
  }

  get selectedBusinessCategory => _selectedBusinessCategory;

  set selectedBusinessCategory(value) {
    _selectedBusinessCategory = value;
  }

  List<String> get countryList => _countryList;

  set countryList(List<String> value) {
    _countryList = value;
  }

  List<String> get stateList => _stateList;

  set stateList(List<String> value) {
    _stateList = value;
  }

  List<String> get cityList => _cityList;

  set cityList(List<String> value) {
    _cityList = value;
  }

  List<String> get chapterList => _chapterList;

  set chapterList(List<String> value) {
    _chapterList = value;
  }

  List<String> get businessCatList => _businessCatList;

  set businessCatList(List<String> value) {
    _businessCatList = value;
  }

  List<GroupChildData> get groupChildData => _groupChildData;

  set groupChildData(List<GroupChildData> value) {
    _groupChildData = value;
  }

  String get selectedMeeting => _selectedMeeting;

  set selectedMeeting(String value) {
    _selectedMeeting = value;
  }

  String get selectedMeetingCode => _selectedMeetingCode;

  set selectedMeetingCode(String value) {
    _selectedMeetingCode = value;
  }

  List<String> get teamWiseMeetingList => _teamWiseMeetingList;

  set teamWiseMeetingList(List<String> value) {
    _teamWiseMeetingList = value;
  }

  RxInt get size => _size;

  set size(RxInt value) {
    _size = value;
  }

  XFile? get uploadedProfilePictureFile => _uploadedProfilePictureFile;

  set uploadedProfilePictureFile(XFile? value) {
    _uploadedProfilePictureFile = value;
  }

  XFile? get uploadedVCardFrontFile => _uploadedVCardFrontFile;

  set uploadedVCardFrontFile(XFile? value) {
    _uploadedVCardFrontFile = value;
  }

  XFile? get uploadedVCardBackFile => _uploadedVCardBackFile;

  set uploadedVCardBackFile(XFile? value) {
    _uploadedVCardBackFile = value;
  }

  List<VisitorChildData> get visitorData => _visitorData;

  set visitorData(List<VisitorChildData> value) {
    _visitorData = value;
  }

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
  }

  RxInt get totalPages => _totalPages;

  set totalPages(RxInt value) {
    _totalPages = value;
  }

  Future<bool> loadMore() async {
    if (page.value < totalPages.value) {
      page.value += 1;
      await getVisitors(page.value, size.value, "", "", "");
      return true;
    } else {
      return false;
    }
  }

  Future<void> initData() async {
    _isLoading = false;
    _isExpanded = false.obs;
    _isProfileImageUploadSuccess = false.obs;
    _isAgreeTerms = false.obs;
    _referralTypeInside = false.obs;
    _referralTypeOutside = true.obs;
    _page = 0.obs;
    _size = 10.obs;
    _totalPages = 0.obs;
    _dateController = TextEditingController();
    _nameController = TextEditingController();
    _contactNumberController = TextEditingController();
    _companyNameController = TextEditingController();
    _visitorData = [];
    _countryList = [];
    _stateList = [];
    _cityList = [];
    _chapterList = [];
    _selectedMeeting = "";
    _meetingsList = [];
    _selectedCountry = "Select Country";
    _selectedState = "Select State";
    _selectedCity = "Select City";
    _selectedChapter = "Select Chapter";
    _businessCatList = globalBusinessCategoryForMemberList;
    _selectedBusinessCategory = _businessCatList[0];
    _uploadedDocRespModel = new UploadedDocRespModel();
    _uploadedProfilePictureFile = null;
    _uploadedVCardFrontFile = null;
    _uploadedVCardBackFile = null;

    ///await getVisitors(page.value, size.value, "", "", "");
  }

  Future<void> getMeetingsList() async {
    _isLoading = true;
    update();

    Response response = await referralRepo.getMeetings(0, 1000, "updatedAt", "DESC");

    _isLoading = false;
    if (response.statusCode == 200) {
      _meetingsList = [];
      _teamWiseMeetingList = [];

      // Parse meetings data
      if (response.body['data'] != null) {
        response.body['data']['data'].forEach((order) {
          MeetingListResponseModel meetingRecord = MeetingListResponseModel.fromJson(order);
          print("Meeting Meet -> ${meetingRecord.team?.uuid}");
          _meetingsList.add({
            "uuid": meetingRecord.team?.uuid ?? "",
            "meetingUuid": meetingRecord?.uuid ?? "",
            "title": meetingRecord.title ?? "",
            "meetingDate": meetingRecord.meetingDate ?? "",
            "groupName": meetingRecord.team?.groupName ?? "",
          });
        });
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void teamWiseFillMeeting(String selectedTeamName) {
    _chapterList;
    _teamWiseMeetingList = [];
    _teamWiseMeetingList.add("Select Meeting (Optional)");
    List<String> groupNames = _meetingsList.where((item) => item["groupName"].toString().toLowerCase() == (selectedTeamName.toLowerCase()))
        .map((item) => item["title"].toString()).toList();
    _teamWiseMeetingList.addAll(groupNames);
    _selectedMeeting =  _teamWiseMeetingList[0].toString();
    _teamWiseMeetingList.length;
  }

  void autoFillSelectedMeetingDate(String selectedMeetingName) {
   var selectedMeeting = _meetingsList.firstWhere(
         (item) => item["title"].toString().toLowerCase() == selectedMeetingName.toLowerCase(),
     orElse: () => <String, String>{},
   );
   if (selectedMeeting.isNotEmpty) {
     DateTime dateTime = DateTime.parse(selectedMeeting["meetingDate"].toString());
     setMeetingOrSelectedDate(dateTime);
     _selectedMeetingCode = selectedMeeting["meetingUuid"].toString();
   }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setMeetingOrSelectedDate(picked);
    }
  }

  void setMeetingOrSelectedDate(DateTime picked) {
    selectedDate = picked;
    _dateController.text = DateConverter.convertDateToNumMonth(selectedDate);
  }

  Future<void> pickImage(String documentType) async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if(imageUploadType == ImageUploadType.profileImage) {
        _uploadedProfilePictureFile = picked;
      } else if(imageUploadType == ImageUploadType.frontVisitingCard) {
        _uploadedVCardFrontFile = picked;
      } else {
        _uploadedVCardBackFile = picked;
      }
      update();
      AddUploadOperationResponseModel responseModel =
          await uploadImageDocument(documentType, picked!);
      if (responseModel.status == "CREATED") {
        uploadedDocRespModel =
            UploadedDocRespModel.fromJson(responseModel.data);
        showSnackBar(responseModel.message, isError: false);
        manageIsImageUploadSuccess(true);
        // _uploadedDocumentUuid = responseModel.data['documentUuid'];
      } else {
        showSnackBar(responseModel.message);
        manageIsImageUploadSuccess(false);
        if(imageUploadType == ImageUploadType.profileImage) {
          _uploadedProfilePictureFile = null;
        } else if(imageUploadType == ImageUploadType.frontVisitingCard) {
          _uploadedVCardFrontFile = null;
        } else {
          _uploadedVCardBackFile = null;
        }
      }
    }
  }

  Future<void> clickCameraImage(String documentType) async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      if(imageUploadType == ImageUploadType.profileImage) {
        _uploadedProfilePictureFile = picked;
      } else if(imageUploadType == ImageUploadType.frontVisitingCard) {
        _uploadedVCardFrontFile = picked;
      } else {
        _uploadedVCardBackFile = picked;
      }
      update();
      AddUploadOperationResponseModel responseModel =
          await uploadImageDocument(documentType, picked!);
      if (responseModel.status == "CREATED") {
        uploadedDocRespModel =
            UploadedDocRespModel.fromJson(responseModel.data);
        showSnackBar(responseModel.message, isError: false);
        isImageUploadSuccess = true.obs;
        // _uploadedDocumentFile = responseModel.data['documentUuid'];
      } else {
        showSnackBar(responseModel.message);
        isImageUploadSuccess = false.obs;
        if(imageUploadType == ImageUploadType.profileImage) {
          _uploadedProfilePictureFile = null;
        } else if(imageUploadType == ImageUploadType.frontVisitingCard) {
          _uploadedVCardFrontFile = null;
        } else {
          _uploadedVCardBackFile = null;
        }
      }
    }
  }

  void manageIsImageUploadSuccess(bool isSuccess) {
    if(imageUploadType == ImageUploadType.profileImage) {
      isImageUploadSuccess = isSuccess.obs;
    } else if(imageUploadType == ImageUploadType.frontVisitingCard) {
      isVCardFrontSuccess = isSuccess.obs;
    } else {
      isVCardBackSuccess = isSuccess.obs;
    }
  }

  Future<AddUploadOperationResponseModel> uploadImageDocument(
      String? documentType, XFile selectedImage) async {
    _isLoading = true;
    update();
    Response response =
        await visitorsRepo.uploadImageDocument(documentType, selectedImage);
    AddUploadOperationResponseModel responseModel;
    if (response.statusCode == 201) {
      responseModel = AddUploadOperationResponseModel(
          timestamp: response.body['timestamp'],
          status: response.body['status'],
          message: response.body['message'],
          data: response.body['data'] as Map<String, dynamic>);
      if(imageUploadType == ImageUploadType.profileImage) {
        profileUrl = response.body['data']['url'];
      } else if(imageUploadType == ImageUploadType.frontVisitingCard) {
        uploadFrontVisitingCard = response.body['data']['url'];
      } else {
        uploadBackVisitingCard = response.body['data']['url'];
      }
    } else {
      responseModel = AddUploadOperationResponseModel(
          timestamp: response.body['timestamp'],
          status: response.body['status'],
          message: response.body['message']);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getVisitors(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    _visitorData = [];
    Response response =
        await visitorsRepo.getVisitors(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body['data']['data'].forEach((visitor) {
        VisitorChildData visitorChildData = VisitorChildData.fromJson(visitor);
        _visitorData.add(visitorChildData);
      });
      totalPages.value = (response.body['data']['total'] / size).round();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> addVisitors(
      String? country,
      String? state,
      String? city,
      String? groupName, // chapterName
      String? meetingCode,
      String? meetingTitle,
      String? date,
      String? businessCategory,
      String? name,
      String? email,
      String? contactNumber,
      String? companyName,
      String? addedBy,
      String? profileUrl,
      String? uploadFrontVisitingCard,
      String? uploadBackVisitingCard) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await visitorsRepo.addVisitors(
        country,
        state,
        city,
        groupName, // chapterName
        meetingCode,
        meetingTitle,
        date,
        businessCategory,
        name,
        email,
        contactNumber,
        companyName,
        addedBy,
        profileUrl,
        uploadFrontVisitingCard,
        uploadBackVisitingCard);
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

  Future<void> getGroups(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    Response response =
        await visitorsRepo.getGroups(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      _groupChildData = [];
      response.body['data']['data'].forEach((order) {
        GroupChildData groups = GroupChildData.fromJson(order);
        print("Chapter Meet -> ${order["uuid"]}");
        _groupChildData.add(groups);
      });
      if (groupChildData.isNotEmpty) {
        _chapterList.add("Select Chapter");
        for (var childData in groupChildData) {
          _chapterList.add(childData.groupName ?? "");
        }
        _selectedChapter = _chapterList[0];
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getCountries() async {
    Response response = await visitorsRepo.getCountries();
    _isLoading = false;
    if (response.statusCode == 200) {
      _countryList = [];
      _countryList.add("Select Country");
      _stateList = [];
      _stateList.add("Select State");
      _cityList = [];
      _cityList.add("Select City");

      unSortedList = [];
      response.body['data'].forEach((country) {
        unSortedList.add(country);
      });
      unSortedList.sort();
      _countryList = _countryList + unSortedList;

      _selectedCountry = _countryList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getStates(String countryName) async {
    _isLoading = true;
    update();
    Response response = await visitorsRepo.getStates(countryName);
    _isLoading = false;
    if (response.statusCode == 200) {
      _stateList = [];
      _stateList.add("Select State");
      _cityList = [];
      _cityList.add("Select City");
      unSortedList = [];
      response.body['data'].forEach((state) {
        unSortedList.add(state);
      });
      unSortedList.sort();
      _stateList = _stateList + unSortedList;
      _selectedState = _stateList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getCities(String stateName) async {
    _isLoading = true;
    update();
    Response response = await visitorsRepo.getCities(stateName);
    _isLoading = false;
    if (response.statusCode == 200) {
      _cityList = [];
      _cityList.add("Select City");
      unSortedList = [];
      response.body['data'].forEach((city) {
        unSortedList.add(city);
      });
      unSortedList.sort();
      _cityList = _cityList + unSortedList;
      _selectedCity = _cityList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
