import 'dart:async';

import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/asks_repo.dart';
import 'package:dhiyodha/model/response_model/ask_answers_response_model.dart';
import 'package:dhiyodha/model/response_model/ask_list_response_model.dart';
import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class AsksViewModel extends GetxController implements GetxService {
  final AsksRepo asksRepo;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  List<AskListChild> _asksList = [];
  List<AnswerList> _answerList = [];
  RxString _selectedFilter = "".obs;
  RxInt selectedAsTypeVal = 1.obs;
  RxInt selectedRegionVal = 1.obs;
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;
  RxString askTypeValue = "".obs;
  RxString regionValue = "".obs;
  RxBool _isAllPostPage = true.obs;
  RxBool _isContactLoading = false.obs;
  RxString _contactSearchQuery = ''.obs;
  final List<Contact> _contacts = [];
  bool _isLoading = false;

  RxInt get size => _size;

  set size(RxInt value) {
    _size = value;
  }

  RxString get selectedFilter => _selectedFilter;

  set selectedFilter(RxString value) {
    _selectedFilter = value;
  }

  RxInt get totalPages => _totalPages;

  set totalPages(RxInt value) {
    _totalPages = value;
  }

  RxInt get page => _page;

  set page(RxInt value) {
    _page = value;
  }

  void setSelectedAsTypeVal(int value) {
    selectedAsTypeVal.value = value;
  }

  void setSelectedRegionVal(int value) {
    selectedRegionVal.value = value;
  }

  TextEditingController get contentController => _contentController;

  set contentController(TextEditingController value) {
    _contentController = value;
  }

  set asksList(List<AskListChild> value) {
    _asksList = value;
  }

  List<AskListChild> get asksList => _asksList;

  TextEditingController get nameController => _nameController;

  set nameController(TextEditingController value) {
    _nameController = value;
  }

  AsksViewModel({required this.asksRepo}) {}

  RxBool get isAllPostPage => _isAllPostPage;

  set isAllPostPage(RxBool value) {
    _isAllPostPage = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  RxBool get isContactLoading => _isContactLoading;

  set isContactLoading(RxBool value) {
    _isContactLoading = value;
  }

  RxString get contactSearchQuery => _contactSearchQuery;

  set contactSearchQuery(RxString value) {
    _contactSearchQuery = value;
  }

  List<Contact> get contacts => _contacts;

  TextEditingController get contactController => _contactController;

  set contactController(TextEditingController value) {
    _contactController = value;
  }

  TextEditingController get commentsController => _commentsController;

  set commentsController(TextEditingController value) {
    _commentsController = value;
  }

  List<AnswerList> get answerList => _answerList;

  set answerList(List<AnswerList> value) {
    _answerList = value;
  }

  Future<void> initData() async {
    selectedAsTypeVal = 1.obs;
    selectedRegionVal = 1.obs;
    regionValue = "Chapter".toUpperCase().obs;
    askTypeValue = "Specific".toUpperCase().obs;
    _nameController = TextEditingController();
    _contactController = TextEditingController();
    _commentsController = TextEditingController();
    _contentController = TextEditingController();
    _asksList = [];
    _answerList = [];
    _page = 0.obs;
    _size = 10.obs;
    _totalPages = 0.obs;
    _isContactLoading.value = false;
    _contactSearchQuery.value = '';
    _contacts.clear();
    update();
  }

  Future<bool> loadContacts() async {
    _isContactLoading.value = true;
    update();
    try {
      final bool granted = await FlutterContacts.requestPermission(
        readonly: true,
      );
      if (!granted) {
        _contacts.clear();
        return false;
      }

      final List<Contact> phoneContacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      _contacts
        ..clear()
        ..addAll(
          phoneContacts.where(
            (contact) =>
                contact.displayName.trim().isNotEmpty &&
                contact.phones.isNotEmpty,
          ),
        );
      _contactSearchQuery.value = '';
      update();
      return true;
    } finally {
      _isContactLoading.value = false;
      update();
    }
  }

  void setContactSearchQuery(String value) {
    _contactSearchQuery.value = value;
    update();
  }

  List<Contact> get filteredContacts {
    final String query = _contactSearchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return _contacts;
    }

    return _contacts.where((contact) {
      final String name = contact.displayName.toLowerCase();
      final String number = contact.phones
          .map((phone) => phone.number.toLowerCase())
          .join(' ');
      return name.contains(query) || number.contains(query);
    }).toList();
  }

  void applyContact(Contact contact) {
    nameController.text = contact.displayName;
    contactController.text = _normalizePhoneNumber(
      contact.phones.first.number,
    );
    update();
  }

  String _normalizePhoneNumber(String value) {
    final String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length <= 10) {
      return digitsOnly;
    }
    return digitsOnly.substring(digitsOnly.length - 10);
  }

  Future<bool> loadMore() async {
    if (page.value < totalPages.value) {
      page.value += 1;
      await getAsksList(page.value, size.value, "", "", "");
      return true;
    } else {
      return false;
    }
  }

  Future<ResponseModel> addAsks(
      String askType, String region, String content) async {
    _isLoading = true;
    update();
    Response response = await asksRepo.addAsks(askType, region, content);
    _isLoading = false;
    ResponseModel responseModel;
    if (response.statusCode == 201) {
      responseModel = new ResponseModel(true, response.body['message']);
    } else {
      responseModel = new ResponseModel(false, errorMessage);
    }
    update();
    return responseModel;
  }

  Future<void> getAsksList(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    Response response =
        await asksRepo.getAsksList(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body['data']['data'].forEach((order) {
        AskListChild askListChild = AskListChild.fromJson(order);
        _asksList.add(askListChild);
      });
      totalPages.value = (response.body['data']['total'] / size).round();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getAsksAnswerList(String askUuid) async {
    _isLoading = true;
    update();
    Response response = await asksRepo.getAsksAnswerList(askUuid);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body['data']['answerList'].forEach((order) {
        AnswerList answerList = AnswerList.fromJson(order);
        _answerList.add(answerList);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<ResponseModel> addAsksReply(String askUuid, String comment) async {
    _isLoading = true;
    update();
    Response response = await asksRepo.addAsksReply(askUuid, comment);
    _isLoading = false;
    ResponseModel responseModel;
    if (response.statusCode == 201) {
      responseModel = new ResponseModel(true, response.body['message']);
    } else {
      responseModel = new ResponseModel(false, errorMessage);
    }
    update();
    return responseModel;
  }
}
