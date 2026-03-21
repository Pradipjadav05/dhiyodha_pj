import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/viewModel/posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/visiting_card_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  CurrentUserData currentUserData;

  ProfilePageState createState() => ProfilePageState();

  ProfilePage({required this.currentUserData});
}

class ProfilePageState extends State<ProfilePage> {
  CurrentUserData _currentUserData = CurrentUserData();

  @override
  void initState() {
    super.initState();
    _currentUserData = widget.currentUserData;
    Get.find<PostsViewModel>().initData();
  }

  Future<void> _refreshUserData() async {
    try {
      VisitingCardViewModel vvm = Get.find<VisitingCardViewModel>();
      CurrentUserData updatedData = vvm.currentUserData;
      setState(() {
        _currentUserData = updatedData;
      });
    } catch (e) {
      print("Error refreshing user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("profile".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
        menuWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            customBorder: new CircleBorder(),
            onTap: () {
              Get.toNamed(Routes.getWebViewPageRoute(queryWebUrl));
            },
            child: Image.asset(
              query,
              width: 24.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<PostsViewModel>(
          builder: (postVM) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius10),
                      image: DecorationImage(
                        image: AssetImage(profileBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: paddingSize30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              postVM.pickImage("FACE_IMAGE").whenComplete(() {
                                Get.back(result: true, closeOverlays: true);
                              });
                            },
                            child: Stack(
                              children: [
                                postVM.postImageFile != null
                                    ? Image.file(
                                        File(postVM.postImageFile!.path),
                                        height: 68.0,
                                        width: 68.0,
                                        fit: BoxFit.cover,
                                      )
                                    : (_currentUserData.profileUrl != null &&
                                            _currentUserData
                                                .profileUrl!.isNotEmpty)
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                _currentUserData.profileUrl!,
                                            height: 68.0,
                                            width: 68.0,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const SizedBox(
                                              height: 68,
                                              width: 68,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 2),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              logoRound,
                                              height: 68.0,
                                              width: 68.0,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Image.asset(
                                            logoRound,
                                            height: 68.0,
                                            width: 68.0,
                                            fit: BoxFit.cover,
                                          ),
                                Positioned(
                                  left: 44,
                                  top: 42,
                                  child: Image.asset(
                                    roundCamera,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${_currentUserData.firstName} ${_currentUserData.lastName}',
                                    style: fontBold.copyWith(
                                        fontSize: fontSize22,
                                        color: ghostWhite),
                                  ),
                                  SizedBox(width: 4.0),
                                  Image.asset(live),
                                ],
                              ),
                              Text(
                                '${_currentUserData.currentUserOrganization?.companyName}',
                                style: fontRegular.copyWith(
                                    fontSize: fontSize14, color: lavenderMist),
                              ),
                              // Text(
                              //   "",
                              //   style: fontRegular.copyWith(
                              //       fontSize: fontSize12, color: periwinkle),
                              // ),
                              // Text(
                              //   "",
                              //   style: fontRegular.copyWith(
                              //       fontSize: fontSize12, color: periwinkle),
                              // ),
                              SizedBox(height: 4.0),
                              Text(
                                "${_currentUserData.currentUserOrganization?.businessCategory}",
                                style: fontRegular.copyWith(
                                    fontSize: fontSize12, color: periwinkle),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: paddingSize20),
                  CommonCard(
                    elevation: 0.0,
                    bgColor: lavenderMist,
                    cardChild: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize20, horizontal: paddingSize25),
                      child: Row(
                        children: [
                          Text(
                            "share_profile".tr,
                            style: fontRegular.copyWith(
                                color: midnightBlue, fontSize: fontSize16),
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
                    onTap: () {
                      Get.toNamed(Routes.getVisitingCardPageRoute(
                          currentUserData: _currentUserData));
                    },
                  ),
                  SizedBox(height: paddingSize20),
                  CommonCard(
                    onTap: () async {
                      final result = await Get.toNamed(Routes.getMyBioPageRoute(_currentUserData));
                      if (result == true) {
                        await _refreshUserData();
                      }
                    },
                    elevation: 0.0,
                    bgColor: lavenderMist,
                    cardChild: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize20, horizontal: paddingSize25),
                      child: Row(
                        children: [
                          Text(
                            "my_bio".tr,
                            style: fontRegular.copyWith(
                                color: midnightBlue, fontSize: fontSize16),
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
                  // CommonCard(
                  //   elevation: 0.0,
                  //   bgColor: lavenderMist,
                  //   cardChild: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: paddingSize20, horizontal: paddingSize25),
                  //     child: Expanded(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Text(
                  //             "Share my profile",
                  //             style: fontRegular.copyWith(
                  //                 color: midnightBlue, fontSize: fontSize16),
                  //           ),
                  //           Spacer(),
                  //           Image.asset(nextArrow),
                  //           Text(
                  //             "Share my profile",
                  //             style: fontRegular.copyWith(
                  //                 color: midnightBlue, fontSize: fontSize16),
                  //           ),
                  //           Spacer(),
                  //           Image.asset(nextArrow),
                  //           Text(
                  //             "Share my profile",
                  //             style: fontRegular.copyWith(
                  //                 color: midnightBlue, fontSize: fontSize16),
                  //           ),
                  //           Spacer(),
                  //           Image.asset(nextArrow),
                  //           Text(
                  //             "Share my profile",
                  //             style: fontRegular.copyWith(
                  //                 color: midnightBlue, fontSize: fontSize16),
                  //           ),
                  //           Spacer(),
                  //           Image.asset(nextArrow),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            );
          },
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
