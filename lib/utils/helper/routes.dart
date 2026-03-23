import 'dart:convert';

import 'package:dhiyodha/model/response_model/ask_list_response_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/model/response_model/my_testimonial_response_model.dart';
import 'package:dhiyodha/model/response_model/visitor_response_model.dart';
import 'package:dhiyodha/view/pages/account_settings_page.dart';
import 'package:dhiyodha/view/pages/activity_feeds_page.dart';
import 'package:dhiyodha/view/pages/add_ask_page.dart';
import 'package:dhiyodha/view/pages/add_one_slip_page.dart';
import 'package:dhiyodha/view/pages/add_post_page.dart';
import 'package:dhiyodha/view/pages/add_referral_slip_page.dart';
import 'package:dhiyodha/view/pages/add_testimonial_page.dart';
import 'package:dhiyodha/view/pages/add_tyfcb_page.dart';
import 'package:dhiyodha/view/pages/visitor/visitor_module_page.dart';
import 'package:dhiyodha/view/pages/address_page.dart';
import 'package:dhiyodha/view/pages/asks_answer_list_page.dart';
import 'package:dhiyodha/view/pages/asks_list_page.dart';
import 'package:dhiyodha/view/pages/authentication_page.dart';
import 'package:dhiyodha/view/pages/ceu_slips_page.dart';
import 'package:dhiyodha/view/pages/connect_with_ask.dart';
import 'package:dhiyodha/view/pages/connections_request_actions_page.dart';
import 'package:dhiyodha/view/pages/contact_page.dart';
import 'package:dhiyodha/view/pages/guest_dashboard_page.dart';
import 'package:dhiyodha/view/pages/guest_login_page.dart';
import 'package:dhiyodha/view/pages/home_page.dart';
import 'package:dhiyodha/view/pages/language_page.dart';
import 'package:dhiyodha/view/pages/login_page.dart';
import 'package:dhiyodha/view/pages/member_profile_page.dart';
import 'package:dhiyodha/view/pages/members_page.dart';
import 'package:dhiyodha/view/pages/my_bio_page.dart';
import 'package:dhiyodha/view/pages/my_business_page.dart';
import 'package:dhiyodha/view/pages/my_connections_page.dart';
import 'package:dhiyodha/view/pages/my_network_page.dart';
import 'package:dhiyodha/view/pages/notification_page.dart';
import 'package:dhiyodha/view/pages/one_to_one_details_page.dart';
import 'package:dhiyodha/view/pages/one_to_one_page.dart';
import 'package:dhiyodha/view/pages/profile_page.dart';
import 'package:dhiyodha/view/pages/receive_request_page.dart';
import 'package:dhiyodha/view/pages/referral_details_page.dart';
import 'package:dhiyodha/view/pages/referrals_page.dart';
import 'package:dhiyodha/view/pages/request_testimonial_page.dart';
import 'package:dhiyodha/view/pages/sent_request_page.dart';
import 'package:dhiyodha/view/pages/splash_page.dart';
import 'package:dhiyodha/view/pages/testimonial_details_page.dart';
import 'package:dhiyodha/view/pages/testimonial_given_page.dart';
import 'package:dhiyodha/view/pages/testimonial_page.dart';
import 'package:dhiyodha/view/pages/testimonial_received_page.dart';
import 'package:dhiyodha/view/pages/testimonial_request_actions_page.dart';
import 'package:dhiyodha/view/pages/testimonial_requests_page.dart';
import 'package:dhiyodha/view/pages/training_page.dart';
import 'package:dhiyodha/view/pages/tyfcb_details_page.dart';
import 'package:dhiyodha/view/pages/tyfcb_page.dart';
import 'package:dhiyodha/view/pages/update_password_page.dart';
import 'package:dhiyodha/view/pages/update_username_page.dart';
import 'package:dhiyodha/view/pages/visiting_e_card_page.dart';
import 'package:dhiyodha/view/pages/visitor/visitor_page.dart';
import 'package:dhiyodha/view/pages/webview_page.dart';
import 'package:get/get.dart';

import '../../view/pages/forgot_password_page.dart';

class Routes {
  static const String initial = '/';
  static const String splash = '/splashPage';
  static const String language = '/language';
  static const String authentication = '/authentication';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String addTyfcb = '/addTyfcb';
  static const String home = '/home';
  static const String addSlip = '/addSlip';
  static const String profile = '/profile';
  static const String addOneToOne = '/addOneToOne';
  static const String ceuSlip = '/ceuSlip';
  static const String addPost = '/addPost';

  // static const String allPosts = '/allPosts';
  static const String webViewPage = '/webViewPage';
  static const String asksListPage = '/asksListPage';
  static const String addAskPage = '/addAskPage';
  static const String myNetwork = '/myNetwork';
  static const String myBusiness = '/myBusiness';
  static const String guestLogin = '/guestLogin';
  static const String guestDashboard = '/guestDashboard';
  static const String connectAsk = '/connectAsk';
  static const String notification = '/notification';
  static const String visitor = '/visitor';
  static const String training = '/training';
  static const String addVisitor = '/addVisitor';
  static const String tyfcbPage = '/tyfcbPage';
  static const String referralsPage = '/referralsPage';
  static const String oneToOnePage = '/oneToOnePage';
  static const String addressPage = '/addressPage';
  static const String contactPage = '/contactPage';
  static const String myBio = '/myBio';
  static const String updateUsername = '/updateUsername';
  static const String updatePassword = '/updatePassword';
  static const String testimonialPage = '/testimonialPage';
  static const String testimonialDetailsPage = '/testimonialDetailsPage';
  static const String accountSettingsPage = '/accountSettingsPage';
  static const String visitingCardPage = '/visitingCardPage';
  static const String membersPage = '/membersPage';
  static const String membersProfilePage = '/membersProfilePage';
  static const String addTestimonialPage = '/addTestimonialPage';
  static const String requestTestimonialPage = '/requestTestimonialPage';
  static const String myConnectionsPage = '/myConnectionsPage';
  static const String sentRequestPage = '/sentRequestPage';
  static const String receiveRequestPage = '/receiveRequestPage';
  static const String connectionsRequestActionsPage = '/requestActionsPage';
  static const String testimonialReceivedPage = '/testimonialReceivedPage';
  static const String testimonialGivenPage = '/testimonialGivenPage';
  static const String testimonialRequestPage = '/testimonialRequestPage';
  static const String testimonialRequestActionsPage =
      '/testimonialRequestActionsPage';
  static const String activityFeedsPage = '/activityFeedsPage';
  static const String tyfcbDetailsPage = '/tyfcbDetailsPage';
  static const String oneToOneDetailsPage = '/oneToOneDetailsPage';
  static const String referralDetailsPage = '/referralDetailsPage';
  static const String asksAnswerListPage = '/asksAnswerListPage';

  static String getInitialRoute() => initial;

  static String getSplashRoute() //NotificationBody? body
  {
    // String data = 'null';
    // if (body != null) {
    //   List<int> encoded = utf8.encode(jsonEncode(body.toJson()));
    //   data = base64Encode(encoded);
    // }
    // return '$splash?data=$data';
    return splash;
    // return login;
  }

  static String getLanguagePageRoute() => language;

  static String getAuthenticationPageRoute() => authentication;

  static String getLoginPageRoute() => login;

  static String getForgotPasswordPageRoute() => forgotPassword;

  static String getAddTyPageRoute() => addTyfcb;

  static String getHomePageRoute() => home;

  static String getAddSlipPageRoute() => addSlip;

  static String getProfilePageRoute(CurrentUserData? currentUserData) {
    List<int> encoded = utf8.encode(jsonEncode(currentUserData?.toJson()));
    String data = base64Encode(encoded);
    return '$profile?data=$data';
  }

  static String getAddOneToOnePageRoute() => addOneToOne;

  static String getCeuSlipPageRoute() => ceuSlip;

  static String getAddPostPageRoute(CurrentUserData? currentUserData) {
    List<int> encoded = utf8.encode(jsonEncode(currentUserData?.toJson()));
    String data = base64Encode(encoded);
    return '$addPost?data=$data';
  }

  // static String getAllPostsRoute() => allPosts;

  static String getWebViewPageRoute(String launchUrlData) {
    return '$webViewPage?data=$launchUrlData';
  }

  static String getAskListPageRoute() => asksListPage;

  static String getAddAskPageRoute() => addAskPage;

  static String getMyNetworkPageRoute() => myNetwork;

  static String getMyBusinessPageRoute(CurrentUserData? currentUserData) {
    List<int> encoded = utf8.encode(jsonEncode(currentUserData?.toJson()));
    String data = base64Encode(encoded);
    return '$myBusiness?data=$data';
  }

  static String getGuestLoginPageRoute() => guestLogin;

  static String getGuestDashboardPageRoute() => guestDashboard;

  static String getConnectAskPageRoute(AskListChild askListChild) {
    List<int> encoded = utf8.encode(jsonEncode(askListChild.toJson()));
    String data = base64Encode(encoded);
    return '$connectAsk?data=$data';
  }

  static String getNotificationPageRoute() => notification;

  static String getVisitorPageRoute() => visitor;

  static String getTrainingPageRoute() => training;

  static String getAddVisitorPageRoute() => addVisitor;

  static String getTYFCBsPageRoute() => tyfcbPage;

  static String getReferralsPageRoute() => referralsPage;

  static String getOneToOnePageRoute() => oneToOnePage;

  static String getAddressPageRoute(CurrentUserData? currentUserData) {
    List<int> encoded = utf8.encode(jsonEncode(currentUserData?.toJson()));
    String data = base64Encode(encoded);
    return '$addressPage?data=$data';
  }

  static String getContactPageRoute(CurrentUserData? currentUserData) {
    List<int> encoded = utf8.encode(jsonEncode(currentUserData?.toJson()));
    String data = base64Encode(encoded);
    return '$contactPage?data=$data';
  }

  static String getMyBioPageRoute(CurrentUserData? currentUserData) {
    List<int> encoded = utf8.encode(jsonEncode(currentUserData?.toJson()));
    String data = base64Encode(encoded);
    return '$myBio?data=$data';
  }

  static String getUpdateUsernameRoute() => updateUsername;

  static String getUpdatePasswordPageRoute() => updatePassword;

  static String getTestimonialPageRoute() => testimonialPage;

  static String getTestimonialDetailsPageRoute(
      MyTestimonialChildData myTestimonialChildData) {
    List<int> encoded =
        utf8.encode(jsonEncode(myTestimonialChildData.toJson()));
    String data = base64Encode(encoded);
    return '$testimonialDetailsPage?data=$data';
  }

  static String getAccountSettingsPageRoute() => accountSettingsPage;

  static String getVisitingCardPageRoute(
      {CurrentUserData? currentUserData, VisitorChildData? visitorData}) {
    if (currentUserData != null) {
      List<int> encoded = utf8.encode(jsonEncode(currentUserData.toJson()));
      String data = base64Encode(encoded);
      return '$visitingCardPage?currentUserData=$data';
    } else {
      List<int> encoded = utf8.encode(jsonEncode(visitorData?.toJson()));
      String data = base64Encode(encoded);
      return '$visitingCardPage?visitorData=$data';
    }
  }

  static String getMembersPageRoute(String isReturnResult) {
    return '$membersPage?isReturnResult=$isReturnResult';
  }

  static String getMembersProfilePageRoute(MembersChildData childData) {
    List<int> encoded = utf8.encode(jsonEncode(childData.toJson()));
    String data = base64Encode(encoded);
    return '$membersProfilePage?data=$data';
  }

  static String getAddTestimonialPageRoute(MembersChildData membersChildData) {
    List<int> encoded = utf8.encode(jsonEncode(membersChildData.toJson()));
    String data = base64Encode(encoded);
    return '$addTestimonialPage?data=$data';
  }

  static String getRequestTestimonialPageRoute() => requestTestimonialPage;

  static String getMyConnectionsPageRoute() => myConnectionsPage;

  static String getSentRequestPageRoute() => sentRequestPage;

  static String getReceiveRequestPageRoute() => receiveRequestPage;

  static String getRequestActionsPageRoute() => connectionsRequestActionsPage;

  static String getTestimonialGivenPageRoute() => testimonialGivenPage;

  static String getTestimonialReceivedPageRoute() => testimonialReceivedPage;

  static String getTestimonialRequestPageRoute() => testimonialRequestPage;

  static String getTestimonialRequestActionPageRoute() =>
      testimonialRequestActionsPage;

  static String getActivityFeedsPage() => activityFeedsPage;

  static String getTyfcbDetailsPage() => tyfcbDetailsPage;

  static String getOneToOneDetailsPage() => oneToOneDetailsPage;

  static String getReferralDetailsPage() => referralDetailsPage;

  static String getAsksAnswerListPageRoute(AskListChild askListChild) {
    List<int> encoded = utf8.encode(jsonEncode(askListChild.toJson()));
    String data = base64Encode(encoded);
    return '$asksAnswerListPage?data=$data';
  }

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => SplashPage()),
    GetPage(
        name: splash,
        page: () {
          // NotificationBody? data;
          // if (Get.parameters['data'] != 'null') {
          //   List<int> decode =
          //       base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
          //   data = NotificationBody.fromJson(jsonDecode(utf8.decode(decode)));
          // }
          return SplashPage();
        }),
    GetPage(name: language, page: () => LanguagePage()),
    GetPage(name: authentication, page: () => AuthenticationPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordPage()),
    GetPage(name: addTyfcb, page: () => AddTyPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: addSlip, page: () => AddReferralSlipPage()),
    GetPage(
        name: profile,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          CurrentUserData data =
              CurrentUserData.fromJson(jsonDecode(utf8.decode(decode)));
          return ProfilePage(currentUserData: data);
        }),
    GetPage(name: addOneToOne, page: () => AddOneToOneSlipPage()),
    GetPage(name: ceuSlip, page: () => CEUSlipPage()),
    GetPage(
        name: addPost,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          CurrentUserData data =
              CurrentUserData.fromJson(jsonDecode(utf8.decode(decode)));
          return AddPostPage(currentUserData: data);
        }),
    // GetPage(name: allPosts, page: () => AllPostsPage()),
    GetPage(
        name: webViewPage,
        page: () {
          String urlData = Get.parameters['data']!;
          return WebViewPage(launchUrl: urlData);
        }),
    GetPage(name: asksListPage, page: () => AsksListPage()),
    GetPage(name: addAskPage, page: () => AddAskPage()),
    GetPage(name: myNetwork, page: () => MyNetworkPage()),
    GetPage(
        name: myBusiness,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          CurrentUserData data =
              CurrentUserData.fromJson(jsonDecode(utf8.decode(decode)));
          return MyBusinessPage(currentUserData: data);
        }),
    GetPage(name: guestLogin, page: () => GuestLoginPage()),
    GetPage(name: guestDashboard, page: () => GuestDashboardPage()),
    GetPage(
        name: connectAsk,
        page: () {
          List<int> decode =
              base64Decode(Get.parameters['data']!.replaceAll(" ", "+"));
          AskListChild askChild =
              AskListChild.fromJson(jsonDecode(utf8.decode(decode)));
          return ConnectWithAskPage(askChild: askChild);
        }),
    GetPage(name: notification, page: () => NotificationPage()),
    GetPage(name: visitor, page: () => VisitorPage(isAppBarRequired: true,
      onStateChanged: () {
      },)),
    GetPage(name: training, page: () => TrainingPage()),
    GetPage(name: addVisitor, page: () => AddVisitorsPage()),
    GetPage(name: tyfcbPage, page: () => TyfcbPage()),
    GetPage(name: referralsPage, page: () => ReferralsPage()),
    GetPage(name: oneToOnePage, page: () => OneToOnePage()),
    GetPage(
        name: addressPage,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          CurrentUserData data =
              CurrentUserData.fromJson(jsonDecode(utf8.decode(decode)));
          return AddressPage(currentUserData: data);
        }),
    GetPage(
        name: contactPage,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          CurrentUserData data =
              CurrentUserData.fromJson(jsonDecode(utf8.decode(decode)));
          return ContactPage(currentUserData: data);
        }),
    GetPage(
        name: myBio,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          CurrentUserData data =
              CurrentUserData.fromJson(jsonDecode(utf8.decode(decode)));
          return MyBioPage(currentUserData: data);
        }),
    GetPage(name: updateUsername, page: () => UpdateUserNamePage()),
    GetPage(name: updatePassword, page: () => UpdatePasswordPage()),
    GetPage(name: testimonialPage, page: () => TestimonialPage()),
    GetPage(
        name: testimonialDetailsPage,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          MyTestimonialChildData data =
              MyTestimonialChildData.fromJson(jsonDecode(utf8.decode(decode)));
          return TestimonialDetailsPage(myTestimonialChildData: data);
        }),
    GetPage(name: accountSettingsPage, page: () => AccountSettingsPage()),
    GetPage(
        name: visitingCardPage,
        page: () {
          if (Get.parameters['currentUserData'] != null) {
            List<int> currentUserDecode =
                base64Decode(Get.parameters['currentUserData']!);
            CurrentUserData data = CurrentUserData.fromJson(
                jsonDecode(utf8.decode(currentUserDecode)));
            return VisitingECardPage(
              currentUserData: data,
            );
          } else {
            List<int> visitorDataDecode =
                base64Decode(Get.parameters['visitorData']!);
            VisitorChildData visitorData = VisitorChildData.fromJson(
                jsonDecode(utf8.decode(visitorDataDecode)));
            return VisitingECardPage(
              visitorChildData: visitorData,
            );
          }
        }),
    GetPage(
        name: membersPage,
        page: () {
          String isReturnResult = Get.parameters['isReturnResult']!;
          return MembersPage(isReturnResult: isReturnResult);
        }),
    GetPage(
        name: membersProfilePage,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          MembersChildData data =
              MembersChildData.fromJson(jsonDecode(utf8.decode(decode)));
          return MemberProfilePage(membersChildData: data);
        }),
    GetPage(
        name: addTestimonialPage,
        page: () {
          List<int> decode = base64Decode(Get.parameters['data']!);
          MembersChildData data =
              MembersChildData.fromJson(jsonDecode(utf8.decode(decode)));
          return AddTestimonialPage(membersChildData: data);
        }),
    GetPage(name: requestTestimonialPage, page: () => RequestTestimonialPage()),
    GetPage(name: myConnectionsPage, page: () => MyConnectionsPage()),
    GetPage(name: sentRequestPage, page: () => SentRequestPage()),
    GetPage(name: receiveRequestPage, page: () => ReceiveRequestPage()),
    GetPage(
        name: connectionsRequestActionsPage,
        page: () => ConnectionRequestActionsPage()),
    GetPage(name: testimonialGivenPage, page: () => TestimonialGivenPage()),
    GetPage(
        name: testimonialReceivedPage, page: () => TestimonialReceivedPage()),
    GetPage(
        name: testimonialRequestPage, page: () => TestimonialRequestsPage()),
    GetPage(
        name: testimonialRequestActionsPage,
        page: () => TestimonialRequestActionsPage()),
    GetPage(name: activityFeedsPage, page: () => ActivityFeedsPage()),
    GetPage(name: tyfcbDetailsPage, page: () => TyfcbDetailsPage()),
    GetPage(name: oneToOneDetailsPage, page: () => OneToOneDetailsPage()),
    GetPage(name: referralDetailsPage, page: () => ReferralDetailsPage()),
    GetPage(
        name: asksAnswerListPage,
        page: () {
          List<int> decode =
              base64Decode(Get.parameters['data']!.replaceAll(" ", "+"));
          AskListChild askChild =
              AskListChild.fromJson(jsonDecode(utf8.decode(decode)));
          return AsksAnswerListPage(askChild: askChild);
        }),
  ];
}
