import 'package:dhiyodha/data/repository/activity_feeds_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ActivityFeedsViewmodel extends GetxController implements GetxService {
  final ActivityFeedsRepo activityFeedsRepo;

  ActivityFeedsViewmodel({required this.activityFeedsRepo}) {}

  RxBool _isGivenFeed = true.obs;
  RxBool _isReceivedFeed = false.obs;

  TextEditingController _tyfcbToController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();

  TextEditingController get tyfcbToController => _tyfcbToController;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  TextEditingController get amountController => _amountController;

  TextEditingController get commentsController => _commentsController;

  bool _isLoading = false;

  RxBool get isGivenFeed => _isGivenFeed;

  set isGivenFeed(RxBool value) {
    _isGivenFeed = value;
  }

  RxBool get isReceivedFeed => _isReceivedFeed;

  set isReceivedFeed(RxBool value) {
    _isReceivedFeed = value;
  }
}
