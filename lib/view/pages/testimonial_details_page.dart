import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/model/response_model/my_testimonial_response_model.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
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
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("testimonials_details".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<TestimonialViewModel>(
            builder: (testimonialVM) {
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _profileAvatar(
                                widget.myTestimonialChildData.reviewerPofileUrl,
                                size: 68),
                            SizedBox(width: paddingSize10),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name
                                  Text(
                                    '${widget.myTestimonialChildData.reviewerFirstName ?? ''} ${widget.myTestimonialChildData.reviewerLastName ?? ''}'
                                        .trim(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: fontBold.copyWith(
                                      fontSize: fontSize22,
                                      color: ghostWhite,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
        
                                  const SizedBox(height: 6),
        
                                  // Type + Company
                                  if (widget.myTestimonialChildData.type != null)
                                    _MetaRow(
                                      icon: Icons.work_outline_rounded,
                                      label: widget.myTestimonialChildData.type!,
                                    ),
        
                                  const SizedBox(height: 5),
        
                                  // Phone
                                  if (widget.myTestimonialChildData.number !=
                                      null)
                                    _MetaRow(
                                      icon: Icons.phone_outlined,
                                      label:
                                          '${widget.myTestimonialChildData.number}',
                                    ),
        
                                  const SizedBox(height: 5),
        
                                  // Date
                                  if (widget.myTestimonialChildData.date != null)
                                    _MetaRow(
                                      icon: Icons.calendar_today_outlined,
                                      label:
                                          '${widget.myTestimonialChildData.date}',
                                    ),
        
                                  // Type + Company
                                  if (widget.myTestimonialChildData.companyName !=
                                      null)
                                    _MetaRow(
                                      icon: Icons.business_outlined,
                                      label: widget
                                          .myTestimonialChildData.companyName!,
                                    ),
        
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                      hintText: '${widget.myTestimonialChildData.review ?? ""}',
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
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEDED),
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: const Color(0xFFFFCCCC), width: 1),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await _showDeleteDialog(
                              testimonialVM, widget.myTestimonialChildData);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              delete,
                              width: iconSize18,
                              height: iconSize18,
                              color: Color(0xFFD94040),
                            ),
                            SizedBox(width: paddingSize10),
                            Text(
                              "delete_testimonials".tr,
                              style: fontMedium.copyWith(
                                  color: const Color(0xFFD94040),
                                  fontSize: fontSize14),
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
      ),
    );
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
                              bool isDelete = await testimonialVM
                                  .deleteTestimonial(myTestimonialChildData.id);
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

Widget _profileAvatar(String? profileUrl, {double size = 42}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2.5),
      boxShadow: [
        BoxShadow(
          color: midnightBlue.withOpacity(0.15),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ClipOval(
      child: profileUrl != null && profileUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: profileUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => _avatarFallback(),
            )
          : _avatarFallback(),
    ),
  );
}

Widget _avatarFallback() {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [midnightBlue, const Color(0xFF4A6FA5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: ClipOval(
      child: Icon(Icons.person, color: Colors.white),
    ),
  );
}

// ─────────────────────────────────────────────
// Meta Row Helper
// ─────────────────────────────────────────────
class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaRow({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 13, color: white.withValues(alpha: 0.85)),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: fontMedium.copyWith(
                fontSize: fontSize12, color: white.withValues(alpha: 0.85)),
          ),
        ),
      ],
    );
  }
}
