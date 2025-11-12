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

class VisitorsViewModel extends GetxController implements GetxService {
  final VisitorsRepo visitorsRepo;

  VisitorsViewModel({required this.visitorsRepo}) {}

  bool _isLoading = false;
  RxBool _isExpanded = false.obs;
  RxBool _isAgreeTerms = false.obs;
  RxBool _isImageUploadSuccess = false.obs;
  RxBool _referralTypeInside = false.obs;
  RxBool _referralTypeOutside = true.obs;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  String _selectedCountry = "",
      _selectedState = "",
      _selectedCity = "",
      _selectedChapter = "",
      _selectedBusinessCategory = "";
  List<String> _countryList = [];
  List<String> _stateList = [];
  List<String> _cityList = [];
  List<String> _chapterList = [];
  List<String> _businessCatList = [];
  List<GroupChildData> _groupChildData = [];
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;

  UploadedDocRespModel _uploadedDocRespModel = new UploadedDocRespModel();

  XFile? _uploadedDocumentFile;
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

  RxBool get isImageUploadSuccess => _isImageUploadSuccess;

  set isImageUploadSuccess(RxBool value) {
    _isImageUploadSuccess = value;
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

  RxInt get size => _size;

  set size(RxInt value) {
    _size = value;
  }

  XFile? get uploadedDocumentFile => _uploadedDocumentFile;

  set uploadedDocumentFile(XFile? value) {
    _uploadedDocumentFile = value;
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
    _isImageUploadSuccess = false.obs;
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
    _selectedCountry = "Select Country";
    _selectedState = "Select State";
    _selectedCity = "Select City";
    _selectedChapter = "Select Chapter";
    _businessCatList = globalBusinessCategoryForMemberList;
    _selectedBusinessCategory = _businessCatList[0];
    _uploadedDocRespModel = new UploadedDocRespModel();
    _uploadedDocumentFile = null;

    ///await getVisitors(page.value, size.value, "", "", "");
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _dateController.text = DateConverter.convertDateToNumMonth(selectedDate);
    }
  }

  Future<void> pickImage(String documentType) async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _uploadedDocumentFile = picked;
      update();
      AddUploadOperationResponseModel responseModel =
          await uploadImageDocument(documentType, _uploadedDocumentFile!);
      if (responseModel.status == "CREATED") {
        uploadedDocRespModel =
            UploadedDocRespModel.fromJson(responseModel.data);
        showSnackBar(responseModel.message, isError: false);
        isImageUploadSuccess = true.obs;
        // _uploadedDocumentUuid = responseModel.data['documentUuid'];
      } else {
        showSnackBar(responseModel.message);
        isImageUploadSuccess = false.obs;
        _uploadedDocumentFile = null;
      }
    }
  }

  Future<void> clickCameraImage(String documentType) async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      _uploadedDocumentFile = picked;
      update();
      AddUploadOperationResponseModel responseModel =
          await uploadImageDocument(documentType, _uploadedDocumentFile!);
      if (responseModel.status == "CREATED") {
        uploadedDocRespModel =
            UploadedDocRespModel.fromJson(responseModel.data);
        showSnackBar(responseModel.message, isError: false);
        isImageUploadSuccess = true.obs;
        // _uploadedDocumentFile = responseModel.data['documentUuid'];
      } else {
        showSnackBar(responseModel.message);
        isImageUploadSuccess = false.obs;
        _uploadedDocumentFile = null;
      }
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
      String? uuId,
      String? country,
      String? state,
      String? city,
      String? chapter,
      String? date,
      String? businessCategory,
      String? name,
      String? contactNumber,
      String? companyName,
      String? addedBy,
      String? groupName,
      String? title,
      String? meetingCode,
      String? meetingDate,
      String? referral,
      String? email,
      UploadedDocRespModel? uploadedDoc) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await visitorsRepo.addVisitors(
        uuId,
        country,
        state,
        city,
        chapter,
        date,
        businessCategory,
        name,
        contactNumber,
        companyName,
        addedBy,
        groupName,
        title,
        meetingCode,
        meetingDate,
        referral,
        email,
        uploadedDoc);
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
      response.body['data'].forEach((country) {
        _countryList.add(country);
      });
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
      response.body['data'].forEach((state) {
        _stateList.add(state);
      });
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
      response.body['data'].forEach((city) {
        _cityList.add(city);
      });
      _selectedCity = _cityList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
