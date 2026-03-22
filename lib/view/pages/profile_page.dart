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
import 'package:dhiyodha/viewModel/home_viewmodel.dart';
import 'package:dhiyodha/viewModel/posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewModel/visiting_card_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  final CurrentUserData currentUserData;

  const ProfilePage({Key? key, required this.currentUserData}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  // ── Use Rx so the UI reacts to changes without full rebuild ──
  late final Rx<CurrentUserData> _currentUserData;

  @override
  void initState() {
    super.initState();
    _currentUserData = widget.currentUserData.obs;
    Get.find<PostsViewModel>().initData();
  }

  // ────────────────────────────────────────────────────────────
  // FIX: Fetch fresh data directly from HomeViewModel API,
  // not from VisitingCardViewModel which may have been reset.
  // Called after returning from any page that can mutate user data.
  // ────────────────────────────────────────────────────────────
  Future<void> _refreshUserData() async {
    try {
      final CurrentUserData fresh =
      await Get.find<HomeViewModel>().getCurrentUser();
      _currentUserData.value = fresh;

      // Also sync into VisitingCardViewModel so E-Card page
      // picks up the latest data next time it opens
      Get.find<VisitingCardViewModel>().currentUserData = fresh;
    } catch (e) {
      debugPrint('Error refreshing user data: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            'profile'.tr,
            style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          menuWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                Get.toNamed(Routes.getWebViewPageRoute(queryWebUrl));
              },
              child: Image.asset(query, width: 24.0),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<PostsViewModel>(
            builder: (postVM) {
              // ── Obx watches _currentUserData.value reactively ──
              return Obx(() {
                final CurrentUserData user = _currentUserData.value;

                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Profile header banner ──
                      _buildProfileHeader(context, postVM, user),

                      const SizedBox(height: paddingSize20),

                      // ── Share profile card ──
                      CommonCard(
                        elevation: 0.0,
                        bgColor: lavenderMist,
                        onTap: () async {
                          final result = await Get.toNamed(
                            Routes.getVisitingCardPageRoute(
                                currentUserData: user),
                          );
                          // Refresh if E-Card was edited
                          if (result == true) {
                            await _refreshUserData();
                          }
                        },
                        cardChild: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: paddingSize20,
                              horizontal: paddingSize25),
                          child: Row(
                            children: [
                              Text(
                                'share_profile'.tr,
                                style: fontRegular.copyWith(
                                    color: midnightBlue, fontSize: fontSize16),
                              ),
                              const Spacer(),
                              Image.asset(nextArrow,
                                  height: iconSize18, width: iconSize18),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: paddingSize20),

                      // ── My Bio card ──
                      CommonCard(
                        onTap: () async {
                          final result = await Get.toNamed(
                            Routes.getMyBioPageRoute(user),
                          );
                          if (result == true) {
                            await _refreshUserData();
                          }
                        },
                        elevation: 0.0,
                        bgColor: lavenderMist,
                        cardChild: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: paddingSize20,
                              horizontal: paddingSize25),
                          child: Row(
                            children: [
                              Text(
                                'my_bio'.tr,
                                style: fontRegular.copyWith(
                                    color: midnightBlue, fontSize: fontSize16),
                              ),
                              const Spacer(),
                              Image.asset(nextArrow,
                                  height: iconSize18, width: iconSize18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Profile header banner
  // ────────────────────────────────────────────────────────────
  Widget _buildProfileHeader(
      BuildContext context,
      PostsViewModel postVM,
      CurrentUserData user,
      ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius10),
        image: DecorationImage(
          image: AssetImage(profileBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: paddingSize30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Avatar with camera overlay ──
            InkWell(
              onTap: () async {
                await postVM.pickImage('FACE_IMAGE');
                await _refreshUserData();
              },
              child: Stack(
                children: [
                  ClipOval(
                    child: postVM.postImageFile != null
                        ? Image.file(
                      File(postVM.postImageFile!.path),
                      height: 68.0,
                      width: 68.0,
                      fit: BoxFit.cover,
                    )
                        : (user.profileUrl != null &&
                        user.profileUrl!.isNotEmpty)
                        ? CachedNetworkImage(
                      imageUrl: user.profileUrl!,
                      height: 68.0,
                      width: 68.0,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        height: 68,
                        width: 68,
                        child: Center(
                          child: CircularProgressIndicator(
                              strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
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
                  ),
                  Positioned(
                    left: 44,
                    top: 42,
                    child: Image.asset(roundCamera, height: 24, width: 24),
                  ),
                ],
              ),
            ),

            // ── Name + company + category ──
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
                      style: fontBold.copyWith(
                          fontSize: fontSize22, color: ghostWhite),
                    ),
                    const SizedBox(width: 4.0),
                    Image.asset(live),
                  ],
                ),
                Text(
                  user.currentUserOrganization?.companyName ?? '',
                  style: fontRegular.copyWith(
                      fontSize: fontSize14, color: lavenderMist),
                ),
                const SizedBox(height: 4.0),
                Text(
                  user.currentUserOrganization?.businessCategory ?? '',
                  style: fontRegular.copyWith(
                      fontSize: fontSize12, color: periwinkle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}