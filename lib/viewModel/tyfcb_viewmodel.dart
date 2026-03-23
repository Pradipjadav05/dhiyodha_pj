import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/tyfcb_repo.dart';
import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:dhiyodha/model/response_model/tyfcb_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TyfcbViewModel extends GetxController implements GetxService {
  final TyfcbRepo tyfcbRepo;

  TyfcbViewModel({required this.tyfcbRepo}) {}

  RxBool _businessTypeNew = true.obs,
      _businessTypeRepeat = false.obs,
      _referralTypeInside = false.obs,
      _referralTypeOutside = true.obs,
      _referralTypeTire = false.obs,
      _isExpanded = false.obs;

  String _selectedMemberId = "";

  String get selectedMemberId => _selectedMemberId;

  set selectedMemberId(String value) {
    _selectedMemberId = value;
  }

  TextEditingController _tyfcbToController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalDataSize = 0.obs;

  ScrollController get scrollController => _scrollController;

  set scrollController(ScrollController value) {
    _scrollController = value;
  }

  TextEditingController get tyfcbToController => _tyfcbToController;

  List<TyfcbChildData> _tyfcbList = [];

  List<TyfcbChildData> get tyfcbList => _tyfcbList;

  set tyfcbList(List<TyfcbChildData> value) {
    _tyfcbList = value;
  }

  get isExpanded => _isExpanded;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  set isExpanded(value) {
    _isExpanded = value;
  }

  get referralTypeTire => _referralTypeTire;

  set referralTypeTire(value) {
    _referralTypeTire = value;
  }

  get referralTypeOutside => _referralTypeOutside;

  set referralTypeOutside(value) {
    _referralTypeOutside = value;
  }

  get referralTypeInside => _referralTypeInside;

  set referralTypeInside(value) {
    _referralTypeInside = value;
  }

  get businessTypeRepeat => _businessTypeRepeat;

  set businessTypeRepeat(value) {
    _businessTypeRepeat = value;
  }

  get businessTypeNew => _businessTypeNew;

  set businessTypeNew(value) {
    _businessTypeNew = value;
  }

  TextEditingController get amountController => _amountController;

  TextEditingController get commentsController => _commentsController;

  bool _isLoading = false;

  Future<void> initData() async {
    _businessTypeNew = true.obs;
    _businessTypeRepeat = false.obs;
    _referralTypeInside = false.obs;
    _referralTypeOutside = true.obs;
    _referralTypeTire = false.obs;
    _isExpanded = false.obs;
    _selectedMemberId = "";
    _tyfcbList = [];
    _amountController = TextEditingController();
    _tyfcbToController = TextEditingController();
    _commentsController = TextEditingController();
    _isLoading = false;
    _scrollController = ScrollController();
    _page = 0.obs;
    _size = 10.obs;
    _totalDataSize = 0.obs;
  }

  Future<ResponseModel> createAppreciateNote(
      String? recipientId,
      String? giftAmount,
      String? businessType,
      String? referralType,
      String? comments) async {
    _isLoading = true;
    update();
    Response response = await tyfcbRepo.createAppreciateNote(
        recipientId, giftAmount, businessType, referralType, comments);
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

  Future<void> getTyfcbData(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();

    Response response =
    await tyfcbRepo.getTyfcbData(page, size, sort, orderBy, search);

    if (response.statusCode == 200) {
      TyfcbResponseModel model =
      TyfcbResponseModel.fromJson(response.body);

      _tyfcbList = model.tyfcbData?.tyfcbChildData ?? [];
      _totalDataSize.value = model.tyfcbData?.total ?? 0;
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
  }

  RxInt get page => _page;

  set page(RxInt value) {
    _page = value;
  }

  RxInt get size => _size;

  set size(RxInt value) {
    _size = value;
  }

  RxInt get totalDataSize => _totalDataSize;

  set totalDataSize(RxInt value) {
    _totalDataSize = value;
  }
}
