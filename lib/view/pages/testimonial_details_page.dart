import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/my_testimonial_response_model.dart';
import 'package:dhiyodha/utils/helper/date_converter.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/testimonial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestimonialDetailsPage extends StatefulWidget {
  MyTestimonialChildData myTestimonialChildData;

  TestimonialDetailsPageState createState() => TestimonialDetailsPageState();

  TestimonialDetailsPage({required this.myTestimonialChildData});
}

class TestimonialDetailsPageState extends State<TestimonialDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("testimonials_details".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<TestimonialViewModel>(
          builder: (testimonialVM) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              '${widget.myTestimonialChildData.reviewerPofileUrl}',
                          width: 42.0,
                          height: 42.0,
                        ),
                        SizedBox(width: paddingSize10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.myTestimonialChildData.reviewerFirstName} ${widget.myTestimonialChildData.reviewerLastName}',
                              style: fontBold.copyWith(
                                  fontSize: fontSize18, color: midnightBlue),
                            ),
                            Text(
                              '${DateConverter.convertDateToDate(widget.myTestimonialChildData.reviewer?.createdAt ?? DateTime.now().toString())}\n${DateConverter.convertDateToDate(widget.myTestimonialChildData.reviewer?.updatedAt ?? DateTime.now().toString())}',
                              style: fontMedium.copyWith(
                                  fontSize: fontSize12, color: greyText),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: paddingSize8),
                  Divider(
                    thickness: 0.5,
                  ),
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    isEnabled: false,
                    padding: EdgeInsets.all(20.0),
                    maxLines: 9,
                    hintText: '${widget.myTestimonialChildData.review}',
                    hintColor: bluishPurple,
                    textStyle: fontRegular.copyWith(
                        color: bluishPurple, fontSize: fontSize12),
                  ),
                  SizedBox(height: paddingSize25),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     GFCheckbox(
                  //       inactiveBgColor: lavenderMist,
                  //       inactiveBorderColor: bluishPurple,
                  //       activeBorderColor: bluishPurple,
                  //       value: true,
                  //       // value: loginVM.isAgreeTerms.value,
                  //       activeBgColor: bluishPurple,
                  //       size: 24.0,
                  //       onChanged: (value) {
                  //         // loginVM.isAgreeTerms.value = value;
                  //       },
                  //     ),
                  //     Text(
                  //       "display_testimonials_profile".tr,
                  //       style: fontRegular.copyWith(
                  //           color: midnightBlue, fontSize: fontSize12),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: paddingSize20, horizontal: paddingSize10),
                    decoration: BoxDecoration(
                        color: lavenderMist,
                        borderRadius: BorderRadius.circular(radius10)),
                    padding: EdgeInsets.all(paddingSize10),
                    child: InkWell(
                      onTap: () async {
                        await _showDeleteDialog(
                            testimonialVM, widget.myTestimonialChildData);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            delete,
                            width: iconSize18,
                            height: iconSize18,
                          ),
                          SizedBox(width: paddingSize10),
                          Text(
                            "delete_testimonials".tr,
                            style: fontMedium.copyWith(
                                color: bluishPurple, fontSize: fontSize14),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    ));
  }

  Future<void> _showDeleteDialog(TestimonialViewModel testimonialVM,
      MyTestimonialChildData myTestimonialChildData) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "delete_testimonials".tr,
                      style: fontBold.copyWith(
                          color: midnightBlue, fontSize: fontSize18),
                    ),
                    SizedBox(
                      height: paddingSize25,
                    ),
                    Text("delete_testimonials_msg".tr,
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
                              Get.back();
                              bool isDelete =
                                  await testimonialVM.deleteTestimonial(
                                      myTestimonialChildData.id);
                              if (isDelete) {
                                Get.back(result: true);
                                /*showSnackBar("testimonials_deleted".tr,
                                    isError: false);*/
                              } else {
                                showSnackBar('errorMessage'.tr);
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
}
