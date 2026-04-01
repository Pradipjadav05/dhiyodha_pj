import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/address_repo.dart';
import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddressViewmodel extends GetxController implements GetxService {
  final AddressRepo addressRepo;

  AddressViewmodel({required this.addressRepo}) {}

  TextEditingController _addressLine1Controller = TextEditingController();
  // TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();

  List<String> _countryList = [];
  List<String> _stateList = [];
  List<String> _cityList = [];

  TextEditingController get addressLine1Controller => _addressLine1Controller;
  String _selectedCountry = "", _selectedState = "", _selectedCity = "";

  String get selectedCountry => _selectedCountry;

  set selectedCountry(String value) {
    _selectedCountry = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  bool _isLoading = false;

  TextEditingController get countryController => _countryController;

  // TextEditingController get addressLine2Controller => _addressLine2Controller;

  TextEditingController get cityController => _cityController;

  TextEditingController get stateController => _stateController;

  TextEditingController get pinCodeController => _pinCodeController;

  List<String> get countryList => _countryList;

  List<String> get stateList => _stateList;

  set stateList(List<String> value) {
    _stateList = value;
  }

  set countryList(List<String> value) {
    _countryList = value;
  }

  Future<void> initData() async {
    _countryList = [];
    _stateList = [];
    _cityList = [];
    _selectedCountry = "Select Country";
    _selectedState = "Select State";
    _selectedCity = "Select City";
  }

  Future<bool> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response =
        await addressRepo.updateProfile(updateProfileRequestModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  Future<void> getCountries() async {
    Response response = await addressRepo.getCountries();
    _isLoading = false;
    if (response.statusCode == 200) {
      _countryList = [];
      _countryList.add("Select Country");
      _stateList = [];
      _stateList.add("Select State");
      _cityList = [];
      _cityList.add("Select City");
      response.body.forEach((country) {
        _countryList.add(country["name"]);
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
    Response response = await addressRepo.getStates(countryName);
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
    Response response = await addressRepo.getCities(stateName);
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

  List<String> get cityList => _cityList;

  set cityList(List<String> value) {
    _cityList = value;
  }

  String get selectedState => _selectedState;

  set selectedState(String value) {
    _selectedState = value;
  }

  String get selectedCity => _selectedCity;

  set selectedCity(String value) {
    _selectedCity = value;
  }
}
