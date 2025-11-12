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
import 'package:dhiyodha/view/widgets/markdown_editor_plus/widgets/markdown_auto_preview.dart';
import 'package:dhiyodha/viewModel/posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostPage extends StatefulWidget {
  CurrentUserData currentUserData;

  AddPostPageState createState() => AddPostPageState();

  AddPostPage({
    required this.currentUserData,
  });
}

class AddPostPageState extends State<AddPostPage> {
  @override
  void initState() {
    super.initState();
    Get.find<PostsViewModel>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("add_post".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GetBuilder<PostsViewModel>(
            builder: (postVM) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        profileImage,
                        width: 42.0,
                        height: 42.0,
                      ),
                      SizedBox(width: paddingSize10),
                      Expanded(
                        child: Text(
                          '${widget.currentUserData.firstName} ${widget.currentUserData.lastName}',
                          style: fontMedium.copyWith(
                              fontSize: fontSize14, color: midnightBlue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: paddingSize25),
                  Text(
                    "select_region".tr,
                    style: fontMedium.copyWith(
                        color: bluishPurple, fontSize: fontSize14),
                  ),
                  SizedBox(height: paddingSize5),
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: 1,
                          groupValue: postVM.selectedRegionVal.value,
                          onChanged: (int? value) {
                            postVM.setSelectedRegionVal(value!);
                            postVM.regionValue.value = "Chapter".toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          "chapter".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => Row(
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
                                "City_region".toUpperCase();
                          },
                          activeColor: bluishPurple,
                        ),
                        Text(
                          "city".tr,
                          style: fontBold.copyWith(
                              color: midnightBlue, fontSize: fontSize14),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: paddingSize20),
                  MarkDownWidget(
                      postVM.contentController,
                      "say_something_photo".tr,
                      fontMedium.copyWith(
                          color: greyText, fontSize: fontSize14),
                      greyText),

                  // CommonTextFormField(
                  //   controller: postVM.contentController,
                  //   bgColor: Colors.transparent,
                  //   padding: EdgeInsets.all(paddingSize8),
                  //   hintText: "say_something_photo".tr,
                  //   hintColor: greyText,
                  //   textStyle: fontMedium.copyWith(
                  //       color: greyText, fontSize: fontSize14),
                  // ),

                  SizedBox(height: paddingSize25),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(radius10)),
                    child: postVM.postImageFile == null &&
                            postVM.isImageUploadSuccess.isFalse
                        ? Container()
                        : Image.file(
                            height: 250.0,
                            width: double.infinity,
                            File(postVM.postImageFile!.path),
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                  SizedBox(height: paddingSize25),
                  Row(
                    children: [
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
                            SizedBox(
                              width: paddingSize20,
                            ),
                            Text(
                              "photo".tr,
                              style: fontBold.copyWith(
                                  fontSize: fontSize14, color: midnightBlue),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      // InkWell(
                      //   child: Row(
                      //     children: [
                      //       Image.asset(
                      //         feelings,
                      //         height: iconSize24,
                      //         width: iconSize24,
                      //       ),
                      //       SizedBox(
                      //         width: paddingSize20,
                      //       ),
                      //       Text(
                      //         "Feeling/Activity",
                      //         style: fontBold.copyWith(
                      //             fontSize: fontSize14, color: midnightBlue),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  // SizedBox(height: paddingSize25),
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       child: Row(
                  //         children: [
                  //           Image.asset(
                  //             tagPeople,
                  //             height: iconSize24,
                  //             width: iconSize24,
                  //           ),
                  //           SizedBox(
                  //             width: paddingSize20,
                  //           ),
                  //           Text(
                  //             "Tag People",
                  //             style: fontBold.copyWith(
                  //                 fontSize: fontSize14, color: midnightBlue),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Spacer(),
                  //     InkWell(
                  //       child: Row(
                  //         children: [
                  //           Image.asset(
                  //             postUpload,
                  //             height: iconSize24,
                  //             width: iconSize24,
                  //           ),
                  //           SizedBox(
                  //             width: paddingSize20,
                  //           ),
                  //           Text(
                  //             "Photo",
                  //             style: fontBold.copyWith(
                  //                 fontSize: fontSize14, color: midnightBlue),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "upload".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () async {
                      if (postVM.contentController.text.isEmpty) {
                        showSnackBar("enter_post_content".tr);
                      } else {
                        ResponseModel resp = await postVM.addPost(
                            postVM.contentController.text.contains("hashtag")
                                ? postVM.contentController.text
                                    .replaceAll("hashtag", "")
                                : postVM.contentController.text,
                            postVM.regionValue.value,
                            true);
                        if (resp.isSuccess) {
                          showSnackBar(resp.message, isError: false);
                          Get.back(
                              result: true, canPop: true, closeOverlays: true);
                        } else {
                          showSnackBar('errorMessage'.tr);
                        }
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    ));
  }

  MarkDownWidget(controllerMarkdown, hintText, textStyle, hintColor) {
    // _controllerMarkdown.text = q.description!;
    FocusNode focus = FocusNode();
    GlobalKey key = GlobalKey();
    MarkdownAutoPreview? markdown = MarkdownAutoPreview(
      key: key,
      controller: controllerMarkdown,
      onChanged: (value) {},
      emojiConvert: true,
      enableToolBar: true,
      expands: true,
      // maxLines: 6,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text(hintText, style: textStyle),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: Get.width,
            child: Focus(
              canRequestFocus: true,
              descendantsAreFocusable: true,
              descendantsAreTraversable: true,
              focusNode: focus,
              child: markdown,
            ),
          ),
        ],
      ),
    );
  }

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
              color: lavenderMist,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "select_image_source".tr,
                      style: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize16),
                    ),
                  ),
                  Divider(
                    color: midnightBlue,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 14.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: midnightBlue),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: InkWell(
                        child: Row(
                          children: [
                            Image.asset(
                              postUpload,
                              width: iconSize24,
                              height: iconSize24,
                            ),
                            SizedBox(
                              width: paddingSize10,
                            ),
                            Text("gallery".tr,
                                style: fontBold.copyWith(
                                    color: midnightBlue, fontSize: fontSize16)),
                          ],
                        ),
                        onTap: () async {
                          Get.back();
                          await postVM.pickImage("SOCIAL_IMAGE");
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 14.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: midnightBlue),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: InkWell(
                        child: Row(
                          children: [
                            Image.asset(
                              camera,
                              color: bluishPurple,
                              height: iconSize24,
                              width: iconSize24,
                            ),
                            SizedBox(
                              width: paddingSize10,
                            ),
                            Text("camera".tr,
                                style: fontBold.copyWith(
                                    color: midnightBlue, fontSize: fontSize16)),
                          ],
                        ),
                        onTap: () async {
                          Get.back();
                          await postVM.clickCameraImage("SOCIAL_IMAGE");
                        },
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
