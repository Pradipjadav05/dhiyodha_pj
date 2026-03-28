import 'package:carousel_slider/carousel_controller.dart';
import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/home_repo.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/model/response_model/dashboard_response_model.dart';
import 'package:dhiyodha/model/response_model/posts_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeViewModel({required this.homeRepo}) {
    // _notification = loginRepo.isNotificationActive();
  }

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
  CarouselSliderController _controller = CarouselSliderController();

  CarouselSliderController get controller => _controller;

  set controller(CarouselSliderController value) {
    _controller = value;
  }

  int get currentDotPosition => _currentDotPosition;

  set currentDotPosition(int value) {
    _currentDotPosition = value;
  }

  RxBool get isAllPost => _isAllPost;

  set isAllPost(RxBool value) {
    _isAllPost = value;
  }

  RxInt get totalPages => _totalPages;

  set totalPages(RxInt value) {
    _totalPages = value;
  }

  RxInt get page => _page;

  set page(RxInt value) {
    _page = value;
  }

  RxInt get size => _size;

  set size(RxInt value) {
    _size = value;
  }

  TextEditingController get commentController => _commentController;

  set commentController(TextEditingController value) {
    _commentController = value;
  }

  CurrentUserData get currentUserData => _currentUserData;

  set currentUserData(CurrentUserData value) {
    _currentUserData = value;
  }

  List<Documents> get guestBannerList => _guestBannerList;

  set guestBannerList(List<Documents> value) {
    _guestBannerList = value;
  }

  List<Documents> get bannerList => _bannerList;

  set bannerList(List<Documents> value) {
    _bannerList = value;
  }

  List<Stats> get statsList => _statsList;

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
  }

  RxInt get selectedIndex => _selectedIndex;

  set selectedIndex(RxInt value) {
    _selectedIndex = value;
  }

  List<PostChildData> get postData => _postData;

  set postData(List<PostChildData> value) {
    _postData = value;
  }

  RxBool get isAllPostPage => _isAllPostPage;

  set isAllPostPage(RxBool value) {
    _isAllPostPage = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  get selectedDataLifeTime => _selectedDataLifeTime;

  set selectedDataLifeTime(value) {
    _selectedDataLifeTime = value;
  }

  get selectedData12month => _selectedData12month;

  set selectedData12month(value) {
    _selectedData12month = value;
  }

  RxBool get selectedData6month => _selectedData6month;

  set selectedData6month(RxBool value) {
    _selectedData6month = value;
  }

  bool get isCommentLoading => _isCommentLoading;

  NextMeeting? get nextMeeting => _nextMeeting;

  set nextMeeting(NextMeeting? value) {
    _nextMeeting = value;
  }

  List<String> get reelList => _reelList;

  set reelList(List<String> value) {
    _reelList = value;
  }

  Future<bool> loadMore() async {
    if (page.value < totalPages.value) {
      page.value += 1;
      if(isAllPost.value == false) {
        await getMyPosts();
      } else {
        await getPosts(page.value, size.value, "", "", "");
      }
      return true;
    } else {
      return false;
    }
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
          _postData.add(postChildData);
        });
        //totalPages.value = (response.body['data']['total'] / size).round();
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
    postChildData.isLikeLoading = true;
    update();
    bool isSuccess = false;
    Response response = await homeRepo.likeOnPost(postChildData.postUuid ?? "");
    postChildData.isLikeLoading = false;
    if (response.statusCode == 201) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    update();
    return response;
  }

  Future<bool> commentOnPost(
      String postUuid, String parentCommentId, String comment) async {
    _isCommentLoading = true;
    update();
    bool isSuccess = false;
    Response response =
        await homeRepo.commentOnPost(postUuid, parentCommentId, comment);
    _isCommentLoading = false;
    if (response.statusCode == 201) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    update();
    return isSuccess;
  }

  Future<void> dashboardData(String duration) async {
    _isLoading = true;
    update();
    Response response = await homeRepo.dashboardData(duration);
    _isLoading = false;
    if (response.statusCode == 200) {
      // Weekly counts mapping
      if (response.body['data']['weekly'] != null) {
        final weekly = response.body['data']['weekly'];

        tyfcbCount = weekly['tyfcb']?['count'] ?? 0;
        referralCount = weekly['referralGiven']?['count'] ?? 0;
        visitorsCount = weekly['visitors']?['count'] ?? 0;
        oneToOneCount = weekly['oneToOne']?['count'] ?? 0;
        trainingCount = weekly['training']?['count'] ?? 0;
        testimonialsCount = weekly['testimonials']?['count'] ?? 0;
      }

      if (response.body['data']['stats'] != null) {
        _statsList = [];
        response.body['data']['stats'].forEach((order) {
          Stats stats = Stats.fromJson(order);
          _statsList.add(stats);
        });
      }
      if (response.body['data']['documents'] != null) {
        _bannerList = [];
        response.body['data']['documents'].forEach((documents) {
          Documents document = Documents.fromJson(documents);
          _bannerList.add(document);
        });
      }
      if (response.body['data']['nextMeeting'] != null) {
        _nextMeeting =
            NextMeeting.fromJson(response.body['data']['nextMeeting']);
        globalNextMeeting =
            NextMeeting.fromJson(response.body['data']['nextMeeting']);
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
        Documents document = Documents.fromJson(documents);
        _guestBannerList.add(document);
      });
      _reelList = [];
      //_reelList.add("https://youtu.be/WcMc8FKdtwQ?si=_U1JMh6ugLXXM7M9");
      response.body['data'][0]['reelList'].forEach((reels) {
        _reelList.add(reels);
      });
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  Future<CurrentUserData> getCurrentUser() async {
    _isLoading = true;
    update();
    Response response = await homeRepo.getCurrentUser();
    _isLoading = false;
    if (response.statusCode == 200) {
      _currentUserData = CurrentUserData();
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
    bool isSuccess = false;
    update();
    Response response = await homeRepo.deletePost(postUuid);
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

  Future<bool> deleteCommentOnPost(String postUuid, String commentId) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await homeRepo.deleteCommentOnPost(postUuid, commentId);
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

  Future<bool> clearSharedPreferenceAndLogout() async {
    return homeRepo.clearSharedPreferenceAndLogout();
  }
}
