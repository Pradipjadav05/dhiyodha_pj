import 'dart:io';

import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/model/response_model/response_model.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/viewModel/posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostPage extends StatefulWidget {
  final CurrentUserData currentUserData;

  const AddPostPage({Key? key, required this.currentUserData}) : super(key: key);

  @override
  AddPostPageState createState() => AddPostPageState();
}

class AddPostPageState extends State<AddPostPage> {
  @override
  void initState() {
    super.initState();
    Get.find<PostsViewModel>().initData();
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
            'add_post'.tr,
            style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: GetBuilder<PostsViewModel>(
              builder: (postVM) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── User row ──
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(profileImage, width: 42.0, height: 42.0),
                        const SizedBox(width: paddingSize10),
                        Expanded(
                          child: Text(
                            '${widget.currentUserData.firstName} ${widget.currentUserData.lastName}',
                            style: fontMedium.copyWith(
                                fontSize: fontSize14, color: midnightBlue),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: paddingSize20),

                    // ── Region selection ──
                    Text(
                      'select_region'.tr,
                      style: fontMedium.copyWith(
                          color: bluishPurple, fontSize: fontSize14),
                    ),
                    const SizedBox(height: paddingSize5),

                    Obx(() => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          value: 1,
                          groupValue: postVM.selectedRegionVal.value,
                          onChanged: (int? value) {
                            postVM.setSelectedRegionVal(value!);
                            postVM.regionValue.value =
                                'Chapter'.toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          'chapter'.tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                      ],
                    )),

                    Obx(() => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          value: 2,
                          groupValue: postVM.selectedRegionVal.value,
                          onChanged: (int? value) {
                            postVM.setSelectedRegionVal(value!);
                            postVM.regionValue.value =
                                'City_region'.toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          'city'.tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        ),
                      ],
                    )),

                    const SizedBox(height: paddingSize20),

                    // ── Content box: TextField on top + Image below ──
                    _buildContentBox(postVM),

                    const SizedBox(height: paddingSize20),

                    // ── Photo picker row ──
                    InkWell(
                      onTap: () async {
                        await _showImageSelectionDialog(postVM);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            postUpload,
                            height: iconSize24,
                            width: iconSize24,
                          ),
                          const SizedBox(width: paddingSize10),
                          Text(
                            'photo'.tr,
                            style: fontBold.copyWith(
                                fontSize: fontSize14, color: midnightBlue),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── Upload button ──
                    postVM.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CommonButton(
                      buttonText: 'upload'.tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        if (postVM.contentController.text.trim().isEmpty) {
                          showSnackBar('enter_post_content'.tr);
                        } else {
                          ResponseModel resp = await postVM.addPost(
                            postVM.contentController.text,
                            postVM.regionValue.value,
                            true,
                          );
                          if (resp.isSuccess) {
                            showSnackBar(resp.message, isError: false);
                            Get.back(
                                result: true,
                                canPop: true,
                                closeOverlays: true);
                          } else {
                            showSnackBar('errorMessage'.tr);
                          }
                        }
                      },
                    ),

                    const SizedBox(height: paddingSize20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Content box — multiline TextField at top, image preview below
  // Matches design: text flows above the selected image inside
  // a single rounded white card.
  // ────────────────────────────────────────────────────────────
  Widget _buildContentBox(PostsViewModel postVM) {
    final bool hasImage = postVM.postImageFile != null &&
        postVM.isImageUploadSuccess.isTrue;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: white,
        // borderRadius: BorderRadius.circular(radius10),
        // border: Border.all(color: greyText.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Multiline TextField ──
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: TextField(
              controller: postVM.contentController,
              minLines: 1,
              maxLines: null, // grows with content, no scroll cap
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: fontMedium.copyWith(
                  fontSize: fontSize14, color: midnightBlue),
              decoration: InputDecoration(
                hintText: 'say_something_photo'.tr,
                hintStyle: fontRegular.copyWith(
                    fontSize: fontSize14, color: greyText),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // ── Selected image preview below text ──
          if (hasImage) ...[
            Divider(
              height: 1,
              thickness: 1,
              color: greyText.withOpacity(0.15),
            ),
            // Image fills width, rounded bottom corners
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(radius10),
                topRight: Radius.circular(radius10),
                bottomLeft: Radius.circular(radius10),
                bottomRight: Radius.circular(radius10),
              ),
              child: Image.file(
                File(postVM.postImageFile!.path),
                width: double.infinity,
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Image source dialog ──
  Future<void> _showImageSelectionDialog(PostsViewModel postVM) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius10)),
          elevation: 0,
          child: Container(
            height: Get.width * 0.6,
            decoration: BoxDecoration(
              color: lavenderMist,
              borderRadius: BorderRadius.circular(radius10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'select_image_source'.tr,
                    style: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize16),
                  ),
                ),
                const Divider(color: midnightBlue),
                _dialogOption(
                  assetPath: postUpload,
                  assetColor: null,
                  label: 'gallery'.tr,
                  onTap: () async {
                    Get.back();
                    await postVM.pickImage('SOCIAL_IMAGE');
                  },
                ),
                _dialogOption(
                  assetPath: camera,
                  assetColor: bluishPurple,
                  label: 'camera'.tr,
                  onTap: () async {
                    Get.back();
                    await postVM.clickCameraImage('SOCIAL_IMAGE');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dialogOption({
    required String assetPath,
    required String label,
    required VoidCallback onTap,
    Color? assetColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 14.0),
          decoration: BoxDecoration(
            border: Border.all(color: midnightBlue),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Image.asset(assetPath,
                  color: assetColor, width: iconSize24, height: iconSize24),
              const SizedBox(width: paddingSize10),
              Text(label,
                  style: fontBold.copyWith(
                      color: midnightBlue, fontSize: fontSize16)),
            ],
          ),
        ),
      ),
    );
  }
}