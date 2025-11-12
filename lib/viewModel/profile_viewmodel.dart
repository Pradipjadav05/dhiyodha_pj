import 'package:dhiyodha/data/repository/profile_repo.dart';
import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController implements GetxService {
  final ProfileRepo profileRepo;

  bool _isLoading = false;

  ProfileViewModel({required this.profileRepo}) {}
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _reTypePasswordController = TextEditingController();

  TextEditingController get oldPasswordController => _oldPasswordController;

  set oldPasswordController(TextEditingController value) {
    _oldPasswordController = value;
  }

  TextEditingController get passwordController => _passwordController;

  set passwordController(TextEditingController value) {
    _passwordController = value;
  }

  TextEditingController get reTypePasswordController =>
      _reTypePasswordController;

  set reTypePasswordController(TextEditingController value) {
    _reTypePasswordController = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  Future<ResponseModel> updatePassword(
      String oldPassword, String newPassword, String retypePassword) async {
    _isLoading = true;
    update();
    Response response = await profileRepo.updatePassword(
        oldPassword, newPassword, retypePassword);
    _isLoading = false;
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    update();
    return responseModel;
  }
}
