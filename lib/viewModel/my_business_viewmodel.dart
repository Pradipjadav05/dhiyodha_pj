import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/my_business_repo.dart';
import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyBusinessViewModel extends GetxController implements GetxService {
  final MyBusinessRepo myBusinessRepo;

  MyBusinessViewModel({required this.myBusinessRepo}) {}

  TextEditingController _businessDetailsController = TextEditingController();

  TextEditingController get businessDetailsController =>
      _businessDetailsController;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  Future<bool> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response =
        await myBusinessRepo.updateProfile(updateProfileRequestModel);
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
}
