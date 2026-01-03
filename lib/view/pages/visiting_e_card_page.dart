import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/model/response_model/visitor_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/visiting_card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class VisitingECardPage extends StatefulWidget {
  CurrentUserData? currentUserData;
  VisitorChildData? visitorChildData;

  VisitingECardPageState createState() => VisitingECardPageState();

  VisitingECardPage({this.currentUserData, this.visitorChildData});
}

class VisitingECardPageState extends State<VisitingECardPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await Get.find<VisitingCardViewModel>().initData();
    if (widget.currentUserData != null) {
      Get.find<VisitingCardViewModel>().currentUserData =
          widget.currentUserData!;
    } else if (widget.visitorChildData != null) {
      Get.find<VisitingCardViewModel>().visitorData = widget.visitorChildData!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text(
          "v_card".tr,
          style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
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
        child: GetBuilder<VisitingCardViewModel>(
          builder: (vvm) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Obx(
                () => Column(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: paddingSize15, horizontal: paddingSize15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              profileImage,
                              height: 68.0,
                              width: 68.0,
                            ),
                            SizedBox(width: paddingSize15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.currentUserData?.firstName ?? widget.visitorChildData?.name} \n${widget.currentUserData?.lastName ?? ""}',
                                  overflow: TextOverflow.fade,
                                  style: fontBold.copyWith(
                                      fontSize: fontSize22, color: ghostWhite),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //
                                //     SizedBox(width: 4.0),
                                //     Image.asset(live),
                                //   ],
                                // ),
                                // Text(
                                //   "Alphabit Infoway",
                                //   style: fontRegular.copyWith(
                                //       fontSize: fontSize14, color: lavenderMist),
                                // ),
                                // Text(
                                //   "BNI Utsav",
                                //   style: fontRegular.copyWith(
                                //       fontSize: fontSize12, color: periwinkle),
                                // ),
                                // Text(
                                //   "Due date : 30/01/2024",
                                //   style: fontRegular.copyWith(
                                //       fontSize: fontSize12, color: periwinkle),
                                // ),
                                // Text(
                                //   "Classification : Digital Marketing",
                                //   style: fontRegular.copyWith(
                                //       fontSize: fontSize12, color: periwinkle),
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: paddingSize20),
                    CommonCard(
                      radius: radius15,
                      elevation: 0.0,
                      bgColor: lavenderMist,
                      cardChild: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: paddingSize20, horizontal: paddingSize25),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize20,
                                  vertical: paddingSize15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(contact,
                                          height: iconSize18,
                                          width: iconSize18),
                                      SizedBox(width: paddingSize5),
                                      Text(
                                        "contact_number".tr,
                                        style: fontRegular.copyWith(
                                            fontSize: fontSize12,
                                            color: midnightBlue),
                                      ),
                                    ],
                                  ),
                                  CommonTextFormField(
                                    isEnabled: vvm.isEditData.value,
                                    inputType: TextInputType.number,
                                    maxLength: 10,
                                    controller: vvm.contactController,
                                    textStyle: fontMedium.copyWith(
                                        fontSize: fontSize14,
                                        color: midnightBlue),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize20,
                                  vertical: paddingSize15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(company,
                                          height: iconSize18,
                                          width: iconSize18),
                                      SizedBox(width: paddingSize5),
                                      Text(
                                        "company_name".tr,
                                        style: fontRegular.copyWith(
                                            fontSize: fontSize12,
                                            color: midnightBlue),
                                      ),
                                    ],
                                  ),
                                  CommonTextFormField(
                                    isEnabled: vvm.isEditData.value,
                                    controller: vvm.companyNameController,
                                    textStyle: fontMedium.copyWith(
                                        fontSize: fontSize14,
                                        color: midnightBlue),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize20,
                                  vertical: paddingSize15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(businessCat,
                                          height: iconSize18,
                                          width: iconSize18),
                                      SizedBox(width: paddingSize5),
                                      Text(
                                        "designation".tr,
                                        style: fontRegular.copyWith(
                                            fontSize: fontSize12,
                                            color: midnightBlue),
                                      ),
                                    ],
                                  ),
                                  CommonTextFormField(
                                    isEnabled: vvm.isEditData.value,
                                    controller: vvm.designationController,
                                    textStyle: fontMedium.copyWith(
                                        fontSize: fontSize14,
                                        color: midnightBlue),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize20,
                                  vertical: paddingSize15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(businessCat,
                                          height: iconSize18,
                                          width: iconSize18),
                                      SizedBox(width: paddingSize5),
                                      Text(
                                        "business_category".tr,
                                        style: fontRegular.copyWith(
                                            fontSize: fontSize12,
                                            color: midnightBlue),
                                      ),
                                    ],
                                  ),
                                  CommonTextFormField(
                                    isEnabled: vvm.isEditData.value,
                                    controller: vvm.businessCategoryController,
                                    textStyle: fontMedium.copyWith(
                                        fontSize: fontSize14,
                                        color: midnightBlue),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: paddingSize20,
                                    vertical: paddingSize15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(location,
                                            height: iconSize18,
                                            width: iconSize18),
                                        SizedBox(width: paddingSize5),
                                        Text(
                                          "location".tr,
                                          style: fontRegular.copyWith(
                                              fontSize: fontSize12,
                                              color: midnightBlue),
                                        ),
                                      ],
                                    ),
                                    CommonTextFormField(
                                      isEnabled: vvm.isEditData.value,
                                      controller: vvm.locationController,
                                      textStyle: fontMedium.copyWith(
                                          fontSize: fontSize14,
                                          color: midnightBlue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: paddingSize25),
                    Visibility(
                      visible: !vvm.isVisitorData.value,
                      child: Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              icon: share,
                              buttonText: "share".tr,
                              bgColor: midnightBlue,
                              iconColor: white,
                              textColor: periwinkle,
                              onPressed: () async {
                                String data =
                                    '${widget.currentUserData?.firstName} ${widget.currentUserData?.lastName} \n${widget.currentUserData?.mobileNo} \n${widget.currentUserData?.currentUserOrganization?.companyName} \n${widget.currentUserData?.currentUserOrganization?.businessCategory}';
                                String msg = "checkout_profile".tr;
                                String shareString =
                                    "$msg \n\n$data \n\n Download Now : $playStoreUrl";
                                await Share.share(shareString);
                              },
                            ),
                          ),
                          SizedBox(width: paddingSize15),
                          Expanded(
                            child: CommonButton(
                              icon: edit,
                              buttonText: "edit".tr,
                              iconColor: bluishPurple,
                              bgColor: lavenderMist,
                              textColor: bluishPurple,
                              onPressed: () async {
                                vvm.isEditData.value = true;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: paddingSize15),
                    Visibility(
                      visible: vvm.isEditData.value,
                      child: CommonButton(
                        buttonText: "submit".tr,
                        iconColor: bluishPurple,
                        bgColor: bluishPurple,
                        textColor: lavenderMist,
                        onPressed: () async {
                          await updateUserProfile(vvm);
                        },
                      ),
                    ),
                  ],
                ),
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

  Future<void> updateUserProfile(VisitingCardViewModel vvm) async {
    if (vvm.contactController.text.isEmpty ||
        vvm.contactController.text.length < 10) {
      showSnackBar("valid_number".tr);
    } else if (vvm.companyNameController.text.isEmpty) {
      showSnackBar("enter_cmp_name".tr);
    } else if (vvm.designationController.text.isEmpty) {
      showSnackBar("enter_designation".tr);
    } else if (vvm.businessCategoryController.text.isEmpty) {
      showSnackBar("enter_business_category".tr);
    } else if (vvm.locationController.text.isEmpty) {
      showSnackBar("enter_location".tr);
    } else {
      UpdateProfileRequestModel userProfileRequestModel =
          new UpdateProfileRequestModel(
        firstName: vvm.currentUserData.firstName ?? "",
        lastName: vvm.currentUserData.lastName ?? "",
        dob: vvm.currentUserData.dob ?? "",
        countryCode: vvm.currentUserData.countryCode ?? "",
        mobileNo:
            vvm.contactController.text ?? vvm.currentUserData.mobileNo ?? "",
        uploadDocumentId: vvm.currentUserData.uploadDocumentId ?? "",
        education: vvm.currentUserData.education ?? "",
        children: vvm.currentUserData.children ?? 0,
        pet: vvm.currentUserData.pet ?? "",
        hobbiesAndInterest: vvm.currentUserData.hobbiesAndInterest ?? "",
        cityResidingYears: vvm.currentUserData.cityResidingYears ?? 0,
        burningDesire: vvm.currentUserData.burningDesire ?? "",
        somethingNoOneKnowsAboutMe:
            vvm.currentUserData.somethingNoOneKnowsAboutMe ?? "",
        keyToSuccess: vvm.currentUserData.keyToSuccess ?? "",
        residentAddress: vvm.currentUserData.permanentAddress ?? "",
        permanentAddress: vvm.currentUserData.permanentAddress ?? "",
        maritalStatus: vvm.currentUserData.maritalStatus ?? "",
        previousTypesOfJobs: vvm.currentUserData.previousTypesOfJobs ?? "",
        partner: vvm.currentUserData.partner ?? "",
        businessDetailsResponse: CompanyDetailsRequest(
            uuid: vvm.currentUserData.uuid ?? "",
            companyName: vvm.companyNameController.text ??
                vvm.currentUserData?.currentUserOrganization?.companyName ??
                "",
            companyEstablishment:
                vvm.currentUserData?.currentUserOrganization?.companyEstablishment ??
                    "",
            companyAddress:
                vvm.currentUserData?.currentUserOrganization?.companyAddress ??
                    "",
            registeredType:
                widget.currentUserData?.currentUserOrganization?.registeredType ??
                    "",
            numberOfEmployees:
                vvm.currentUserData?.currentUserOrganization?.numberOfEmployees,
            yearlyTurnover:
                vvm.currentUserData?.currentUserOrganization?.yearlyTurnover ??
                    "",
            companyEmail:
                widget.currentUserData?.currentUserOrganization?.companyEmail ??
                    "",
            companyWebsite:
                widget.currentUserData?.currentUserOrganization?.companyWebsite ??
                    "",
            designation: vvm.designationController.text ??
                widget.currentUserData?.currentUserOrganization?.designation ??
                "",
            companyContact:
                vvm.currentUserData?.currentUserOrganization?.companyContact ?? "",
            businessCategory: vvm.businessCategoryController.text ?? vvm.currentUserData?.currentUserOrganization?.businessCategory ?? "",
            businessDescription: vvm.currentUserData?.currentUserOrganization?.businessDescription ?? "",
            yearlyProfit: vvm.currentUserData?.currentUserOrganization?.yearlyProfit ?? 0.0,
            gstNumber: vvm.currentUserData?.currentUserOrganization?.gstNumber ?? "",
            uploadGst: vvm.currentUserData?.currentUserOrganization?.uploadGst ?? "",
            panNumber: vvm.currentUserData?.currentUserOrganization?.panNumber ?? "",
            uploadPan: vvm.currentUserData?.currentUserOrganization?.uploadPan ?? ""),
        addressRequest: AddressRequest(
          city: vvm.locationController.text ??
              vvm.currentUserData?.currentUserAddress?.city ??
              "",
          state: vvm.locationController.text ??
              vvm.currentUserData?.currentUserAddress?.state ??
              "",
          country: vvm.locationController.text ??
              vvm.currentUserData?.currentUserAddress?.country ??
              "",
          pinCode: vvm.currentUserData?.currentUserAddress?.pinCode ?? "",
        ),
      );
      bool resp = await vvm.updateProfile(userProfileRequestModel);
      if (resp) {
        Get.back(result: true, canPop: true, closeOverlays: true);
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }
}
