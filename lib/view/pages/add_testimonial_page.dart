
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "give_testimonial".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: SingleChildScrollView(
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
                                        uuid: widget.membersChildData.uuid,
                                        review: testVM
                                            .testimonialController.text
                                            .trim(),
                                        type: "INSIDE",
                                        reviewer: new Reviewer(
                                          firstName:
                                              globalCurrentUserData.firstName ??
                                                  "",
                                          lastName:
                                              globalCurrentUserData.lastName ??
                                                  "",
                                          dob: globalCurrentUserData.dob ?? "",
                                          countryCode: globalCurrentUserData
                                                  .countryCode ??
                                              "",
                                          mobileNo:
                                              globalCurrentUserData.mobileNo ??
                                                  "",
                                          uploadDocumentId:
                                              globalCurrentUserData
                                                      .uploadDocumentId ??
                                                  "",
                                          education:
                                              globalCurrentUserData.education ??
                                                  "",
                                          children:
                                              globalCurrentUserData.children ??
                                                  0,
                                          pet: globalCurrentUserData.pet ?? "",
                                          hobbiesAndInterest:
                                              globalCurrentUserData
                                                      .hobbiesAndInterest ??
                                                  "",
                                          cityResidingYears:
                                              globalCurrentUserData
                                                      .cityResidingYears ??
                                                  0,
                                          burningDesire: globalCurrentUserData
                                                  .burningDesire ??
                                              "",
                                          somethingNoOneKnowsAboutMe:
                                              globalCurrentUserData
                                                      .somethingNoOneKnowsAboutMe ??
                                                  "",
                                          keyToSuccess: globalCurrentUserData
                                                  .keyToSuccess ??
                                              "",
                                          maritalStatus: globalCurrentUserData
                                                  .maritalStatus ??
                                              "",
                                          companyDetailsRequest:
                                              CompanyDetailsRequest(
                                                  uuid: globalCurrentUserData.uuid ??
                                                      "",
                                                  companyName: globalCurrentUserData
                                                          .currentUserOrganization
                                                          ?.companyName ??
                                                      "",
                                                  companyEstablishment: globalCurrentUserData
                                                          ?.currentUserOrganization
                                                          ?.companyEstablishment ??
                                                      "",
                                                  companyAddress: globalCurrentUserData
                                                          .currentUserOrganization
                                                          ?.companyAddress ??
                                                      "",
                                                  registeredType: "",
                                                  //pending
                                                  numberOfEmployees: globalCurrentUserData
                                                      .currentUserOrganization
                                                      ?.numberOfEmployees,
                                                  yearlyTurnover: globalCurrentUserData
                                                          .currentUserOrganization
                                                          ?.yearlyTurnover ??
                                                      "",
                                                  companyEmail: "",
                                                  //pending
                                                  companyContact: globalCurrentUserData
                                                          .currentUserOrganization
                                                          ?.companyContact ??
                                                      "",
                                                  businessCategory: globalCurrentUserData.currentUserOrganization?.businessCategory ?? "",
                                                  businessDescription: globalCurrentUserData?.currentUserOrganization?.businessDescription ?? "",
                                                  yearlyProfit: globalCurrentUserData.currentUserOrganization?.yearlyProfit ?? 0.0,
                                                  gstNumber: globalCurrentUserData.currentUserOrganization?.gstNumber ?? "",
                                                  uploadGst: globalCurrentUserData.currentUserOrganization?.uploadGst ?? "",
                                                  panNumber: globalCurrentUserData.currentUserOrganization?.panNumber ?? "",
                                                  uploadPan: globalCurrentUserData.currentUserOrganization?.uploadPan ?? ""),
                                          addressRequest: AddressRequest(
                                            city: globalCurrentUserData
                                                    .currentUserAddress?.city ??
                                                "",
                                            state: globalCurrentUserData
                                                    .currentUserAddress
                                                    ?.state ??
                                                "",
                                            country: globalCurrentUserData
                                                    .currentUserAddress
                                                    ?.country ??
                                                "",
                                            pinCode: globalCurrentUserData
                                                    .currentUserAddress
                                                    ?.pinCode ??
                                                "",
                                          ),
                                        ),
                                        reviewerFirstName:
                                            globalCurrentUserData.firstName,
                                        reviewerLastName:
                                            globalCurrentUserData.lastName,
                                        reviewerPofileUrl:
                                            globalCurrentUserData.profileUrl));
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
