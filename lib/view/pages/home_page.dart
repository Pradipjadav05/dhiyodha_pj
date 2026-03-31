import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dhiyodha/model/response_model/dashboard_response_model.dart';
import 'package:dhiyodha/model/response_model/posts_model.dart';
import 'package:dhiyodha/utils/helper/date_converter.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/pages/authentication_page.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loadmore/loadmore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    callInitAPIs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeViewModel>(builder: (homeVM) {
        return Obx(
          () => Scaffold(
            backgroundColor: ghostWhite,
            appBar: homeVM.isAllPostPage.value
                ? AppBar(
                    title: Image.asset(
                      appLogoLong,
                      width: 100.0,
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.getMembersPageRoute("false"));
                        },
                        child: Image.asset(
                          search,
                          height: iconSize20,
                          width: iconSize20,
                        ),
                      ),
                      SizedBox(width: paddingSize20),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.getNotificationPageRoute());
                        },
                        child: Image.asset(
                          notificationIcon,
                          height: iconSize20,
                          width: iconSize20,
                        ),
                      ),
                      SizedBox(width: paddingSize20),
                      InkWell(
                        onTap: () async {
                          await showFilterDialog(homeVM);
                        },
                        child: Image.asset(
                          color: black,
                          filter,
                          height: iconSize20,
                          width: iconSize20,
                        ),
                      ),
                      SizedBox(width: paddingSize20),
                    ],
                  )
                : AppBar(
                    title: Image.asset(
                      appLogoLong,
                      width: 120.0,
                    ),
                  ),
            drawer: Drawer(
              elevation: 4.0,
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      InkWell(
                        onTap: () async {
                          Get.back();
                          await Get.toNamed(Routes.getProfilePageRoute(
                              homeVM.currentUserData));
                          await getCurrentUser(homeVM);
                          homeVM.update();
                        },
                        child: DrawerHeader(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(profileBg),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child:
                                          homeVM.currentUserData.profileUrl !=
                                                      null &&
                                                  homeVM.currentUserData
                                                      .profileUrl!.isNotEmpty
                                              ? CachedNetworkImage(
                                                  height: 68.0,
                                                  width: 68.0,
                                                  imageUrl: homeVM
                                                      .currentUserData
                                                      .profileUrl!,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            strokeWidth: 2),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.asset(
                                                    logoRound,
                                                    height: 68.0,
                                                    width: 68.0,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : Image.asset(
                                                  logoRound,
                                                  height: 68.0,
                                                  width: 68.0,
                                                  fit: BoxFit.fill,
                                                ),
                                    ),
                                    Text(
                                      '${homeVM.currentUserData.firstName} ${homeVM.currentUserData.lastName}',
                                      style: fontBold.copyWith(
                                          fontSize: fontSize22, color: white),
                                    ),
                                    Text(
                                      '${homeVM.currentUserData.currentUserOrganization?.companyName ?? ""}',
                                      style: fontRegular.copyWith(
                                          fontSize: fontSize14,
                                          color: lavenderMist),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Image.asset(
                                  color: lavenderMist,
                                  nextArrow,
                                  height: iconSize18,
                                  width: iconSize18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: paddingSize10),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        color: lavenderMist,
                        child: Column(
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     Get.toNamed(
                            //       Routes.getMyNetworkPageRoute(),
                            //     );
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: paddingSize10,
                            //         horizontal: paddingSize10),
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           "My Network",
                            //           style: fontMedium.copyWith(
                            //               color: midnightBlue,
                            //               fontSize: fontSize16),
                            //         ),
                            //         Spacer(),
                            //         Image.asset(
                            //           nextArrow,
                            //           height: iconSize18,
                            //           width: iconSize18,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Divider(),
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.toNamed(Routes.getLanguagePageRoute());
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: paddingSize10,
                                    horizontal: paddingSize10),
                                child: Row(
                                  children: [
                                    Text(
                                      "language".tr,
                                      style: fontMedium.copyWith(
                                          color: midnightBlue,
                                          fontSize: fontSize16),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      nextArrow,
                                      height: iconSize18,
                                      width: iconSize18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            InkWell(
                              onTap: () async {
                                Get.back();
                                bool isResult = await Get.toNamed(
                                  Routes.getMyBusinessPageRoute(
                                      homeVM.currentUserData),
                                );
                                if (isResult ?? false) {
                                  await getCurrentUser(homeVM);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: paddingSize10,
                                    horizontal: paddingSize10),
                                child: Row(
                                  children: [
                                    Text(
                                      "my_business".tr,
                                      style: fontMedium.copyWith(
                                          color: midnightBlue,
                                          fontSize: fontSize16),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      nextArrow,
                                      height: iconSize18,
                                      width: iconSize18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            InkWell(
                              onTap: () async {
                                Get.back();
                                bool isResult = await Get.toNamed(
                                    Routes.getAddressPageRoute(
                                        homeVM.currentUserData));
                                if (isResult ?? false) {
                                  await getCurrentUser(homeVM);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: paddingSize10,
                                    horizontal: paddingSize10),
                                child: Row(
                                  children: [
                                    Text(
                                      "address".tr,
                                      style: fontMedium.copyWith(
                                          color: midnightBlue,
                                          fontSize: fontSize16),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      nextArrow,
                                      height: iconSize18,
                                      width: iconSize18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            InkWell(
                              onTap: () async {
                                Get.back();
                                bool isResult = await Get.toNamed(
                                    Routes.getContactPageRoute(
                                        homeVM.currentUserData));
                                if (isResult ?? false) {
                                  await getCurrentUser(homeVM);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: paddingSize10,
                                    horizontal: paddingSize10),
                                child: Row(
                                  children: [
                                    Text(
                                      "contact".tr,
                                      style: fontMedium.copyWith(
                                          color: midnightBlue,
                                          fontSize: fontSize16),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      nextArrow,
                                      height: iconSize18,
                                      width: iconSize18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // Divider(),
                            // InkWell(
                            //   onTap: () {
                            //     Get.toNamed(Routes.getActivityFeedsPage());
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: paddingSize10,
                            //         horizontal: paddingSize10),
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           "Activity Feed",
                            //           style: fontMedium.copyWith(
                            //               color: midnightBlue,
                            //               fontSize: fontSize16),
                            //         ),
                            //         Spacer(),
                            //         Image.asset(
                            //           nextArrow,
                            //           height: iconSize18,
                            //           width: iconSize18,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: paddingSize20,
                      ),
                      Container(
                        padding: EdgeInsets.all(5.0),
                        color: lavenderMist,
                        child: Column(
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     Get.toNamed(
                            //       Routes.getAccountSettingsPageRoute(),
                            //     );
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: paddingSize10,
                            //         horizontal: paddingSize10),
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           "Account Settings",
                            //           style: fontMedium.copyWith(
                            //               color: midnightBlue,
                            //               fontSize: fontSize16),
                            //         ),
                            //         Spacer(),
                            //         Image.asset(
                            //           nextArrow,
                            //           height: iconSize18,
                            //           width: iconSize18,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Divider(),
                            // InkWell(
                            //   onTap: () {
                            //     Get.toNamed(Routes.getUpdateUsernameRoute());
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: paddingSize10,
                            //         horizontal: paddingSize10),
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           "Update Username",
                            //           style: fontMedium.copyWith(
                            //               color: midnightBlue,
                            //               fontSize: fontSize16),
                            //         ),
                            //         Spacer(),
                            //         Image.asset(
                            //           nextArrow,
                            //           height: iconSize18,
                            //           width: iconSize18,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Divider(),
                            InkWell(
                              onTap: () async {
                                Get.back();
                                bool isResult = await Get.toNamed(
                                  Routes.getUpdatePasswordPageRoute(),
                                );
                                if (isResult ?? false) {
                                  await getCurrentUser(homeVM);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: paddingSize10,
                                    horizontal: paddingSize10),
                                child: Row(
                                  children: [
                                    Text(
                                      "update_password".tr,
                                      style: fontMedium.copyWith(
                                          color: midnightBlue,
                                          fontSize: fontSize16),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      nextArrow,
                                      height: iconSize18,
                                      width: iconSize18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            InkWell(
                              onTap: () async {
                                Get.back();
                                await showLogoutDialog(homeVM);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: paddingSize10,
                                    horizontal: paddingSize10),
                                child: Row(
                                  children: [
                                    Text(
                                      "logout_title".tr,
                                      style: fontMedium.copyWith(
                                          color: midnightBlue,
                                          fontSize: fontSize16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: homeVM.isAllPostPage.value
                ? FloatingActionButton(
                    tooltip: "Ask",
                    elevation: 4.0,
                    backgroundColor: midnightBlue,
                    onPressed: () {
                      Get.toNamed(Routes.getAskListPageRoute());
                    },
                    child: Image.asset(
                      ask,
                      color: periwinkle,
                      height: iconSize24,
                      width: iconSize24,
                    ),
                  )
                : Container(),
            body: Column(
              children: [
                Visibility(
                  visible: homeVM.isLoading,
                  child: LinearProgressIndicator(
                    color: midnightBlue,
                    backgroundColor: lavenderMist,
                    borderRadius: BorderRadius.circular(radius20),
                  ),
                ),
                homeVM.isAllPostPage.value
                    ? Expanded(child: _allPostWidget(homeVM))
                    : Expanded(child: _homeDataWidget(homeVM)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              type: BottomNavigationBarType.fixed,
              useLegacyColorScheme: false,
              elevation: 4.0,
              currentIndex: homeVM.selectedIndex.value,
              backgroundColor: ghostWhite,
              selectedItemColor: midnightBlue,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "home".tr,
                    tooltip: "home".tr),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_repair_service),
                    label: "dashboard".tr,
                    tooltip: "dashboard".tr),
              ],
              onTap: (label) {
                switch (label) {
                  case 0:
                    debugPrint("Home");
                    homeVM.isAllPostPage.value = true;
                    homeVM.selectedIndex.value = 0;
                    break;
                  case 1:
                    debugPrint("Dashboard");
                    homeVM.isAllPostPage.value = false;
                    homeVM.selectedIndex.value = 1;
                    break;
                  default:
                    debugPrint("Home Default");
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Future<void> showFilterDialog(HomeViewModel homeVM) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: paddingSize25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    onTap: () async {
                      Get.back();
                      homeVM.isAllPost = true.obs;
                      await callPostOrMyPostAPI(homeVM);
                    },
                    child: Row(
                      children: [
                        Image.asset(postUpload,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "all_posts".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: paddingSize10, horizontal: paddingSize20),
                  child: InkWell(
                    onTap: () async {
                      Get.back();
                      homeVM.isAllPost = false.obs;
                      homeVM.postData = [];
                      await homeVM.getMyPosts();
                    },
                    child: Row(
                      children: [
                        Image.asset(postUpload,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24),
                        SizedBox(width: paddingSize10),
                        Text(
                          "my_posts".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: paddingSize10, horizontal: paddingSize20),
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //       askVM.setSelectedFilter("Personal");
                //       setState(() {});
                //     },
                //     child: Row(
                //       children: [
                //         Image.asset(ask,
                //             color: bluishPurple,
                //             height: iconSize24,
                //             width: iconSize24),
                //         SizedBox(width: paddingSize10),
                //         Text(
                //           "Personal Asks",
                //           style: fontMedium.copyWith(
                //               color: midnightBlue, fontSize: fontSize14),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Divider(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: paddingSize10, horizontal: paddingSize20),
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //       askVM.setSelectedFilter("General");
                //       setState(() {});
                //     },
                //     child: Row(
                //       children: [
                //         Image.asset(ask,
                //             color: bluishPurple,
                //             height: iconSize24,
                //             width: iconSize24),
                //         SizedBox(width: paddingSize10),
                //         Text(
                //           "General Asks",
                //           style: fontMedium.copyWith(
                //               color: midnightBlue, fontSize: fontSize14),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: paddingSize25),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showLogoutDialog(HomeViewModel homeVM) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            child: Container(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "logout_title".tr,
                      style: fontBold.copyWith(
                          color: midnightBlue, fontSize: fontSize18),
                    ),
                    SizedBox(
                      height: paddingSize25,
                    ),
                    Text("logout_msg".tr,
                        style: fontMedium.copyWith(
                            color: midnightBlue, fontSize: fontSize14)),
                    SizedBox(
                      height: paddingSize25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(paddingSize15),
                          child: InkWell(
                            child: Text("no".tr,
                                style: fontMedium.copyWith(
                                    color: greyText, fontSize: fontSize14)),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(paddingSize15),
                          child: InkWell(
                            child: Text("yes".tr,
                                style: fontBold.copyWith(
                                    color: midnightBlue, fontSize: fontSize14)),
                            onTap: () async {
                              await homeVM.clearSharedPreferenceAndLogout();
                              Get.offAll(new AuthenticationPage());
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
    // DialogHelper dialogHelper = DialogHelper(
    //     title: "logout_title".tr,
    //     message: "logout_msg".tr,
    //     positiveButtonText: "yes".tr,
    //     negativeButtonText: "no".tr,
    //     isShowIcon: false,
    //     icon: "",
    //     onNegativeClick: () async {
    //       Get.back();
    //     },
    //     onPositiveClick: () async {
    //       await homeVM.clearSharedPreferenceAndLogout();
    //       Get.offAll(new AuthenticationPage());
    //     });
    // dialogHelper.showCommonDialog(context);
  }

  Future<void> showPostOrCommentDeleteDialog(
      HomeViewModel homeVM, String postUuid, String commentID) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            child: Container(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          delete,
                          height: iconSize22,
                          width: iconSize22,
                        ),
                        const SizedBox(width: 14.0),
                        Text(
                          "delete_data".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: paddingSize25,
                    ),
                    Text("delete_post_msg".tr,
                        style: fontMedium.copyWith(
                            color: midnightBlue, fontSize: fontSize14)),
                    SizedBox(
                      height: paddingSize25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(paddingSize15),
                          child: InkWell(
                            child: Text("no".tr,
                                style: fontMedium.copyWith(
                                    color: greyText, fontSize: fontSize14)),
                            onTap: () {
                              Get.close(0);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(paddingSize15),
                          child: InkWell(
                            child: Text("yes".tr,
                                style: fontBold.copyWith(
                                    color: midnightBlue, fontSize: fontSize14)),
                            onTap: () async {
                              Get.close(0);
                              if (commentID.isEmpty) {
                                bool isSuccess =
                                    await homeVM.deletePost(postUuid);
                                if (isSuccess) {
                                  showSnackBar("post_deleted".tr,
                                      isError: false);
                                } else {
                                  showSnackBar("errorMessage".tr);
                                }
                              } else {
                                Get.close(1);
                                bool isSuccess = await homeVM
                                    .deleteCommentOnPost(postUuid, commentID);
                                if (isSuccess) {
                                  showSnackBar("post_deleted".tr,
                                      isError: false);
                                } else {
                                  showSnackBar("errorMessage".tr);
                                }
                              }
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _allPostWidget(HomeViewModel homeVM) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: paddingSize10, vertical: paddingSize10),
            child: CommonCard(
              elevation: 0.0,
              bgColor: lavenderMist,
              cardChild: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: paddingSize10, vertical: paddingSize15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "post_text".tr,
                      style: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(postUpload,
                          width: iconSize24, height: iconSize24),
                    )
                  ],
                ),
              ),
              onTap: () async {
                bool result = await Get.toNamed(
                    Routes.getAddPostPageRoute(homeVM.currentUserData));
                if (result ?? false) {
                  // showSnackBar(homeVM.isAllPost.value.toString(),
                  //     isError: false);
                  await callPostOrMyPostAPI(homeVM);
                }
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
            child: Text(
              homeVM.isAllPost.value ? "all_posts".tr : "my_posts".tr,
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize16),
            ),
          ),
          homeVM.postData.isNotEmpty
              ? Expanded(
                  child: LoadMore(
                      isFinish: homeVM.page.value == homeVM.totalPages.value,
                      whenEmptyLoad: true,
                      delegate: const DefaultLoadMoreDelegate(),
                      textBuilder: DefaultLoadMoreTextBuilder.english,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _postListItems(index, homeVM);
                        },
                        itemCount: homeVM.postData.length,
                      ),
                      onLoadMore: homeVM.loadMore),
                )
              : homeVM.isLoading
                  ? Container()
                  : Expanded(
                      child: Center(
                        child: Text(
                          "no_posts".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize18),
                        ),
                      ),
                    )
        ]);
  }

  Future<void> callPostOrMyPostAPI(HomeViewModel homeVM) async {
    if (homeVM.isAllPost.value == false) {
      homeVM.postData = [];
      await homeVM.getMyPosts();
    } else {
      homeVM.postData = [];
      await getPosts(homeVM.page.value, homeVM.size.value, "", "", "");
    }
  }

  _homeDataWidget(HomeViewModel homeVM) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: paddingSize10, vertical: paddingSize15),
        child: Column(
          children: [
            _bannerSlider(homeVM),
            // DotsIndicator(
            //   dotsCount: homeVM.bannerList.length,
            //   position: homeVM.currentDotPosition,
            //   axis: Axis.horizontal,
            //   onTap: (position) async {
            //     if (position < homeVM.bannerList.length) {
            //       await homeVM.nextSlide(position);
            //     } else {
            //       await homeVM.prevSlide(position);
            //     }
            //   },
            // ),
            SizedBox(height: paddingSize30),
            _meetingCard(homeVM),
            SizedBox(height: paddingSize15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonCard(
                  bgColor: bluishPurple,
                  cardChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "this_week_slips".tr,
                      style: fontRegular.copyWith(
                          color: ghostWhite, fontSize: fontSize14),
                    ),
                  ),
                ),
                Spacer(),
                // Image.asset(
                //   printerBlue,
                //   width: iconSize24,
                //   height: iconSize24,
                // ),
                // CommonCard(
                //   bgColor: lavenderMist,
                //   elevation: 0.0,
                //   cardChild: Padding(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                //     child: InkWell(
                //       child: Image.asset(
                //         viewBlue,
                //         width: iconSize24,
                //         height: iconSize24,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(width: 5.0),
              ],
            ),
            SizedBox(height: paddingSize15),
            _otherFunctions(homeVM),
            SizedBox(height: paddingSize25),
            _moreDataDetails(homeVM)
          ],
        ),
      ),
    );
  }

  _meetingCard(HomeViewModel homeVM) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CommonCard(
          onTap: () {
            // Get.toNamed(Routes.getCeuSlipPageRoute());
          },
          elevation: 0.0,
          bgColor: lavenderMist,
          cardChild: Padding(
            padding: const EdgeInsets.only(
                bottom: paddingSize20,
                top: paddingSize30,
                right: paddingSize30,
                left: paddingSize30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${homeVM.nextMeeting?.day ?? ""}',
                          style: fontRegular.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                        Text(
                          '${homeVM.nextMeeting?.date ?? ""}',
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize16),
                        ),
                      ],
                    ),
                    Container(
                      color: bluishPurple,
                      width: 2.0,
                      height: 40.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time :".tr,
                          style: fontRegular.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                        Text(
                          '${homeVM.nextMeeting?.startTime ?? ""} - ${homeVM.nextMeeting?.endTime ?? ""}',
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize16),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: paddingSize15),
                Divider(thickness: 2.0, color: bluishPurple),
                SizedBox(height: paddingSize15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.getVisitorPageRoute());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "visitors".tr.toUpperCase(),
                            style: fontRegular.copyWith(
                                color: midnightBlue, fontSize: fontSize12),
                          ),
                          Text(
                            '${homeVM.nextMeeting?.visitors}',
                            style: fontBold.copyWith(
                                color: midnightBlue, fontSize: fontSize16),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "speakers".tr,
                            style: fontRegular.copyWith(
                                color: midnightBlue, fontSize: fontSize12),
                          ),
                          Text(
                            '${homeVM.nextMeeting?.speakers}',
                            style: fontBold.copyWith(
                                color: midnightBlue, fontSize: fontSize16),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.getTrainingPageRoute());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "trainer".tr.toUpperCase(),
                            style: fontRegular.copyWith(
                                color: midnightBlue, fontSize: fontSize12),
                          ),
                          Text(
                            '${homeVM.nextMeeting?.trainer}',
                            style: fontBold.copyWith(
                                color: midnightBlue, fontSize: fontSize16),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "guest".tr.toUpperCase(),
                            style: fontRegular.copyWith(
                                color: midnightBlue, fontSize: fontSize12),
                          ),
                          Text(
                            '${homeVM.nextMeeting?.guest}',
                            style: fontBold.copyWith(
                                color: midnightBlue, fontSize: fontSize16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: 20,
          child: CommonCard(
            elevation: 0.0,
            bgColor: bluishPurple,
            cardChild: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: paddingSize15, vertical: paddingSize5),
              child: Text(
                "next_meeting".tr,
                style: fontRegular.copyWith(
                    color: ghostWhite, fontSize: fontSize14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _bannerSlider(HomeViewModel homeVM) {
    return CarouselSlider(
      carouselController: homeVM.controller,
      options: CarouselOptions(
        height: 350.0,
        viewportFraction: 1.0,
        // onPageChanged: (position, reason) async {
        //   homeVM.updatePosition(position);
        // }
      ),
      items: homeVM.bannerList.map((i) {
        return Card(
          shape: Border.all(color: lavenderMist),
          elevation: 2.0,
          child: Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: i.url!,
                ),
              );
            },
          ),
        );
      }).toList(),
    );

    // return InkWell(
    //   onTap: () {
    //     Get.toNamed(Routes.getProfileRoute());
    //   },
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(radius10),
    //       image: DecorationImage(
    //         image: AssetImage(profileBg),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(vertical: paddingSize30),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Image.asset(
    //             profileImage,
    //             height: 68.0,
    //             width: 68.0,
    //           ),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Poonam Tala",
    //                     style: fontBold.copyWith(
    //                         fontSize: fontSize22, color: ghostWhite),
    //                   ),
    //                   SizedBox(width: 4.0),
    //                   Image.asset(live),
    //                 ],
    //               ),
    //               Text(
    //                 "BNI Utsav",
    //                 style: fontRegular.copyWith(
    //                     fontSize: fontSize14, color: periwinkle),
    //               ),
    //               Text(
    //                 "Due date : 30/01/2024",
    //                 style: fontRegular.copyWith(
    //                     fontSize: fontSize14, color: periwinkle),
    //               )
    //             ],
    //           ),
    //           Image.asset(
    //             arrowWhite,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  _otherFunctions(HomeViewModel homeVM) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CommonCard(
                elevation: 0.0,
                bgColor: lavenderMist,
                onTap: () {
                  Get.toNamed(Routes.getTYFCBsPageRoute());
                },
                cardChild: Padding(
                  padding: const EdgeInsets.only(
                      left: paddingSize25,
                      top: paddingSize25,
                      bottom: paddingSize25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(tyfcbs,
                          height: iconSize24, width: iconSize24),
                      Text(
                        "tyfcb".tr,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize16),
                      ),
                      Text(
                        '${homeVM.tyfcbCount}',
                        style: fontBold.copyWith(
                          color: bluishPurple,
                          fontSize: fontSize20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: paddingSize20),
            Expanded(
              child: CommonCard(
                elevation: 0.0,
                bgColor: lavenderMist,
                onTap: () async {
                  await Get.toNamed(Routes.getReferralsPageRoute());

                  await getDashboardData(homeVM.selectedDuration);
                  setState(() {});
                },
                cardChild: Padding(
                  padding: const EdgeInsets.only(
                      left: paddingSize25,
                      top: paddingSize25,
                      bottom: paddingSize25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(referrals,
                          height: iconSize24, width: iconSize24),
                      Text(
                        "referrals".tr,
                        // overflow: TextOverflow.ellipsis,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize16),
                      ),
                      Text(
                        '${homeVM.referralCount}',
                        style: fontBold.copyWith(
                          color: bluishPurple,
                          fontSize: fontSize20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: paddingSize5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CommonCard(
                elevation: 0.0,
                bgColor: lavenderMist,
                onTap: () async {
                  await Get.toNamed(Routes.getVisitorPageRoute());
                  await getDashboardData(homeVM.selectedDuration);
                  setState(() {});
                },
                cardChild: Padding(
                  padding: const EdgeInsets.only(
                      left: paddingSize25,
                      top: paddingSize25,
                      bottom: paddingSize25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        visitors,
                        height: iconSize24,
                        width: iconSize24,
                      ),
                      Text(
                        "visitors".tr,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize16),
                      ),
                      Text(
                        '${homeVM.visitorsCount}',
                        style: fontBold.copyWith(
                          color: bluishPurple,
                          fontSize: fontSize20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: paddingSize20),
            Expanded(
              child: CommonCard(
                elevation: 0.0,
                bgColor: lavenderMist,
                onTap: () async {
                  await Get.toNamed(Routes.getOneToOnePageRoute());
                  await getDashboardData(homeVM.selectedDuration);
                  setState(() {});
                },
                cardChild: Padding(
                  padding: const EdgeInsets.only(
                      left: paddingSize25,
                      top: paddingSize25,
                      bottom: paddingSize25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        oneToOne,
                        height: iconSize24,
                        width: iconSize24,
                      ),
                      Text(
                        "one_to_one".tr,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize16),
                      ),
                      Text(
                        '${homeVM.oneToOneCount}',
                        style: fontBold.copyWith(
                          color: bluishPurple,
                          fontSize: fontSize20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: paddingSize5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CommonCard(
                elevation: 0.0,
                bgColor: lavenderMist,
                onTap: () {
                  Get.toNamed(Routes.getTrainingPageRoute());
                },
                cardChild: Padding(
                  padding: const EdgeInsets.only(
                      left: paddingSize25,
                      top: paddingSize25,
                      bottom: paddingSize25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        training,
                        height: iconSize24,
                        width: iconSize24,
                      ),
                      Text(
                        "training".tr,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize16),
                      ),
                      Text(
                        '${homeVM.trainingCount}',
                        style: fontBold.copyWith(
                          color: bluishPurple,
                          fontSize: fontSize20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: paddingSize20),
            Expanded(
              child: CommonCard(
                elevation: 0.0,
                bgColor: lavenderMist,
                onTap: () {
                  Get.toNamed(Routes.getTestimonialPageRoute());
                },
                cardChild: Padding(
                  padding: const EdgeInsets.only(
                      left: paddingSize25,
                      top: paddingSize25,
                      bottom: paddingSize25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        testimonials,
                        height: iconSize24,
                        width: iconSize24,
                      ),
                      Text(
                        "testimonials".tr,
                        style: fontRegular.copyWith(
                            color: midnightBlue, fontSize: fontSize16),
                      ),
                      Text(
                        '${homeVM.testimonialsCount}',
                        style: fontBold.copyWith(
                          color: bluishPurple,
                          fontSize: fontSize20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _moreDataDetails(HomeViewModel homeVM) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        CommonCard(
          elevation: 0.0,
          bgColor: lavenderMist,
          radius: 16.0,
          cardChild: Padding(
              padding: const EdgeInsets.only(
                  left: paddingSize25,
                  right: paddingSize25,
                  bottom: paddingSize25,
                  top: paddingSize55),
              child: Column(
                children: [
                  _rowItem("one_to_one".tr, homeVM.fcOneToOne),
                  _divider(),
                  _rowItem("Referrals Given", homeVM.fcReferralGiven),
                  _divider(),
                  _rowItem("Referrals Received", homeVM.fcReferralReceived),
                  _divider(),
                  _rowItem("TYFCB Given", homeVM.fcTyfcb),
                  _divider(),
                  _rowItem("Revenue Received", homeVM.fcRevenue),
                  _divider(),
                  _rowItem("visitors".tr, homeVM.fcVisitors),
                  _divider(),
                  _rowItem("CEUs", homeVM.fcCeus),
                ],
              )),
          onTap: () {},
        ),
        Positioned(
          top: -18,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: paddingSize5, vertical: paddingSize5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonCard(
                  elevation: 0.0,
                  bgColor: homeVM.selectedData6month.value
                      ? bluishPurple
                      : periwinkle,
                  onTap: () async {
                    homeVM.selectedData6month.value = true;
                    homeVM.selectedData12month.value = false;
                    homeVM.selectedDataLifeTime.value = false;
                    homeVM.select6Month();
                    await getDashboardData("SIX_MONTH");
                    setState(() {});
                  },
                  cardChild: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize15, vertical: paddingSize10),
                    child: Text(
                      textAlign: TextAlign.center,
                      "6_months".tr,
                      overflow: TextOverflow.ellipsis,
                      style: fontRegular.copyWith(
                          color:
                              homeVM.selectedData6month.value ? white : black,
                          fontSize: fontSize14),
                    ),
                  ),
                ),
                CommonCard(
                  elevation: 0.0,
                  bgColor: homeVM.selectedData12month.value
                      ? bluishPurple
                      : periwinkle,
                  onTap: () async {
                    homeVM.selectedData6month.value = false;
                    homeVM.selectedData12month.value = true;
                    homeVM.selectedDataLifeTime.value = false;
                    homeVM.select12Month();
                    await getDashboardData("ONE_YEAR");
                    setState(() {});
                  },
                  cardChild: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize15, vertical: paddingSize10),
                    child: Text(
                      textAlign: TextAlign.center,
                      "12_months".tr,
                      overflow: TextOverflow.ellipsis,
                      style: fontRegular.copyWith(
                          color:
                              homeVM.selectedData12month.value ? white : black,
                          fontSize: fontSize14),
                    ),
                  ),
                ),
                CommonCard(
                  elevation: 0.0,
                  bgColor: homeVM.selectedDataLifeTime.value
                      ? bluishPurple
                      : periwinkle,
                  onTap: () async {
                    homeVM.selectedData6month.value = false;
                    homeVM.selectedData12month.value = false;
                    homeVM.selectedDataLifeTime.value = true;
                    homeVM.selectLifeTime();
                    await getDashboardData("ALL");
                    setState(() {});
                  },
                  cardChild: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize15, vertical: paddingSize10),
                    child: Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      "lifetime".tr,
                      style: fontRegular.copyWith(
                          color:
                              homeVM.selectedDataLifeTime.value ? white : black,
                          fontSize: fontSize14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rowItem(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            title,
            style: fontRegular.copyWith(
              color: midnightBlue,
              fontSize: fontSize14,
            ),
          ),
          Spacer(),
          Text(
            value.toString(),
            style: fontBold.copyWith(
              color: midnightBlue,
              fontSize: fontSize14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(color: bluishPurple.withOpacity(0.3));
  }

  _postListItems(int index, HomeViewModel homeVM) {
    PostChildData data = homeVM.postData[index];
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: CommonCard(
        bgColor: white,
        elevation: 3.0,
        cardChild: Padding(
          padding: const EdgeInsets.all(paddingSize15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: () {
                      final String? avatarUrl =
                          data.createdBy == globalCurrentUserData.uuid
                              ? globalCurrentUserData.profileUrl
                              : data.profileUrl;

                      return avatarUrl != null && avatarUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: avatarUrl,
                              width: 42.0,
                              height: 42.0,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  SizedBox(width: 42.0, height: 42.0),
                              errorWidget: (context, url, error) => Image.asset(
                                profileImage,
                                width: 42.0,
                                height: 42.0,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              profileImage,
                              width: 42.0,
                              height: 42.0,
                              fit: BoxFit.cover,
                            );
                    }(),
                  ),
                  SizedBox(width: paddingSize10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.firstName} ${data.lastName}',
                          style: fontMedium.copyWith(
                              fontSize: fontSize14, color: midnightBlue),
                        ),
                        Text(
                          '${DateConverter.convertDateToDate(data.createdAt ?? DateTime.now().toString())}',
                          style: fontMedium.copyWith(
                              fontSize: fontSize10, color: greyText),
                        ),
                        Text(
                          data.postRegion == "CITY_REGION"
                              ? 'CITY'
                              : '${data.postRegion}',
                          style: fontMedium.copyWith(
                              fontSize: fontSize10, color: greyText),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        data.createdBy.toString() == globalCurrentUserData.uuid,
                    child: PopupMenuButton<int>(
                      padding: EdgeInsets.zero,
                      offset: Offset(0, 40),
                      elevation: 2.0,
                      onSelected: (value) async {
                        await showPostOrCommentDeleteDialog(
                            homeVM, data.postUuid!, "");
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Image.asset(
                                delete,
                                height: iconSize22,
                                width: iconSize22,
                              ),
                              Spacer(),
                              Text(
                                "delete_post".tr,
                                style: fontMedium.copyWith(
                                    color: midnightBlue, fontSize: fontSize12),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Visibility(
                  //   visible:
                  //       data.createdBy.toString() == globalCurrentUserData.uuid,
                  //   child: InkWell(
                  //     onTap: () {
                  //       PopupMenuButton<int>(
                  //         offset: Offset(0, 100),
                  //         color: Colors.grey,
                  //         elevation: 2,
                  //         onSelected: (value) {},
                  //         itemBuilder: (context) => [
                  //           PopupMenuItem(
                  //             value: 1,
                  //             // row with 2 children
                  //             child: Row(
                  //               children: [
                  //                 Icon(Icons.star),
                  //                 SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Text("Get The App")
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //     customBorder: new CircleBorder(),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(paddingSize8),
                  //       child: Image.asset(
                  //         menu,
                  //         height: 24.0,
                  //         width: 24.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: paddingSize8),
              //   child: Text(
              //     data.createdAt ?? "",
              //     style: fontRegular.copyWith(
              //         color: midnightBlue, fontSize: fontSize10),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: paddingSize15),
              //   child: Text(
              //     data.title ?? "",
              //     style: fontMedium.copyWith(
              //         color: midnightBlue, fontSize: fontSize12),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: paddingSize8),
                child: Text(
                  data.content ?? "",
                  style: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize12),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(radius10)),
                child: data.imageUrl != null && data.imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: data.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: SizedBox.shrink(),
                        ),
                        errorWidget: (context, url, error) => SizedBox.shrink(),
                      )
                    : SizedBox.shrink(),
              ),
              SizedBox(height: paddingSize5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<HomeViewModel>(builder: (_) {
                    return InkWell(
                      onTap: () async {
                        Response response = await homeVM.likeOnPost(data);
                        if (response.statusCode != 201) {
                          showSnackBar(response.body['message']);
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            data.isLikeLoading
                                ? const CircularProgressIndicator()
                                : Image.asset(
                                    data.isPostLiked ? liked : like,
                                    height: iconSize28,
                                    width: iconSize28,
                                  ),
                            const SizedBox(width: 4.0),
                            Text(
                              (data.likesCounter ?? 0).toString(),
                              style: fontRegular.copyWith(
                                  fontSize: fontSize12, color: greyText),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () async {
                      await _showAllCommentsSheet(data, homeVM);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          homeVM.isCommentLoading
                              ? CircularProgressIndicator()
                              : Image.asset(
                                  postComment,
                                  height: iconSize24,
                                  width: iconSize24,
                                ),
                          SizedBox(width: 4.0),
                          Text(
                            data.commentsCounter.toString(),
                            style: fontRegular.copyWith(
                                fontSize: fontSize12, color: greyText),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String shareString = data.content.toString() +
                          "\n\n Download App Now - $playStoreUrl";
                      if (data.imageUrl!.isNotEmpty) {
                        Uri postImageUri = Uri.parse(data.imageUrl!);
                        var client = http.Client();
                        final resp = await client.get(postImageUri);
                        final bytes = resp.bodyBytes;
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/image.jpg';
                        File file = File(path);
                        file.writeAsBytesSync(bytes);
                        XFile image = XFile(file.path);
                        await Share.shareXFiles([image], text: shareString);
                        // final response = await Share.share(shareString);
                        // await Share.shareUri(Uri.parse(data.imageUrl.toString()));
                      } else {
                        await Share.share(shareString);
                      }
                    },
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            postShare,
                            height: iconSize22,
                            width: iconSize22,
                          ),
                          // SizedBox(width: 4.0),
                          // Text(
                          //   "0",
                          //   style: fontRegular.copyWith(
                          //       fontSize: fontSize12, color: greyText),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: paddingSize5),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     Expanded(
              //       child: Text(
              //         "Liked by Lorem Ipsum and 155 others Liked by Lorem Ipsum and 155 others Liked by Lorem Ipsum and 155 others ",
              //         style: fontRegular.copyWith(
              //             color: midnightBlue, fontSize: fontSize10),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         _showAllCommentsSheet();
              //       },
              //       child: Text(
              //         "4 Comments",
              //         style: fontRegular.copyWith(
              //             color: midnightBlue, fontSize: fontSize10),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAllCommentsSheet(
      PostChildData data, HomeViewModel homeVM) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.001),
              child: GestureDetector(
                onTap: () {},
                child: DraggableScrollableSheet(
                  expand: true,
                  initialChildSize: 0.4,
                  minChildSize: 0.2,
                  maxChildSize: 0.75,
                  builder: (_, controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: data.comments != null
                                    ? data.comments!.length > 0
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            controller: controller,
                                            itemCount: data.comments!.length,
                                            itemBuilder: (_, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 14.0,
                                                    top: 14.0,
                                                    right: 14.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    globalCurrentUserData
                                                                    .profileUrl !=
                                                                null &&
                                                            globalCurrentUserData
                                                                .profileUrl!
                                                                .isNotEmpty
                                                        ? CachedNetworkImage(
                                                            imageUrl:
                                                                globalCurrentUserData
                                                                    .profileUrl!,
                                                            height: 40.0,
                                                            width: 40.0,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const SizedBox(
                                                              height: 40.0,
                                                              width: 40.0,
                                                              child: Center(
                                                                child: CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2),
                                                              ),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              profileImage,
                                                              height: 40.0,
                                                              width: 40.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            profileImage,
                                                            height: 40.0,
                                                            width: 40.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                    SizedBox(
                                                        width: paddingSize10),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data
                                                                    .comments?[
                                                                        index]
                                                                    .comment ??
                                                                "",
                                                            style: fontMedium.copyWith(
                                                                fontSize:
                                                                    fontSize12,
                                                                color:
                                                                    midnightBlue),
                                                          ),
                                                          // Text(
                                                          //   "Beautiful place.",
                                                          //   style: fontRegular
                                                          //       .copyWith(
                                                          //           fontSize:
                                                          //               fontSize8,
                                                          //           color:
                                                          //               midnightBlue),
                                                          // ),
                                                          SizedBox(
                                                              height:
                                                                  paddingSize5),
                                                          // Row(
                                                          //   mainAxisSize: MainAxisSize.max,
                                                          //   mainAxisAlignment:
                                                          //       MainAxisAlignment.start,
                                                          //   crossAxisAlignment:
                                                          //       CrossAxisAlignment.center,
                                                          //   children: [
                                                          //     Text(
                                                          //       "1h",
                                                          //       style: fontRegular.copyWith(
                                                          //           fontSize: fontSize10,
                                                          //           color: spunPearl),
                                                          //     ),
                                                          //     SizedBox(width: paddingSize8),
                                                          //     Text(
                                                          //       "Like",
                                                          //       style: fontRegular.copyWith(
                                                          //           fontSize: fontSize10,
                                                          //           color: spunPearl),
                                                          //     ),
                                                          //     SizedBox(width: paddingSize8),
                                                          //     Text(
                                                          //       "Reply",
                                                          //       style: fontRegular.copyWith(
                                                          //           fontSize: fontSize10,
                                                          //           color: spunPearl),
                                                          //     ),
                                                          //   ],
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: data
                                                              .comments![index]
                                                              .userId ==
                                                          data.createdBy,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await showPostOrCommentDeleteDialog(
                                                              homeVM,
                                                              data.postUuid!,
                                                              data
                                                                  .comments![
                                                                      index]
                                                                  .commentUuid!);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.asset(
                                                            delete,
                                                            height: 16.0,
                                                            width: 16.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : Center(child: Text("no_comments".tr))
                                    : Center(child: Text("no_comments".tr))),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                globalCurrentUserData.profileUrl != null &&
                                        globalCurrentUserData
                                            .profileUrl!.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            globalCurrentUserData.profileUrl!,
                                        height: 40.0,
                                        width: 40.0,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                          height: 40.0,
                                          width: 40.0,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          profileImage,
                                          height: 40.0,
                                          width: 40.0,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        profileImage,
                                        height: 40.0,
                                        width: 40.0,
                                        fit: BoxFit.cover,
                                      ),
                                SizedBox(width: 5.0),
                                Expanded(
                                  child: CommonTextFormField(
                                    controller: homeVM.commentController,
                                    padding: EdgeInsets.all(14.0),
                                    bgColor: white,
                                    hintColor: midnightBlue,
                                    hintText: "add_comments".tr,
                                    textStyle: fontRegular.copyWith(
                                        color: midnightBlue,
                                        fontSize: fontSize12),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                InkWell(
                                  onTap: () async {
                                    if (homeVM
                                        .commentController.text.isNotEmpty) {
                                      Get.back();
                                      bool isSuccess =
                                          await homeVM.commentOnPost(
                                              data.postUuid ?? "",
                                              "",
                                              homeVM.commentController.text
                                                  .toString());
                                      if (isSuccess) {
                                        showSnackBar("added_comments".tr,
                                            isError: false);
                                        homeVM.commentController.text = "";
                                      } else {
                                        showSnackBar('errorMessage'.tr);
                                      }
                                    }
                                  },
                                  child: Image.asset(
                                    send,
                                    width: iconSize24,
                                    height: iconSize24,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> callInitAPIs() async {
    await Get.find<HomeViewModel>().initData();
    await getCurrentUser(Get.find<HomeViewModel>());
    await callPostOrMyPostAPI(Get.find<HomeViewModel>());
    await getDashboardData("ALL");
  }

  Future<void> getPosts(
      int page, int size, String? sort, String? orderBy, String? search) async {
    Get.find<HomeViewModel>().postData = [];
    Get.find<HomeViewModel>().page.value = 0;
    Get.find<HomeViewModel>().totalPages.value = 0;
    await Get.find<HomeViewModel>().getPosts(page, size, sort, orderBy, search);
  }

  Future<void> getDashboardData(String duration) async {
    await Get.find<HomeViewModel>().dashboardData(duration);
  }

  Future<void> getCurrentUser(HomeViewModel homeVM) async {
    homeVM.currentUserData = await homeVM.getCurrentUser();
  }
}
