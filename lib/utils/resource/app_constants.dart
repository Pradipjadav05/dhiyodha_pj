import 'package:dhiyodha/model/language_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/model/response_model/dashboard_response_model.dart';

const String appName = 'Dhiyodha';
const String countryCode = 'dhiyodha_country_code';
const String languageCode = 'dhiyodha_language_code';
const String theme = 'dhiyodha_theme';
const String intro = 'dhiyodha_intro';
const String isLogin = 'dhiyodha_login';
const String accessToken = 'dhiyodha_access_token';
const String refreshToken = 'dhiyodha_refresh_token';
const String type = 'dhiyodha_type';
const String cartList = 'dhiyodha_cart_list';
const String userPassword = 'dhiyodha_user_password';
const String userAddress = 'dhiyodha_user_address';
const String userNumber = 'dhiyodha_user_number';
const String userType = 'dhiyodha_user_type';
const String notification = 'dhiyodha_notification';
const String notificationCount = 'dhiyodha_notification_count';
const String searchHistory = 'dhiyodha_search_history';
const String topic = 'all_zone_store';
const String zoneTopic = 'zone_topic';
const String moduleId = 'moduleId';
const String localizationKey = 'X-localization';
const String errorMessage = 'Oops! something went wrong, try again later';
const String queryWebUrl = 'https://dhiyodha.com/';
const String storedEmail = 'username';
const String storedPassword = 'password';
// const String baseUrl = 'http://13.234.19.67:8097/'; LocalHost URL
const String baseUrl = 'https://api.socialclub.dhiyodha.com:8097/';
const String playStoreUrl =
    'https://play.google.com/store/apps/details?id=app.alphaabit.dhiyodha.dhiyodha';

const String countryListUrl = baseUrl + 'api/fetch/new/countries';
const String stateListUrl = baseUrl + 'api/fetch/new/states/';
const String cityListUrl = baseUrl + 'api/fetch/new/cities/';

// const String groupsUrl = baseUrl + 'api/groups/';
const String groupsUrl = baseUrl + 'api/teams/';

/** AUTHENTICATION APIS*/
const String loginUrl = baseUrl + 'api/socialAuth/authenticate';
const String sendOtpUrl = baseUrl + 'api/socialAuth/sendOtp';
const String verifyOtpUrl = baseUrl + 'api/socialAuth/verifyOtp';
const String refreshTokenUrl = baseUrl + 'api/socialAuth/refreshToken';
const String guestSignupUrl = baseUrl + 'api/socialAuth/guestSignup';

/** POST APIS*/
const String postsUrl = baseUrl + 'api/posts/';
const String postLikeUrl = baseUrl + 'api/posts';
const String postCommentUrl = baseUrl + 'api/posts/comment';
const String addPostUrl = baseUrl + 'api/posts/';
const String deletePostUrl = baseUrl + 'api/posts/';
const String deletePostCommentUrl = baseUrl + 'api/posts/';
const String postDetailsByIdUrl = baseUrl + 'api/posts/';
const String getMyPostsUrl = baseUrl + 'api/posts/mine';

/** ASK APIs*/
const String askListUrl = baseUrl + 'api/ask/';
const String addAskUrl = baseUrl + 'api/ask/';
const String deleteAskUrl = baseUrl + 'api/ask/';
const String getAskDetailsUrl = baseUrl + 'api/ask/';
const String getAskAnswersUrl = baseUrl + 'api/ask/';
const String editAskUrl = baseUrl + 'api/ask/';
const String editAskAnswerUrl = baseUrl + 'api/ask/';

/** TYFCB APIs*/
const String tyfcbListUrl = baseUrl + 'api/appreciate-note/';
const String addTyfcbUrl = baseUrl + 'api/appreciate-note/';
const String tyfcbDetailsUrl = baseUrl + 'api/appreciate-note/';
const String myTyfcbUrl = baseUrl + 'api/my-appreciation/';

/** REFERRALS APIs*/
const String referralUrl = baseUrl + 'api/referrals/';
const String addReferralsUrl = baseUrl + 'api/referrals/';
const String getReferralsByIdUrl = baseUrl + 'api/referrals/';
const String getMyReferralsUrl = baseUrl + 'api/my-referrals/';

/** MEETINGS APIs - TODO: Replace with actual endpoints when backend is ready*/
const String getMeetingsListUrl = baseUrl + 'api/meetings/';
const String getMeetingAttendeesUrl = baseUrl + 'api/meetings/attendees/';

/** ONE TO ONE APIs*/
const String addOneToOneUrl = baseUrl + 'api/one-to-one/';
const String oneToOneDetailsUrl = baseUrl + 'api/one-to-one/';
const String oneToOneListUrl = baseUrl + 'api/one-to-one/';

/** USERS APIs*/
const String dashboardUrl = baseUrl + 'api/users/dashboard';
const String currentUserUrl = baseUrl + 'api/users/current';
const String editProfileUrl = baseUrl + 'api/users/user-profile';
const String searchTypeUrl = baseUrl + 'api/users/searchType';
const String guestDashboardUrl = baseUrl + 'api/users/guest-dashboard';
const String updatePasswordUrl = baseUrl + 'api/users/update-password';
const String getMembersUrl = baseUrl + 'api/users/';
const String filtersUrl = baseUrl + 'api/users/filter';

/** DOCUMENT APIs*/
const String uploadDocumentUrl = baseUrl + 'api/document/upload';
const String deleteDocumentUrl = baseUrl + 'api/document/';
const String getDocumentUrlById = baseUrl + 'api/document/uuid/';
const String downloadDocumentUrlById = baseUrl + 'api/document/download/';

/** VISITORS APIs*/
const String visitorsUrl = baseUrl + 'api/visitors/';
const String deleteVisitorsUrl = baseUrl + 'api/visitors/';
const String addVisitorsUrl = baseUrl + 'api/visitors/create';
const String editVisitorUrl = baseUrl + 'api/visitors/';
const String getVisitorByIdUrl = baseUrl + 'api/visitors/';

/** TESTIMONIAL APIs*/
const String testimonialListUrl = baseUrl + 'api/testimonials';
const String testimonialByIdUrl = baseUrl + 'api/testimonials/';
const String myTestimonialsUrl = baseUrl + 'api/testimonials/my-testimonial';
const String addTestimonialUrl = baseUrl + 'api/testimonials';
const String editTestimonialUrl = baseUrl + 'api/testimonials/';
const String deleteTestimonialUrl = baseUrl + 'api/testimonials/';
const String userTestimonialUrl = baseUrl + 'api/testimonials/user/';

List<LanguageModel> languagesList = [
  LanguageModel(
      imageUrl: "",
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en'),
  LanguageModel(
      imageUrl: "",
      languageName: 'Hindi',
      countryCode: 'IN',
      languageCode: 'hi'),
];

List<String> globalBusinessCategoryList = [
  "Select Business Category",
  "Agriculture, Forestry, Fishing and Hunting",
  "Mining",
  "Utilities",
  "Construction",
  "Manufacturing",
  "Wholesale Trade",
  "Retail Trade",
  "Transportation and Warehousing",
  "Information",
  "Finance and Insurance",
  "Real Estate Rental and Leasing",
  "Professional, Scientific, and Technical Services",
  "Management of Companies and Enterprises",
  "Administrative and Support and Waste… Services",
  "Educational Services",
  "Health Care and Social Assistance",
  "Arts, Entertainment, and Recreation",
  "Accommodation and Food Services",
  "Other Services (except Public Administration)",
  "Public Administration"
];

List<String> globalBusinessCategoryForMemberList = [
  "Select Business Category",
  "Agriculture",
  "Education",
  "Entertainment",
  "Finance",
  "HealthCare",
  "Retail",
  "Technology"
];

NextMeeting globalNextMeeting = NextMeeting();
CurrentUserData globalCurrentUserData = CurrentUserData();
String globalSelectedLanguage = "";
