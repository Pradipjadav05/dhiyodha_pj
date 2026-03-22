import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/members_repo.dart';
import 'package:dhiyodha/model/response_model/groups_response_model.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/model/response_model/my_testimonial_response_model.dart';
import 'package:dhiyodha/model/response_model/world_wide_search_response_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MembersViewmodel extends GetxController implements GetxService {
  final MembersRepo membersRepo;

  MembersViewmodel({required this.membersRepo});

  RxBool _isChapterRoster = true.obs;
  RxBool _isWorldWide = false.obs;
  RxBool _isWorldWideListShow = false.obs;
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;
  TextEditingController _memberSearchController = TextEditingController();
  TextEditingController _memberNameController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();

  // ── FIX: separate lists — never mix chapter roster and worldwide data ──
  List<MembersChildData> _membersData = [];
  List<WorldWideMembers> _worldWiseMembersData = [];
  List<GroupChildData> _groupChildData = [];
  List<TestimonialChildData> _testimonialDataList = [];

  String _selectedCountry = 'Select Country';
  String _selectedState = 'Select State';
  String _selectedCity = 'Select City';
  String _selectedChapter = 'Select Chapter';
  String _selectedBusinessCategory = '';

  List<String> _countryList = [];
  List<String> _stateList = [];
  List<String> _cityList = [];
  List<String> _chapterList = [];
  List<String> _businessCatList = [];

  bool _isLoading = false;

  // ── Getters ──
  RxBool get isChapterRoster => _isChapterRoster;

  RxBool get isWorldWide => _isWorldWide;

  RxBool get isWorldWideListShow => _isWorldWideListShow;

  RxInt get page => _page;

  RxInt get size => _size;

  RxInt get totalPages => _totalPages;

  bool get isLoading => _isLoading;

  TextEditingController get memberSearchController => _memberSearchController;

  TextEditingController get memberNameController => _memberNameController;

  TextEditingController get companyNameController => _companyNameController;

  List<MembersChildData> get membersData => _membersData;

  List<WorldWideMembers> get worldWiseMembersData => _worldWiseMembersData;

  List<GroupChildData> get groupChildData => _groupChildData;

  List<TestimonialChildData> get testimonialDataList => _testimonialDataList;

  List<String> get countryList => _countryList;

  List<String> get stateList => _stateList;

  List<String> get cityList => _cityList;

  List<String> get chapterList => _chapterList;

  List<String> get businessCatList => _businessCatList;

  String get selectedCountry => _selectedCountry;

  String get selectedState => _selectedState;

  get selectedCity => _selectedCity;

  get selectedChapter => _selectedChapter;

  get selectedBusinessCategory => _selectedBusinessCategory;

  // ── Setters ──
  set isChapterRoster(RxBool v) => _isChapterRoster = v;

  set isWorldWide(RxBool v) => _isWorldWide = v;

  set isWorldWideListShow(RxBool v) => _isWorldWideListShow = v;

  set page(RxInt v) => _page = v;

  set totalPages(RxInt v) => _totalPages = v;

  set isLoading(bool v) => _isLoading = v;

  set memberSearchController(TextEditingController v) =>
      _memberSearchController = v;

  set memberNameController(TextEditingController v) =>
      _memberNameController = v;

  set companyNameController(TextEditingController v) =>
      _companyNameController = v;

  set membersData(List<MembersChildData> v) => _membersData = v;

  set worldWiseMembersData(List<WorldWideMembers> v) =>
      _worldWiseMembersData = v;

  set groupChildData(List<GroupChildData> v) => _groupChildData = v;

  set testimonialDataList(List<TestimonialChildData> v) =>
      _testimonialDataList = v;

  set countryList(List<String> v) => _countryList = v;

  set stateList(List<String> v) => _stateList = v;

  set cityList(List<String> v) => _cityList = v;

  set chapterList(List<String> v) => _chapterList = v;

  set businessCatList(List<String> v) => _businessCatList = v;

  set selectedCountry(String v) => _selectedCountry = v;

  set selectedState(v) => _selectedState = v;

  set selectedCity(v) => _selectedCity = v;

  set selectedChapter(v) => _selectedChapter = v;

  set selectedBusinessCategory(v) => _selectedBusinessCategory = v;

  // ────────────────────────────────────────────────────────────
  // initData
  // ────────────────────────────────────────────────────────────
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
    _memberSearchController = TextEditingController();

    // ── FIX: always clear both lists on init ──
    _membersData = [];
    _worldWiseMembersData = [];
    _testimonialDataList = [];
    _groupChildData = [];

    _countryList = [];
    _stateList = [];
    _cityList = [];
    _chapterList = [];
    _selectedCountry = 'Select Country';
    _selectedState = 'Select State';
    _selectedCity = 'Select City';
    _selectedChapter = 'Select Chapter';
    _businessCatList = globalBusinessCategoryForMemberList;
    _selectedBusinessCategory = _businessCatList[0];

    // ── Load first page of chapter roster ──
    await getUsersOrMembers(_page.value, _size.value, '', '', '');
  }

  // ────────────────────────────────────────────────────────────
  // loadMore — for chapter roster pagination
  // ────────────────────────────────────────────────────────────
  Future<bool> loadMore() async {
    if (_page.value < _totalPages.value) {
      _page.value += 1;
      await getUsersOrMembers(_page.value, _size.value, '', '', '');
      return true;
    }
    return false;
  }

  // ────────────────────────────────────────────────────────────
  // getUsersOrMembers — chapter roster
  //
  // FIX: clear _membersData before loading page 0 (fresh load/reload).
  // On loadMore (page > 0) keep appending.
  // ────────────────────────────────────────────────────────────
  Future<void> getUsersOrMembers(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();

    // ── Clear list only on fresh load (page 0), not on paginate ──
    if (page == 0) {
      _membersData = [];
    }

    final Response response =
        await membersRepo.getUsersOrMembers(page, size, sort, orderBy, search);
    _isLoading = false;

    if (response.statusCode == 200) {
      response.body['data']['data'].forEach((item) {
        _membersData.add(MembersChildData.fromJson(item));
      });
      _totalPages.value = (response.body['data']['total'] / size).round();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // searchType — chapter roster search
  // ────────────────────────────────────────────────────────────
  Future<void> searchType(String? searchType, String? search) async {
    _isLoading = true;
    _membersData = [];
    update();

    final Response response = await membersRepo.searchType(searchType, search);
    _isLoading = false;

    if (response.statusCode == 200) {
      try {
        if (response.body != null && response.body['data'] != null) {
          response.body['data'].forEach((item) {
            _membersData.add(MembersChildData.fromJson(item));
          });
        }
      } catch (e) {
        showSnackBar('no_member_found'.tr);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // getGroups — loads chapter list for worldwide search dropdown
  // ────────────────────────────────────────────────────────────
  Future<void> getGroups(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();

    final Response response =
        await membersRepo.getGroups(page, size, sort, orderBy, search);
    _isLoading = false;

    if (response.statusCode == 200) {
      _groupChildData = [];
      _chapterList = ['Select Chapter'];
      _selectedChapter = _chapterList[0];

      response.body['data']['data'].forEach((item) {
        final GroupChildData group = GroupChildData.fromJson(item);
        _groupChildData.add(group);
        _chapterList.add(group.groupName ?? '');
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // getWorldWideSearchedUsersOrMembers
  //
  // FIX: always clears _worldWiseMembersData before new search.
  // Never touches _membersData — the two lists are fully separate.
  // ────────────────────────────────────────────────────────────
  Future<void> getWorldWideSearchedUsersOrMembers(
    String? city,
    String? state,
    String? country,
    String? name,
    String? businessCategory,
    String? chapter,
  ) async {
    _isLoading = true;
    _worldWiseMembersData = []; // ← always clear before new search
    update();

    final Response response =
        await membersRepo.getWorldWideSearchedUsersOrMembers(
            city, state, country, name, businessCategory, chapter);
    _isLoading = false;

    if (response.statusCode == 200) {
      if (response.body['data'] != null) {
        response.body['data'].forEach((item) {
          _worldWiseMembersData.add(WorldWideMembers.fromJson(item));
        });
      }
      if (_worldWiseMembersData.isNotEmpty) {
        _isWorldWideListShow.value = true;
      } else {
        _isWorldWideListShow.value = false;
        showSnackBar('no_member_found'.tr);
      }
    } else {
      showSnackBar('no_member_found'.tr);
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // Location dropdowns
  // ────────────────────────────────────────────────────────────
  Future<void> getCountries() async {
    final Response response = await membersRepo.getCountries();
    if (response.statusCode == 200) {
      _countryList = ['Select Country'];
      _stateList = ['Select State'];
      _cityList = ['Select City'];
      _selectedState = _stateList[0];
      _selectedCity = _cityList[0];
      response.body['data'].forEach((c) => _countryList.add(c));
      _selectedCountry = _countryList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getStates(String countryName) async {
    _isLoading = true;
    update();
    final Response response = await membersRepo.getStates(countryName);
    _isLoading = false;
    if (response.statusCode == 200) {
      _stateList = ['Select State'];
      _cityList = ['Select City'];
      _selectedCity = _cityList[0];
      response.body['data'].forEach((s) => _stateList.add(s));
      _selectedState = _stateList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getCities(String stateName) async {
    _isLoading = true;
    update();
    final Response response = await membersRepo.getCities(stateName);
    _isLoading = false;
    if (response.statusCode == 200) {
      _cityList = ['Select City'];
      response.body['data'].forEach((c) => _cityList.add(c));
      _selectedCity = _cityList[0];
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // ────────────────────────────────────────────────────────────
  // Testimonials
  // ────────────────────────────────────────────────────────────
  Future<void> getUserWiseTestimonial(String userId) async {
    final Response response = await membersRepo.getUserTestimonial(userId);
    if (response.statusCode == 200) {
      _testimonialDataList = [];
      response.body['data'].forEach((item) {
        _testimonialDataList.add(TestimonialChildData.fromJson(item));
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
