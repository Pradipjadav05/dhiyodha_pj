
import 'package:dhiyodha/model/request_model/add_testimonial_request_model.dart';
import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/testimonial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTestimonialPage extends StatefulWidget {
  MembersChildData membersChildData;

  AddTestimonialPageState createState() => AddTestimonialPageState();

  AddTestimonialPage({required this.membersChildData});
}

class AddTestimonialPageState extends State<AddTestimonialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text(
          "give_testimonial".tr,
          style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<TestimonialViewModel>(
            builder: (testVM) {
              return Padding(
                padding: const EdgeInsets.all(paddingSize14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "testimonial".tr,
                      style: fontBold.copyWith(
                          color: midnightBlue, fontSize: fontSize18),
                    ),
                    SizedBox(height: paddingSize5),
                    Divider(),
                    SizedBox(height: paddingSize15),
                    Row(
                      children: [
                        Text(
                          "* ",
                          style: fontBold.copyWith(
                              color: requiredField, fontSize: fontSize12),
                        ),
                        Text(
                          "required_field".tr,
                          style: fontRegular.copyWith(
                              color: greyText, fontSize: fontSize12),
                        )
                      ],
                    ),
                    SizedBox(height: paddingSize15),
                    CommonTextFormField(
                      controller: testVM.testimonialController,
                      bgColor: lavenderMist,
                      maxLines: 5,
                      hintText: "add_testimonial".tr,
                      textStyle: fontRegular.copyWith(
                          color: midnightBlue, fontSize: fontSize12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize40),
                    ),
                    SizedBox(height: paddingSize55),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            fontSize: fontSize14,
                            buttonText: "submit".tr,
                            bgColor: midnightBlue,
                            textColor: periwinkle,
                            onPressed: () async {
                              if (testVM.testimonialController.text.isEmpty) {
                                showSnackBar("please_add_testimonial".tr);
                              } else {
                                List<Roles> _roleList = [];
                                _roleList.add(new Roles(
                                  uuid: globalCurrentUserData
                                      .currentUserRoles?[0].uuid,
                                  roleName: globalCurrentUserData
                                      .currentUserRoles?[0].roleName,
                                  createdAt: globalCurrentUserData
                                      .currentUserRoles?[0].createdAt,
                                  createdBy: globalCurrentUserData
                                      .currentUserRoles?[0].createdBy,
                                ));
                                bool isSuccess = await testVM.addTestimonial(
                                    new AddTestimonialRequestModel(
                                        review: testVM
                                            .testimonialController.text
                                            .trim(),
                                        type: "INSIDE",
                                        reviewerUuid: widget.membersChildData.uuid,
                                    ));
                                if (isSuccess) {
                                  Get.back(result: true);
                                  showSnackBar("testimonial_added".tr,
                                      isError: false);
                                } else {
                                  showSnackBar('errorMessage'.tr);
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(width: paddingSize15),
                        Expanded(
                          child: CommonButton(
                            fontSize: fontSize14,
                            buttonText: "close".tr,
                            bgColor: lavenderMist,
                            textColor: bluishPurple,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
