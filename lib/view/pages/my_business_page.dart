import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/my_business_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBusinessPage extends StatefulWidget {
  CurrentUserData currentUserData;

  MyBusinessPageState createState() => MyBusinessPageState();

  MyBusinessPage({required this.currentUserData});
}

class MyBusinessPageState extends State<MyBusinessPage> {
  @override
  void initState() {
    super.initState();
    MyBusinessViewModel myBusinessViewModel = Get.find<MyBusinessViewModel>();
    myBusinessViewModel.businessDetailsController.text =
        widget.currentUserData.currentUserOrganization?.businessDescription ??
            "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MyBusinessViewModel>(builder: (myBusinessVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "my_business".tr,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: paddingSize10, horizontal: paddingSize15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: paddingSize15),
                  CommonTextFormField(
                    controller: myBusinessVM.businessDetailsController,
                    maxLines: 6,
                    bgColor: lavenderMist,
                    padding: const EdgeInsets.symmetric(
                        vertical: paddingSize15, horizontal: paddingSize15),
                    textStyle:
                        fontMedium.copyWith(color: black, fontSize: fontSize14),
                    hintText:
                        "Digital Marketing, Website Design & Development, Graphic Design, Branding, Ui Ux, SEO, Application Development",
                  ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "confirm".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () async {
                      await collectDataAndSaveProfile(myBusinessVM);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> collectDataAndSaveProfile(
      MyBusinessViewModel myBusinessVM) async {
    if (myBusinessVM.businessDetailsController.text.isEmpty) {
      showSnackBar("enter_valid_business_desc".tr);
    } else {
      UpdateProfileRequestModel userProfileRequestModel =
          new UpdateProfileRequestModel(
        firstName: widget.currentUserData.firstName ?? "",
        lastName: widget.currentUserData.lastName ?? "",
        dob: widget.currentUserData.dob ?? "",
        countryCode: widget.currentUserData.countryCode ?? "",
        mobileNo: widget?.currentUserData?.mobileNo ?? "",
        uploadDocumentId: widget.currentUserData.uploadDocumentId ?? "",
        education: widget.currentUserData.education ?? "",
        children: widget.currentUserData.children ?? 0,
        pet: widget.currentUserData.pet ?? "",
        hobbiesAndInterest: widget.currentUserData.hobbiesAndInterest ?? "",
        cityResidingYears: widget.currentUserData.cityResidingYears ?? 0,
        burningDesire: widget.currentUserData.burningDesire ?? "",
        somethingNoOneKnowsAboutMe:
            widget.currentUserData.somethingNoOneKnowsAboutMe ?? "",
        keyToSuccess: widget.currentUserData.keyToSuccess ?? "",
        maritalStatus: widget.currentUserData.maritalStatus ?? "",
        residentAddress: widget.currentUserData.permanentAddress ?? "",
        permanentAddress: widget.currentUserData.permanentAddress ?? "",
        previousTypesOfJobs: widget.currentUserData.previousTypesOfJobs ?? "",
        partner: widget.currentUserData.partner ?? "",
        companyDetailsRequest: CompanyDetailsRequest(
            uuid: widget.currentUserData.uuid ?? "",
            companyName:
                widget.currentUserData?.currentUserOrganization?.companyName ??
                    "",
            companyEstablishment: widget.currentUserData
                    ?.currentUserOrganization?.companyEstablishment ??
                "",
            companyAddress:
                widget.currentUserData?.currentUserOrganization?.companyAddress ??
                    "",
            registeredType:
                widget.currentUserData?.currentUserOrganization?.registeredType ??
                    "",
            numberOfEmployees: widget
                .currentUserData?.currentUserOrganization?.numberOfEmployees,
            yearlyTurnover: widget
                    .currentUserData?.currentUserOrganization?.yearlyTurnover ??
                "",
            companyEmail:
                widget.currentUserData?.currentUserOrganization?.companyEmail ??
                    "",
            companyWebsite: widget
                    .currentUserData?.currentUserOrganization?.companyWebsite ??
                "",
            designation:
                widget.currentUserData?.currentUserOrganization?.designation ?? "",
            companyContact: widget.currentUserData?.currentUserOrganization?.companyContact ?? "",
            businessCategory: widget.currentUserData?.currentUserOrganization?.businessCategory ?? "",
            businessDescription: myBusinessVM.businessDetailsController.text ?? widget.currentUserData?.currentUserOrganization?.businessDescription ?? "",
            yearlyProfit: widget.currentUserData?.currentUserOrganization?.yearlyProfit ?? 0.0,
            gstNumber: widget.currentUserData?.currentUserOrganization?.gstNumber ?? "",
            uploadGst: widget.currentUserData?.currentUserOrganization?.uploadGst ?? "",
            panNumber: widget.currentUserData?.currentUserOrganization?.panNumber ?? "",
            uploadPan: widget.currentUserData?.currentUserOrganization?.uploadPan ?? ""),
        addressRequest: AddressRequest(
          city: widget.currentUserData.currentUserAddress?.city ?? "",
          state: widget.currentUserData.currentUserAddress?.state ?? "",
          country: widget.currentUserData.currentUserAddress?.country ?? "",
          pinCode: widget.currentUserData.currentUserAddress?.pinCode ?? "",
        ),
      );
      bool resp = await myBusinessVM.updateProfile(userProfileRequestModel);
      if (resp) {
        Get.back(result: true, canPop: true, closeOverlays: true);
        showSnackBar("profile_updated".tr, isError: false);
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
