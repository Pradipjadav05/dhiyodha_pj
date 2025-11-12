import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/members_repo.dart';
import 'package:dhiyodha/model/response_model/groups_response_model.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/model/response_model/my_testimonial_response_model.dart';
import 'package:dhiyodha/model/response_model/world_wide_search_response_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MembersViewmodel extends GetxController implements GetxService {
  final MembersRepo membersRepo;

  MembersViewmodel({required this.membersRepo}) {}

  RxBool _isChapterRoster = true.obs;
  RxBool _isWorldWide = false.obs;
  RxBool _isWorldWideListShow = false.obs;
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;
  TextEditingController _memberSearchController = TextEditingController();
  List<MembersChildData> _membersData = [];
  List<WorldWideMembers> _worldWiseMembersData = [];
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
  List<TestimonialChildData> _testimonialDataList = [];
  TextEditingController _memberNameController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();

  RxInt get totalPages => _totalPages;

  set totalPages(RxInt value) {
    _totalPages = value;
  }

  TextEditingController get memberSearchController => _memberSearchController;

  set memberSearchController(TextEditingController value) {
    _memberSearchController = value;
  }

  RxInt get page => _page;

  set page(RxInt value) {
    _page = value;
  }

  RxInt get size => _size;

  List<WorldWideMembers> get worldWiseMembersData => _worldWiseMembersData;

  set worldWiseMembersData(List<WorldWideMembers> value) {
    _worldWiseMembersData = value;
  }

  List<MembersChildData> get membersData => _membersData;

  set membersData(List<MembersChildData> value) {
    _membersData = value;
  }

  RxBool get isWorldWideListShow => _isWorldWideListShow;

  set isWorldWideListShow(RxBool value) {
    _isWorldWideListShow = value;
  }

  List<TestimonialChildData> get testimonialDataList => _testimonialDataList;

  set testimonialDataList(List<TestimonialChildData> value) {
    _testimonialDataList = value;
  }

  List<GroupChildData> _groupChildData = [];

  List<GroupChildData> get groupChildData => _groupChildData;

  set groupChildData(List<GroupChildData> value) {
    _groupChildData = value;
  }

  List<String> get businessCatList => _businessCatList;

  set businessCatList(List<String> value) {
    _businessCatList = value;
  }

  get selectedBusinessCategory => _selectedBusinessCategory;

  set selectedBusinessCategory(value) {
    _selectedBusinessCategory = value;
  }

  Future<void> initData() async {
    _isLoading = false;
    _isChapterRoster = true.obs;
    _isWorldWide = false.obs;
    _isWorldWideListShow = false.obs;
    _page = 0.obs;
    _size = 10.obs;
    _totalPages = 0.obs;
    _memberNameController = TextEditingController();
    _companyNameController = TextEditingController();
    _companyNameController = TextEditingController();
    _memberSearchController = TextEditingController();
    _membersData = [];
    _worldWiseMembersData = [];
    _testimonialDataList = [];
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
    await getUsersOrMembers(page.value, size.value, "", "", "");
  }

  RxBool get isChapterRoster => _isChapterRoster;

  set isChapterRoster(RxBool value) {
    _isChapterRoster = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  bool _isLoading = false;

  RxBool get isWorldWide => _isWorldWide;

  set isWorldWide(RxBool value) {
    _isWorldWide = value;
  }

  List<String> get chapterList => _chapterList;

  set chapterList(List<String> value) {
    _chapterList = value;
  }

  List<String> get cityList => _cityList;

  set cityList(List<String> value) {
    _cityList = value;
  }

  List<String> get stateList => _stateList;

  set stateList(List<String> value) {
    _stateList = value;
  }

  List<String> get countryList => _countryList;

  set countryList(List<String> value) {
    _countryList = value;
  }

  String get selectedChapter => _selectedChapter;

  set selectedChapter(String value) {
    _selectedChapter = value;
  }

  get selectedCity => _selectedCity;

  set selectedCity(value) {
    _selectedCity = value;
  }

  get selectedState => _selectedState;

  set selectedState(value) {
    _selectedState = value;
  }

  String get selectedCountry => _selectedCountry;

  set selectedCountry(String value) {
    _selectedCountry = value;
  }

  TextEditingController get companyNameController => _companyNameController;

  set companyNameController(TextEditingController value) {
    _companyNameController = value;
  }

  TextEditingController get memberNameController => _memberNameController;

  set memberNameController(TextEditingController value) {
    _memberNameController = value;
  }

  Future<bool> loadMore() async {
    if (page.value < totalPages.value) {
      page.value += 1;
      await getUsersOrMembers(page.value, size.value, "", "", "");
      return true;
    } else {
      return false;
    }
  }

  Future<void> getUsersOrMembers(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    Response response =
        await membersRepo.getUsersOrMembers(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body['data']['data'].forEach((order) {
        MembersChildData membersChildData = MembersChildData.fromJson(order);
        _membersData.add(membersChildData);
      });
      totalPages.value = (response.body['data']['total'] / size).round();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> searchType(String? searchType, String? search) async {
    _isLoading = true;
    update();
    Response response = await membersRepo.searchType(searchType, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      try {
        if (response.body != null) {
          _membersData = [];
          response.body['data'].forEach((order) {
            MembersChildData membersChildData =
                MembersChildData.fromJson(order);
            _membersData.add(membersChildData);
          });
        }
      } catch (e) {
        ApiChecker.checkApi(response);
        update();
        showSnackBar("no_member_found".tr);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getGroups(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    Response response =
        await membersRepo.getGroups(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      _groupChildData = [];
      _chapterList = [];
      _selectedChapter = "";
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

  Future<void> getWorldWideSearchedUsersOrMembers(
      String? city,
      String? state,
      String? country,
      String? name,
      String? businessCategory,
      String? chapter) async {
    _isLoading = true;
    update();
    Response response = await membersRepo.getWorldWideSearchedUsersOrMembers(
        city, state, country, name, businessCategory, chapter);
    _isLoading = false;
    if (response.statusCode == 200) {
      _worldWiseMembersData = [];
      if (response.body['data'] != null && response.body['data'] != []) {
        response.body['data'].forEach((order) {
          WorldWideMembers worldWideMembers = WorldWideMembers.fromJson(order);
          _worldWiseMembersData.add(worldWideMembers);
        });
      }
      if (_worldWiseMembersData.isNotEmpty) {
        _isWorldWideListShow.value = true;
      } else {
        _isWorldWideListShow.value = false;
        showSnackBar("no_member_found".tr);
      }
    } else {
      showSnackBar("no_member_found".tr);
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getCountries() async {
    Response response = await membersRepo.getCountries();
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
    Response response = await membersRepo.getStates(countryName);
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
    Response response = await membersRepo.getCities(stateName);
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

  Future<void> getUserWiseTestimonial(String userId) async {
    Response response = await membersRepo.getUserTestimonial(userId);
    if (response.statusCode == 200) {
      _testimonialDataList = [];
      response.body['data'].forEach((order) {
        TestimonialChildData testimonialChildData =
            TestimonialChildData.fromJson(order);
        _testimonialDataList.add(testimonialChildData);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
