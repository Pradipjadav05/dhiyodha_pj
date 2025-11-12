import 'package:dhiyodha/data/repository/posts_repo.dart';
import 'package:dhiyodha/model/response_model/add_upload_operation_response_model.dart';
import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostsViewModel extends GetxController implements GetxService {
  final PostsRepo postsRepo;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;
  RxBool _isImageUploadSuccess = false.obs;
  String? _uploadedDocumentUuid = "";
  XFile? _postImageFile;
  RxInt selectedRegionVal = 1.obs;
  RxString regionValue = "".obs;

  PostsViewModel({required this.postsRepo}) {}

  TextEditingController get titleController => _titleController;

  set titleController(TextEditingController value) {
    _titleController = value;
  }

  RxBool get isImageUploadSuccess => _isImageUploadSuccess;

  set isImageUploadSuccess(RxBool value) {
    _isImageUploadSuccess = value;
  }

  void setSelectedRegionVal(int value) {
    selectedRegionVal.value = value;
  }

  bool get isLoading => _isLoading;

  XFile? get postImageFile => _postImageFile;

  set isLoading(bool value) {
    _isLoading = value;
  }

  TextEditingController get contentController => _contentController;

  set contentController(TextEditingController value) {
    _contentController = value;
  }

  Future<void> initData() async {
    _postImageFile = null;
    _uploadedDocumentUuid = "";
    _isImageUploadSuccess = false.obs;
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _isLoading = false;
    selectedRegionVal = 1.obs;
    regionValue = "Chapter".toUpperCase().obs;
  }

  Future<void> pickImage(String documentType) async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _postImageFile = picked;
      update();
      AddUploadOperationResponseModel responseModel =
          await uploadImageDocument(documentType, _postImageFile!);
      if (responseModel.status == "CREATED") {
        showSnackBar(responseModel.message, isError: false);
        _uploadedDocumentUuid = responseModel.data['documentUuid'];
        // UploadedDocRespModel? uploadedDocRespModel = responseModel.data;
        // _uploadedDocumentUuid = uploadedDocRespModel?.documentUuid ?? "";
        isImageUploadSuccess = true.obs;
      } else {
        showSnackBar(responseModel.message);
        isImageUploadSuccess = false.obs;
        _postImageFile = null;
      }
    }
  }

  Future<void> clickCameraImage(String documentType) async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      _postImageFile = picked;
      update();
      AddUploadOperationResponseModel responseModel =
          await uploadImageDocument(documentType, _postImageFile!);
      if (responseModel.status == "CREATED") {
        showSnackBar(responseModel.message, isError: false);
        _uploadedDocumentUuid = responseModel.data['documentUuid'];
        // UploadedDocRespModel? uploadedDocRespModel = responseModel.data;
        // _uploadedDocumentUuid = uploadedDocRespModel?.documentUuid ?? "";
        isImageUploadSuccess = true.obs;
      } else {
        showSnackBar(responseModel.message);
        isImageUploadSuccess = false.obs;
        _postImageFile = null;
      }
    }
  }

  Future<AddUploadOperationResponseModel> uploadImageDocument(
      String? documentType, XFile selectedImage) async {
    _isLoading = true;
    update();
    Response response =
        await postsRepo.uploadImageDocument(documentType, selectedImage);
    AddUploadOperationResponseModel responseModel;
    if (response.statusCode == 201) {
      responseModel = AddUploadOperationResponseModel(
          timestamp: response.body['timestamp'],
          status: response.body['status'],
          message: response.body['message'],
          data: response.body['data']);
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

  Future<ResponseModel> addPost(
      String? content, String? postRegion, bool? active) async {
    _isLoading = true;
    update();
    Response response = await postsRepo.addPost(
        content, _uploadedDocumentUuid, postRegion, active);
    ResponseModel responseModel;
    if (response.statusCode == 201) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
