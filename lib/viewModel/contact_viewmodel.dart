import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/contact_repo.dart';
import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactViewmodel extends GetxController implements GetxService {
  final ContactRepo contactRepo;

  ContactViewmodel({required this.contactRepo}) {}

  TextEditingController _contactNum1Controller = TextEditingController();
  TextEditingController _contactNum2Controller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  bool _isLoading = false;

  TextEditingController get contactNum1Controller => _contactNum1Controller;

  TextEditingController get contactNum2Controller => _contactNum2Controller;

  TextEditingController get emailController => _emailController;

  TextEditingController get websiteController => _websiteController;

  Future<bool> updateProfile(
      UpdateProfileRequestModel updateProfileRequestModel) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response =
        await contactRepo.updateProfile(updateProfileRequestModel);
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
