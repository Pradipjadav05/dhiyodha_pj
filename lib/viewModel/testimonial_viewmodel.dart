import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/testimonial_repo.dart';
import 'package:dhiyodha/model/request_model/add_testimonial_request_model.dart';
import 'package:dhiyodha/model/response_model/my_testimonial_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialViewModel extends GetxController implements GetxService {
  final TestimonialRepo testimonialRepo;

  TestimonialViewModel({required this.testimonialRepo}) {}

  RxBool _isExpanded = false.obs;
  RxBool _isAgreeTerms = false.obs;

  TextEditingController _tyfcbToController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();
  TextEditingController _testimonialController = TextEditingController();
  List<MyTestimonialChildData> _myTestimonialList = [];
  bool _isLoading = false;
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;

  TextEditingController get tyfcbToController => _tyfcbToController;

  TextEditingController get testimonialController => _testimonialController;

  set testimonialController(TextEditingController value) {
    _testimonialController = value;
  }

  RxBool get isExpanded => _isExpanded;

  set isExpanded(RxBool value) {
    _isExpanded = value;
  }

  RxBool get isAgreeTerms => _isAgreeTerms;

  set isAgreeTerms(RxBool value) {
    _isAgreeTerms = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  TextEditingController get amountController => _amountController;

  TextEditingController get commentsController => _commentsController;

  RxInt get page => _page;

  set page(RxInt value) {
    _page = value;
  }

  RxInt get size => _size;

  set size(RxInt value) {
    _size = value;
  }

  List<MyTestimonialChildData> get myTestimonialList => _myTestimonialList;

  set myTestimonialList(List<MyTestimonialChildData> value) {
    _myTestimonialList = value;
  }

  RxInt get totalPages => _totalPages;

  set totalPages(RxInt value) {
    _totalPages = value;
  }

  RxBool _isSenderTab = true.obs;

  RxBool get isSenderTab => _isSenderTab;

  set isSenderTab(RxBool value) {
    _isSenderTab = value;
  }

  List<MyTestimonialChildData> senderList = [];
  List<MyTestimonialChildData> receiverList = [];

  Future<void> initData() async {
    _myTestimonialList = [];
    _isLoading = false;
    _page = 0.obs;
    _size = 10.obs;
    _totalPages = 0.obs;
    _isExpanded = false.obs;
    _isAgreeTerms = false.obs;
    _tyfcbToController = TextEditingController();
    _amountController = TextEditingController();
    _commentsController = TextEditingController();
    _testimonialController = TextEditingController();
    // _myTestimonialList = [];
  }

  Future<bool> loadMore() async {
    if (page.value < totalPages.value) {
      page.value += 1;
      await getMyTestimonial(page.value, size.value, "", "", "");
      return true;
    } else {
      return false;
    }
  }

  Future<void> getMyTestimonial(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    Response response = await testimonialRepo.getMyTestimonial(
        page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body['data']['data'].forEach((order) {
        MyTestimonialChildData testimonialChildData =
            MyTestimonialChildData.fromJson(order);
        _myTestimonialList.add(testimonialChildData);
      });
      totalPages.value = (response.body['data']['total'] / size).round();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> deleteTestimonial(String? testimonialID) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await testimonialRepo.deleteTestimonial(testimonialID);
    _isLoading = false;
    if (response.statusCode == 204) {
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi(response);
    }
    update();
    return isSuccess;
  }

  Future<bool> addTestimonial(
      AddTestimonialRequestModel addTestimonialRequestModel) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response =
        await testimonialRepo.addTestimonial(addTestimonialRequestModel);
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

  List<MyTestimonialChildData> testimonialSenderList = [];
  List<MyTestimonialChildData> testimonialReceiverList = [];

  void setDashboardTestimonials(Map<String, dynamic> weekly) {

    testimonialSenderList = [];
    testimonialReceiverList = [];

    /// Sender
    if (weekly['testimonials'] != null) {
      for (var v in weekly['testimonials']['list']) {
        testimonialSenderList.add(MyTestimonialChildData.fromJson({
          "reviewerFirstName": v['fullName']?.split(" ").first,
          "reviewerLastName": v['fullName']?.split(" ").length > 1
              ? v['fullName']?.split(" ").last
              : "",
          "reviewerPofileUrl": v['profileImage'],
          "type": v['designation'],
          "review": v['companyName'],
        }));
      }
    }

    /// Receiver
    if (weekly['testimonialReviewers'] != null) {
      for (var v in weekly['testimonialReviewers']['list']) {
        testimonialReceiverList.add(MyTestimonialChildData.fromJson({
          "reviewerFirstName": v['fullName']?.split(" ").first,
          "reviewerLastName": v['fullName']?.split(" ").length > 1
              ? v['fullName']?.split(" ").last
              : "",
          "reviewerPofileUrl": v['profileImage'],
          "type": v['designation'],
          "review": v['companyName'],
        }));
      }
    }

    update();
  }
}
