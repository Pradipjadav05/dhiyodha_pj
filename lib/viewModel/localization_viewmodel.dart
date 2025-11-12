import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationViewModel extends GetxController {
  final SharedPreferences sharedPreferences;

  LocalizationViewModel({required this.sharedPreferences}) {
    //, required this.apiClient
    loadCurrentLanguage();
  }

  Future<void> initData() async {
    languageList = [];
    languageList.add("English");
    languageList.add("हिंदी");
    selectedLanguage = globalSelectedLanguage.isNotEmpty
        ? globalSelectedLanguage
        : languageList[0];
  }

  Locale _locale =
      Locale(languagesList[0].languageCode!, languagesList[0].countryCode);
  bool _isLtr = true;
  int _selectedIndex = 0;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int get selectedIndex => _selectedIndex;

  List<String> _languageList = [];

  List<String> get languageList => _languageList;

  String _selectedLanguage = "";

  String get selectedLanguage => _selectedLanguage;

  set selectedLanguage(String value) {
    _selectedLanguage = value;
  }

  set languageList(List<String> value) {
    _languageList = value;
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    // apiClient.updateHeader(
    //     sharedPreferences.getString(AppConstants.token), locale.languageCode,
    //     Get.find<AuthController>().profileModel != null ? Get.find<AuthController>().profileModel!.stores![0].module!.id : null,
    //     sharedPreferences.getString(AppConstants.type)
    // );
    saveLanguage(_locale);
    // if (Get.find<AuthController>().isLoggedIn()) {
    //   Get.find<StoreController>().getItemList('1', 'all');
    // }
    update();
  }

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(languageCode) ??
            languagesList[0].languageCode!,
        sharedPreferences.getString(countryCode) ??
            languagesList[0].countryCode);
    for (int index = 0; index < languagesList.length; index++) {
      if (_locale.languageCode == languagesList[index].languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(languageCode, locale.languageCode);
    sharedPreferences.setString(countryCode, locale.countryCode!);
  }
}
