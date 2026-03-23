import 'dart:convert';

import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/data/repository/account_settings_repo.dart';
import 'package:dhiyodha/data/repository/activity_feeds_repo.dart';
import 'package:dhiyodha/data/repository/address_repo.dart';
import 'package:dhiyodha/data/repository/asks_repo.dart';
import 'package:dhiyodha/data/repository/contact_repo.dart';
import 'package:dhiyodha/data/repository/home_repo.dart';
import 'package:dhiyodha/data/repository/login_repo.dart';
import 'package:dhiyodha/data/repository/members_repo.dart';
import 'package:dhiyodha/data/repository/my_business_repo.dart';
import 'package:dhiyodha/data/repository/my_network_repo.dart';
import 'package:dhiyodha/data/repository/one_to_one_repo.dart';
import 'package:dhiyodha/data/repository/posts_repo.dart';
import 'package:dhiyodha/data/repository/profile_repo.dart';
import 'package:dhiyodha/data/repository/referral_repo.dart';
import 'package:dhiyodha/data/repository/splash_repo.dart';
import 'package:dhiyodha/data/repository/testimonial_repo.dart';
import 'package:dhiyodha/data/repository/tyfcb_repo.dart';
import 'package:dhiyodha/data/repository/visiting_card_repo.dart';
import 'package:dhiyodha/data/repository/visitors_repo.dart';
import 'package:dhiyodha/model/language_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/viewModel/account_settings_viewmodel.dart';
import 'package:dhiyodha/viewModel/activity_feeds_viewmodel.dart';
import 'package:dhiyodha/viewModel/address_viewmodel.dart';
import 'package:dhiyodha/viewModel/asks_viewmodel.dart';
import 'package:dhiyodha/viewModel/authentication_viewmodel.dart';
import 'package:dhiyodha/viewModel/ceu_slip_viewmodel.dart';
import 'package:dhiyodha/viewModel/contact_viewmodel.dart';
import 'package:dhiyodha/viewModel/home_viewmodel.dart';
import 'package:dhiyodha/viewModel/localization_viewmodel.dart';
import 'package:dhiyodha/viewModel/login_viewmodel.dart';
import 'package:dhiyodha/viewModel/members_viewmodel.dart';
import 'package:dhiyodha/viewModel/my_business_viewmodel.dart';
import 'package:dhiyodha/viewModel/my_network_viewmodel.dart';
import 'package:dhiyodha/viewModel/one_to_one_slip_viewmodel.dart';
import 'package:dhiyodha/viewModel/posts_viewmodel.dart';
import 'package:dhiyodha/viewModel/profile_viewmodel.dart';
import 'package:dhiyodha/viewModel/referral_slip_viewmodel.dart';
import 'package:dhiyodha/viewModel/splash_viewmodel.dart';
import 'package:dhiyodha/viewModel/testimonial_viewmodel.dart';
import 'package:dhiyodha/viewModel/tyfcb_viewmodel.dart';
import 'package:dhiyodha/viewModel/visiting_card_viewmodel.dart';
import 'package:dhiyodha/viewModel/visitors_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences);
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()));

  //appBaseUrl: baseUrl,

  /** Repositories **/
  Get.lazyPut(
      () => LoginRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => TyfcbRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => HomeRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AsksRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      MyNetworkRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      MyBusinessRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => VisitorsRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AddressRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => ContactRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      TestimonialRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AccountSettingsRepo(
      apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => MembersRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      ActivityFeedsRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => ReferralRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(
      () => OneToOneRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => PostsRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      VisitingCardRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => ProfileRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  /** ViewModels **/
  Get.lazyPut(() => SplashViewModel(splashRepo: Get.find()));
  Get.lazyPut(
      () => LocalizationViewModel(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => AuthenticationViewModel());
  Get.lazyPut(() => LoginViewModel(loginRepo: Get.find()));
  Get.lazyPut(() => TyfcbViewModel(tyfcbRepo: Get.find()));
  Get.lazyPut(() => HomeViewModel(homeRepo: Get.find()));
  Get.lazyPut(() => ProfileViewModel(profileRepo: Get.find()));
  Get.lazyPut(() => OneToOneSlipViewModel(oneToOneRepo: Get.find()));
  Get.lazyPut(() => CEUSlipViewModel());
  Get.lazyPut(() => PostsViewModel(postsRepo: Get.find()));
  Get.lazyPut(() => AsksViewModel(asksRepo: Get.find()));
  Get.lazyPut(() => MyNetworkViewModel(myNetworkRepo: Get.find()));
  Get.lazyPut(() => MyBusinessViewModel(myBusinessRepo: Get.find()));
  Get.lazyPut(() => VisitorsViewModel(visitorsRepo: Get.find(), referralRepo: Get.find()));
  Get.lazyPut(() => AddressViewmodel(addressRepo: Get.find()));
  Get.lazyPut(() => ContactViewmodel(contactRepo: Get.find()));
  Get.lazyPut(() => TestimonialViewModel(testimonialRepo: Get.find()));
  Get.lazyPut(() => AccountSettingsViewmodel(accountSettingsRepo: Get.find()));
  Get.lazyPut(() => MembersViewmodel(membersRepo: Get.find()));
  Get.lazyPut(() => ActivityFeedsViewmodel(activityFeedsRepo: Get.find()));
  Get.lazyPut(() => ReferralSlipViewModel(referralRepo: Get.find()));
  Get.lazyPut(() => VisitingCardViewModel(visitingCardRepo: Get.find()));
  Get.lazyPut(() => ReferralRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));

  /** Retrieving localized data **/
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in languagesList) {
    String jsonStringValues = await rootBundle
        .loadString('assets/languages/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
