import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/visiting_card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBioPage extends StatefulWidget {
  CurrentUserData currentUserData;

  MyBioPagePageState createState() => MyBioPagePageState();

  MyBioPage({required this.currentUserData});
}

class MyBioPagePageState extends State<MyBioPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    VisitingCardViewModel vvm = Get.find<VisitingCardViewModel>();
    await vvm.initData();
    vvm.currentUserData = widget.currentUserData;
    vvm.designationController.text =
        vvm.currentUserData.currentUserOrganization?.designation ?? "";
    vvm.contactController.text = vvm.currentUserData.mobileNo ?? "";
    vvm.companyNameController.text =
        vvm.currentUserData.currentUserOrganization?.companyName ?? "";
    vvm.businessCategoryController.text =
        vvm.currentUserData.currentUserOrganization?.businessCategory ?? "";
    vvm.locationController.text =
        vvm.currentUserData.currentUserAddress?.city ?? "";
    vvm.yearOfBusinessController.text =
        vvm.currentUserData.currentUserOrganization?.companyEstablishment ?? "";
    vvm.previousTypesOfJobsController.text =
        vvm.currentUserData.previousTypesOfJobs ?? "";
    vvm.partnerController.text = vvm.currentUserData.partner ?? "";
    vvm.childrenController.text = vvm.currentUserData.children.toString() ?? "";
    vvm.petsController.text = vvm.currentUserData.pet ?? "";
    vvm.hobbiesController.text = vvm.currentUserData.hobbiesAndInterest ?? "";
    vvm.cityResidenceController.text =
        vvm.currentUserData.currentUserAddress?.city?.toString() ?? "";
    vvm.yearInTheCityController.text =
        vvm.currentUserData.cityResidingYears.toString() ?? "";
    vvm.burningDesireController.text = vvm.currentUserData.burningDesire ?? "";
    vvm.knowAboutMeController.text =
        vvm.currentUserData.somethingNoOneKnowsAboutMe ?? "";
    vvm.keyToSuccessController.text = vvm.currentUserData.keyToSuccess ?? "";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text("my_bio".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color)),
        ),
        body: SingleChildScrollView(
          child: GetBuilder<VisitingCardViewModel>(
            builder: (vvm) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: paddingSize10, horizontal: paddingSize15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: paddingSize15),
                    Text(
                      "year_of_business".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.yearOfBusinessController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "year_of_business".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "prev_jobs".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.previousTypesOfJobsController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "prev_jobs".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "partner".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.partnerController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "partner".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "child".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.childrenController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "child".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "pets".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.petsController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "pets".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "hobby".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.hobbiesController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "hobby".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "city_residence".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.cityResidenceController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "city_residence".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "year_in_city".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.yearInTheCityController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "year_in_city".tr,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "burning_desire".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.burningDesireController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "burning_desire".tr,
                      maxLines: 3,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "know_about_me".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.knowAboutMeController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "know_about_me".tr,
                      maxLines: 4,
                    ),
                    SizedBox(height: paddingSize20),
                    Text(
                      "success_key".tr,
                      style: fontMedium.copyWith(
                          fontSize: fontSize14, color: bluishPurple),
                    ),
                    SizedBox(height: paddingSize8),
                    CommonTextFormField(
                      controller: vvm.keyToSuccessController,
                      bgColor: lavenderMist,
                      padding: const EdgeInsets.symmetric(
                          vertical: paddingSize15, horizontal: paddingSize15),
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      hintText: "success_key".tr,
                      maxLines: 4,
                    ),
                    SizedBox(height: paddingSize25),
                    CommonButton(
                      buttonText: "confirm".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        await collectDataAndSaveProfile(vvm);
                      },
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

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> collectDataAndSaveProfile(VisitingCardViewModel vvm) async {
    UpdateProfileRequestModel userProfileRequestModel =
        new UpdateProfileRequestModel(
      firstName: widget.currentUserData.firstName ?? "",
      lastName: widget.currentUserData.lastName ?? "",
      dob: widget.currentUserData.dob ?? "",
      countryCode: widget.currentUserData.countryCode ?? "",
      mobileNo: widget?.currentUserData?.mobileNo ?? "",
      uploadDocumentId: widget.currentUserData.uploadDocumentId ?? "",
      education: widget.currentUserData.education ?? "",
      children: int.parse(vvm.childrenController.text) ??
          widget.currentUserData.children ??
          0,
      pet: vvm.petsController.text ?? widget.currentUserData.pet ?? "",
      hobbiesAndInterest: vvm.hobbiesController.text ??
          widget.currentUserData.hobbiesAndInterest ??
          "",
      cityResidingYears: int.parse(vvm.yearInTheCityController.text) ?? 0,
      //int.parse(vvm.cityResidenceController.text) ??
      burningDesire: vvm.burningDesireController.text ??
          widget.currentUserData.burningDesire ??
          "",
      somethingNoOneKnowsAboutMe: vvm.knowAboutMeController.text ??
          widget.currentUserData.somethingNoOneKnowsAboutMe ??
          "",
      keyToSuccess: vvm.keyToSuccessController.text ??
          widget.currentUserData.keyToSuccess ??
          "",
      residentAddress: widget.currentUserData.permanentAddress ?? "",
      permanentAddress: widget.currentUserData.permanentAddress ?? "",
      maritalStatus: widget.currentUserData.maritalStatus ?? "",
      previousTypesOfJobs: vvm.previousTypesOfJobsController.text ??
          widget.currentUserData.previousTypesOfJobs ??
          "",
      partner:
          vvm.partnerController.text ?? widget.currentUserData.partner ?? "",
      businessDetailsResponse: CompanyDetailsRequest(
          uuid: widget.currentUserData.uuid ?? "",
          companyName:
              widget.currentUserData?.currentUserOrganization?.companyName ??
                  "",
          companyEstablishment: vvm.yearOfBusinessController.text ??
              "",
          companyAddress:
              widget.currentUserData?.currentUserOrganization?.companyAddress ??
                  "",
          registeredType:
              widget.currentUserData?.currentUserOrganization?.registeredType ??
                  "",
          numberOfEmployees: widget
              .currentUserData?.currentUserOrganization?.numberOfEmployees,
          yearlyTurnover:
              widget.currentUserData?.currentUserOrganization?.yearlyTurnover ??
                  "",
          companyEmail:
              widget.currentUserData?.currentUserOrganization?.companyEmail ??
                  "",
          companyWebsite:
              widget.currentUserData?.currentUserOrganization?.companyWebsite ??
                  "",
          designation:
              widget.currentUserData?.currentUserOrganization?.designation ??
                  "",
          companyContact:
              widget.currentUserData?.currentUserOrganization?.companyContact ??
                  "",
          businessCategory:
              widget.currentUserData?.currentUserOrganization?.businessCategory ?? "",
          businessDescription: widget.currentUserData?.currentUserOrganization?.businessDescription ?? "",
          yearlyProfit: widget.currentUserData?.currentUserOrganization?.yearlyProfit ?? 0.0,
          gstNumber: widget.currentUserData?.currentUserOrganization?.gstNumber ?? "",
          uploadGst: widget.currentUserData?.currentUserOrganization?.uploadGst ?? "",
          panNumber: widget.currentUserData?.currentUserOrganization?.panNumber ?? "",
          uploadPan: widget.currentUserData?.currentUserOrganization?.uploadPan ?? ""),
      addressRequest: AddressRequest(
        city: vvm.cityResidenceController.text ?? "",
        state: widget.currentUserData.currentUserAddress?.state ?? "",
        country: widget.currentUserData.currentUserAddress?.country ?? "",
        pinCode: widget.currentUserData.currentUserAddress?.pinCode ?? "",
      ),
    );
    bool resp = await vvm.updateProfile(userProfileRequestModel);
    if (resp) {
      Get.back(result: true, canPop: true, closeOverlays: true);
    } else {
      showSnackBar('errorMessage'.tr);
    }

    // if (vvm.yearOfBusinessController.text.isEmpty) {
    //   showSnackBar("Please enter years of business");
    // } else if (vvm.previousTypesOfJobsController.text.isEmpty) {
    //   showSnackBar("Please enter previous types of job");
    // } else if (vvm.partnerController.text.isEmpty) {
    //   showSnackBar("Please enter your partner name");
    // } else if (vvm.childrenController.text.isEmpty) {
    //   showSnackBar("Please enter children count");
    // } else if (vvm.petsController.text.isEmpty) {
    //   showSnackBar("Please enter pet");
    // } else if (vvm.hobbiesController.text.isEmpty) {
    //   showSnackBar("Please enter hobbies");
    // } else if (vvm.cityResidenceController.text.isEmpty) {
    //   showSnackBar("Please enter city of your residence");
    // } else if (vvm.yearInTheCityController.text.isEmpty) {
    //   showSnackBar("Please enter years in the city");
    // } else if (vvm.knowAboutMeController.text.isEmpty) {
    //   showSnackBar("Please enter your know about me");
    // } else if (vvm.keyToSuccessController.text.isEmpty) {
    //   showSnackBar("Please enter your success key");
    // } else {
    //   bool resp = await vvm.updateProfile(
    //     new UpdateProfileRequestModel(
    //         firstName: widget.currentUserData.firstName,
    //         lastName: widget.currentUserData.lastName,
    //         dob: widget.currentUserData.dob,
    //         countryCode: widget.currentUserData.countryCode,
    //         mobileNo: widget.currentUserData.mobileNo,
    //         uploadDocumentId: widget.currentUserData.uploadDocumentId,
    //         education: widget.currentUserData.education,
    //         children: int.parse(vvm.childrenController.text),
    //         pet: vvm.petsController.text,
    //         hobbiesAndInterest: vvm.hobbiesController.text,
    //         cityResidingYears: int.parse(vvm.cityResidenceController.text),
    //         burningDesire: vvm.burningDesireController.text,
    //         somethingNoOneKnowsAboutMe: vvm.knowAboutMeController.text,
    //         keyToSuccess: vvm.keyToSuccessController.text,
    //         maritalStatus: widget.currentUserData.maritalStatus,
    //         companyDetailsRequest: CompanyDetailsRequest(
    //           businessCategory: widget
    //               .currentUserData.currentUserOrganization?.businessCategory,
    //           companyName:
    //               widget.currentUserData.currentUserOrganization?.companyName,
    //           companyRegistration: widget
    //               .currentUserData.currentUserOrganization?.companyRegistration,
    //           establishedYear: widget
    //               .currentUserData.currentUserOrganization?.establishedYear,
    //           numberOfStaff:
    //               widget.currentUserData.currentUserOrganization?.numberOfStaff,
    //           gstNumber:
    //               widget.currentUserData.currentUserOrganization?.gstNumber,
    //           officeNumber:
    //               widget.currentUserData.currentUserOrganization?.officeNumber,
    //           officeEmail:
    //               widget.currentUserData.currentUserOrganization?.officeEmail,
    //         ),
    //         addressRequest: AddressRequest(
    //           city: widget.currentUserData.currentUserAddress?.city,
    //           state: widget.currentUserData.currentUserAddress?.state,
    //           pinCode: widget.currentUserData.currentUserAddress?.pinCode,
    //         )),
    //   );
    //   if (resp) {
    //     Get.back(result: true, canPop: true, closeOverlays: true);
    //   } else {
    //     showSnackBar('errorMessage'.tr);
    //   }
    // }
  }
}
