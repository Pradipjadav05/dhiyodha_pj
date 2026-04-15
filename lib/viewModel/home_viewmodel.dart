import 'package:carousel_slider/carousel_controller.dart';
import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/home_repo.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/model/response_model/dashboard_response_model.dart';
import 'package:dhiyodha/model/response_model/posts_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/response_model/referral_response_model.dart';
import '../view/widgets/common_snackbar.dart';

class HomeViewModel extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeViewModel({required this.homeRepo});

  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;
  RxBool _selectedData6month = true.obs,
      _selectedData12month = false.obs,
      _selectedDataLifeTime = false.obs;
  TextEditingController _commentController = TextEditingController();
  CurrentUserData _currentUserData = CurrentUserData();
  List<Stats> _statsList = [];
  List<Documents> _bannerList = [];
  NextMeeting? _nextMeeting;
  NextMeeting? _nextMeetingCountData;
  List<Documents> _guestBannerList = [];
  List<String> _reelList = [];
  RxBool _isAllPostPage = true.obs;
  RxBool _isAllPost = true.obs;
  bool _isLoading = false;
  bool _isCommentLoading = false;
  RxInt _selectedIndex = 0.obs;
  List<PostChildData> _postData = [];
  int _currentDotPosition = 0;
  int tyfcbCount = 0;
  int referralCount = 0;
  int visitorsCount = 0;
  int oneToOneCount = 0;
  int trainingCount = 0;
  int testimonialsCount = 0;

  int fcOneToOne = 0;
  int fcReferralGiven = 0;
  int fcReferralReceived = 0;
  int fcTyfcb = 0;
  int fcRevenue = 0;
  int fcVisitors = 0;
  int fcCeus = 0;
  RxBool showMeetingDetails = false.obs;

  CarouselSliderController _controller = CarouselSliderController();

  CarouselSliderController get controller => _controller;

  set controller(CarouselSliderController value) => _controller = value;

  int get currentDotPosition => _currentDotPosition;

  set currentDotPosition(int value) => _currentDotPosition = value;

  RxBool get isAllPost => _isAllPost;

  set isAllPost(RxBool value) => _isAllPost = value;

  RxInt get totalPages => _totalPages;

  set totalPages(RxInt value) => _totalPages = value;

  RxInt get page => _page;

  set page(RxInt value) => _page = value;

  RxInt get size => _size;

  set size(RxInt value) => _size = value;

  TextEditingController get commentController => _commentController;

  set commentController(TextEditingController value) =>
      _commentController = value;

  CurrentUserData get currentUserData => _currentUserData;

  set currentUserData(CurrentUserData value) => _currentUserData = value;

  List<Documents> get guestBannerList => _guestBannerList;

  set guestBannerList(List<Documents> value) => _guestBannerList = value;

  List<Documents> get bannerList => _bannerList;

  set bannerList(List<Documents> value) => _bannerList = value;

  List<Stats> get statsList => _statsList;

  List<ReferralChildData> referralGivenList = [];
  List<ReferralChildData> referralReceivedList = [];
  String selectedDuration = "SIX_MONTH";

  int _validPosition(int position, int total) {
    if (position >= total) return 0;
    if (position < 0) return total - 1;
    return position;
  }

  void updatePosition(int position) {
    currentDotPosition = _validPosition(position, bannerList.length);
    update();
  }

  Future<void> nextSlide(int position) async {
    currentDotPosition = _validPosition(position, bannerList.length);
    await controller.nextPage();
    update();
  }

  Future<void> prevSlide(int position) async {
    currentDotPosition = _validPosition(position, bannerList.length);
    await controller.previousPage();
    update();
  }

  Future<void> initData() async {
    _page = 0.obs;
    _size = 10.obs;
    _totalPages = 0.obs;
    _selectedData6month = true.obs;
    _selectedData12month = false.obs;
    _selectedDataLifeTime = false.obs;
    _commentController = TextEditingController();
    _currentUserData = CurrentUserData();
    _statsList = [];
    _bannerList = [];
    _guestBannerList = [];
    _reelList = [];
    _isAllPostPage = true.obs;
    _isLoading = false;
    _isCommentLoading = false;
    _selectedIndex = 0.obs;
    _postData = [];
    _currentDotPosition = 0;
    _controller = CarouselSliderController();
    await getMeetingsList();
  }

  RxInt get selectedIndex => _selectedIndex;

  set selectedIndex(RxInt value) => _selectedIndex = value;

  List<PostChildData> get postData => _postData;

  set postData(List<PostChildData> value) => _postData = value;

  RxBool get isAllPostPage => _isAllPostPage;

  set isAllPostPage(RxBool value) => _isAllPostPage = value;

  bool get isLoading => _isLoading;

  set isLoading(bool value) => _isLoading = value;

  get selectedDataLifeTime => _selectedDataLifeTime;

  set selectedDataLifeTime(value) => _selectedDataLifeTime = value;

  get selectedData12month => _selectedData12month;

  set selectedData12month(value) => _selectedData12month = value;

  RxBool get selectedData6month => _selectedData6month;

  set selectedData6month(RxBool value) => _selectedData6month = value;

  bool get isCommentLoading => _isCommentLoading;

  NextMeeting? get nextMeeting => _nextMeeting;

  NextMeeting? get nextMeetingCountData => _nextMeetingCountData;

  set nextMeeting(NextMeeting? value) => _nextMeeting = value;

  set nextMeetingCountData(NextMeeting? value) => _nextMeetingCountData = value;

  List<String> get reelList => _reelList;

  set reelList(List<String> value) => _reelList = value;

  Map<String, dynamic>? lastMonthlyData;

  List<Documents> meetingBannerList = [];
  List<Documents> businessPresentationBannerList = [];
  List<Documents> trainingBannerList = [];
  List<Documents> additionalBannerList = [];

  Future<bool> loadMore() async {
    if (page.value < totalPages.value) {
      page.value += 1;
      if (isAllPost.value == false) {
        await getMyPosts();
      } else {
        await getPosts(page.value, size.value, "", "", "");
      }
      return true;
    } else {
      return false;
    }
  }

  void _setLikeState(PostChildData postChildData) {
    postChildData.isPostLiked = postChildData.likes
            ?.any((l) => l.userId == globalCurrentUserData.uuid) ??
        false;
  }

  Future<void> getPosts(
      int page, int size, String? sort, String? orderBy, String? search) async {
    _isLoading = true;
    update();
    Response response =
        await homeRepo.getPosts(page, size, sort, orderBy, search);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body['data']['data'].forEach((order) {
        PostChildData postChildData = PostChildData.fromJson(order);
        _setLikeState(postChildData);
        _postData.add(postChildData);
      });
      totalPages.value = (response.body['data']['total'] / size).round();
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getMyPosts() async {
    _isLoading = true;
    update();
    Response response = await homeRepo.getMyPosts();
    _isLoading = false;
    if (response.statusCode == 200) {
      try {
        _postData = [];
        response.body['data'].forEach((order) {
          PostChildData postChildData = PostChildData.fromJson(order);
          _setLikeState(postChildData);
          _postData.add(postChildData);
        });
      } catch (e) {
        ApiChecker.checkApi(response);
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<Response> likeOnPost(PostChildData postChildData) async {
    final wasLiked = postChildData.isPostLiked;
    final prevCount = postChildData.likesCounter ?? 0;

    postChildData.isPostLiked = !wasLiked;
    postChildData.likesCounter = !wasLiked ? prevCount + 1 : prevCount - 1;
    update();

    Response response = await homeRepo.likeOnPost(postChildData.postUuid ?? "");

    if (response.statusCode != 201) {
      postChildData.isPostLiked = wasLiked;
      postChildData.likesCounter = prevCount;
      update();
    }
    return response;
  }

  Future<bool> commentOnPost(
      String postUuid, String parentCommentId, String comment) async {
    _isCommentLoading = true;
    update();

    Response response =
        await homeRepo.commentOnPost(postUuid, parentCommentId, comment);
    _isCommentLoading = false;

    if (response.statusCode == 201) {
      final post = _postData.firstWhereOrNull((p) => p.postUuid == postUuid);
      if (post != null) {
        post.comments ??= [];
        post.comments!.add(Comments(
          commentUuid: response.body['data']?['commentUuid'] ?? '',
          comment: comment,
          userId: globalCurrentUserData.uuid,
          createdAt: DateTime.now().toIso8601String(),
        ));
        post.commentsCounter = (post.commentsCounter ?? 0) + 1;
      }
      update();
      return true;
    }
    update();
    return false;
  }

  Future<void> getMeetingsList() async {
    _isLoading = true;
    update();

    Response response =
        await homeRepo.getMeetings(0, 1000, "updatedAt", "DESC");

    _isLoading = false;

    if (response.statusCode == 200) {
      meetingBannerList = [];
      businessPresentationBannerList = [];
      trainingBannerList = [];
      additionalBannerList = [];

      _bannerList = [];

      if (response.body['data'] != null &&
          response.body['data']['data'] != null &&
          response.body['data']['data'].isNotEmpty) {
        final meeting = response.body['data']['data'][0];

        nextMeeting = NextMeeting(
          uuid: meeting['uuid'],
          title: meeting['title'],
          day: meeting["day"],
          date: meeting["date"],
          startTime: formatTime(meeting['startTime']),
          endTime: formatTime(meeting['endTime']),
          visitors: meeting["totalVisitors"] ?? 0,
          tyfcb: 0,
          trainer: 0,
          speakers: 0,
          guest: 0,
          status: meeting['status'],
          locationName: meeting['locationName'],
          time: meeting['time'],
        );

        if (meeting['meetingBanner'] != null &&
            meeting['meetingBanner'].toString().isNotEmpty) {
          meetingBannerList.add(
            Documents(
              url: meeting['meetingBanner'],
              fileName: meeting['meetingtitle'],
              documentType: "jfif",
            ),
          );
        }

        if (meeting['businessPresentations'] != null) {
          for (var item in meeting['businessPresentations']) {
            if (item['businessPresentatioBanner'] != null &&
                item['businessPresentatioBanner'].toString().isNotEmpty) {
              businessPresentationBannerList.add(
                Documents(
                  url: item['businessPresentatioBanner'],
                  fileName: item['businessPresentationTitle'],
                  documentType: "jfif",
                ),
              );
            }
          }
        }

        if (meeting['trainings'] != null) {
          for (var item in meeting['trainings']) {
            if (item['trainingBanner'] != null &&
                item['trainingBanner'].toString().isNotEmpty) {
              trainingBannerList.add(
                Documents(
                  url: item['trainingBanner'],
                  fileName: item['trainingtitle'],
                  documentType: "jfif",
                ),
              );
            }
          }
        }

        if (meeting['additionalBanners'] != null) {
          for (var item in meeting['additionalBanners']) {
            if (item['bannerUrl'] != null &&
                item['bannerUrl'].toString().isNotEmpty) {
              additionalBannerList.add(
                Documents(
                  url: item['bannerUrl'],
                  fileName: item['bannerTitle'],
                  documentType: "jfif",
                ),
              );
            }
          }
        }

        _bannerList = [
          ...meetingBannerList,
          ...businessPresentationBannerList,
          ...trainingBannerList,
          ...additionalBannerList,
        ];
      }
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  String formatTime(String time) {
    final parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("hh:mm a").format(parsedTime);
  }

  Future<void> dashboardData(String duration) async {
    _isLoading = true;
    update();
    Response response = await homeRepo.dashboardData(duration);
    _isLoading = false;
    if (response.statusCode == 200) {
      if (response.body['data']['monthly'] != null) {
        final monthly = response.body['data']['monthly'];
        lastMonthlyData = monthly;

        tyfcbCount = monthly['tyfcbReceived']?['count'] ?? 0;
        referralCount = monthly['referralReceived']?['count'] ?? 0;
        visitorsCount = monthly['visitors']?['count'] ?? 0;
        oneToOneCount = monthly['oneToOne']?['count'] ?? 0;
        trainingCount = monthly['training']?['count'] ?? 0;
        testimonialsCount = monthly['testimonialReviewers']?['count'] ?? 0;

        referralGivenList = [];
        referralReceivedList = [];

        if (monthly['referralGiven'] != null) {
          for (var v in monthly['referralGiven']['list']) {
            referralGivenList.add(_mapReferral(v));
          }
        }
        if (monthly['referralReceived'] != null) {
          for (var v in monthly['referralReceived']['list']) {
            referralReceivedList.add(_mapReferral(v));
          }
        }
      }

      if (response.body['data']['stats'] != null) {
        _statsList = [];
        response.body['data']['stats'].forEach((order) {
          _statsList.add(Stats.fromJson(order));
        });
      }
/*      if (response.body['data']['documents'] != null) {
        _bannerList = [];
        response.body['data']['documents'].forEach((documents) {
          _bannerList.add(Documents.fromJson(documents));
        });
      }*/
      if (response.body['data']['nextMeeting'] != null) {
        _nextMeetingCountData =
            NextMeeting.fromJson(response.body['data']['nextMeeting']);
        globalNextMeeting =
            NextMeeting.fromJson(response.body['data']['nextMeeting']);
      }

      if (response.body['data']['filteredCounts'] != null) {
        final fc = response.body['data']['filteredCounts'];

        fcOneToOne = fc['oneToOne'] ?? 0;
        fcReferralGiven = fc['referralGiven'] ?? 0;
        fcReferralReceived = fc['referralReceived'] ?? 0;
        fcTyfcb = fc['tyfcb'] ?? 0;
        fcRevenue = fc['revenueReceived'] ?? 0;
        fcVisitors = fc['visitors'] ?? 0;
        fcCeus = fc['ceus'] ?? 0;
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> guestDashboardData() async {
    _isLoading = true;
    update();
    Response response = await homeRepo.guestDashboardData();
    _isLoading = false;
    if (response.statusCode == 200) {
      _guestBannerList = [];
      response.body['data'][0]['imageList'].forEach((documents) {
        _guestBannerList.add(Documents.fromJson(documents));
      });
      _reelList = [];
      response.body['data'][0]['reelList'].forEach((reels) {
        _reelList.add(reels);
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  ReferralChildData _mapReferral(Map<String, dynamic> json) {
    return ReferralChildData(
      uuid: json['userUuid'],
      referralTo: ReferralUser(
        uuid: json['userUuid'],
        firstName: json['fullName']?.split(" ").first,
        lastName: json['fullName']?.split(" ").length > 1
            ? json['fullName']?.split(" ").last
            : "",
        profileUrl: json['profileImage'],
      ),
      telephone: json['number'],
      companyName: json['companyName'] ?? "",
      type: json['designation'],
      referralType: json['referralType'],
      referralStatus: json['referralStatus'],
      comments: json['comments'],
    );
  }

  Future<CurrentUserData> getCurrentUser() async {
    _isLoading = true;
    update();
    Response response = await homeRepo.getCurrentUser();
    _isLoading = false;
    if (response.statusCode == 200) {
      _currentUserData = CurrentUserData.fromJson(response.body['data']);
      globalCurrentUserData = CurrentUserData.fromJson(response.body['data']);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _currentUserData;
  }

  Future<bool> deletePost(String postUuid) async {
    _isLoading = true;
    update();
    Response response = await homeRepo.deletePost(postUuid);
    _isLoading = false;
    if (response.statusCode == 204) {
      _postData.removeWhere((p) => p.postUuid == postUuid);
      update();
      return true;
    }
    ApiChecker.checkApi(response);
    // update();
    return false;
  }

  Future<bool> deleteCommentOnPost(String postUuid, String commentId) async {
    _isLoading = true;
    update();
    Response response = await homeRepo.deleteCommentOnPost(postUuid, commentId);
    _isLoading = false;
    if (response.statusCode == 204) {
      final post = _postData.firstWhereOrNull((p) => p.postUuid == postUuid);
      if (post != null) {
        post.comments?.removeWhere((c) => c.commentUuid == commentId);
        post.commentsCounter = (post.commentsCounter ?? 1) - 1;
      }
      update();
      return true;
    }
    ApiChecker.checkApi(response);
    update();
    return false;
  }

  Future<bool> clearSharedPreferenceAndLogout() async {
    return homeRepo.clearSharedPreferenceAndLogout();
  }

  void select6Month() {
    selectedDuration = "SIX_MONTH";
    update();
  }

  void select12Month() {
    selectedDuration = "ONE_YEAR";
    update();
  }

  void selectLifeTime() {
    selectedDuration = "ALL";
    update();
  }

  Future<bool> markAttendance() async {
    isLoading = true;
    update();

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        showSnackBar("Location permission denied", isError: true);
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
        const LocationSettings(accuracy: LocationAccuracy.high),
      );

      Response response = await homeRepo.markAttendance(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      isLoading = false;
      update();

      if (response.statusCode == 200 || response.statusCode == 201) {
        showMeetingDetails.value = false;
        showSnackBar(response.body['message'], isError: false);
        await getMeetingsList();
        return true;
      } else {
        showMeetingDetails.value = false;
        showSnackBar(response.body["errors"]?[0] ??  "attendance_error".tr, isError: true);
        return false;
      }
    } catch (e) {
      showMeetingDetails.value = false;
      isLoading = false;
      update();
      showSnackBar("attendance_error".tr, isError: true);
      return false;
    }
  }
}
