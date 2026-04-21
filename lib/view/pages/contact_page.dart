import 'package:dhiyodha/model/request_model/update_profile_request_model.dart';
import 'package:dhiyodha/model/response_model/current_user_response_model.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/contact_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  CurrentUserData currentUserData;

  ContactPageState createState() => ContactPageState();

  ContactPage({required this.currentUserData});
}

class ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
    ContactViewmodel contactViewmodel = Get.find<ContactViewmodel>();
    contactViewmodel.contactNum1Controller.text =
        widget.currentUserData.mobileNo ?? "";
    contactViewmodel.contactNum2Controller.text =
        widget.currentUserData.currentUserOrganization?.companyContact ?? "";
    contactViewmodel.emailController.text = widget.currentUserData.email ?? "";
    contactViewmodel.websiteController.text =
        widget.currentUserData.currentUserOrganization?.companyWebsite ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text(
          "contact".tr,
          style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<ContactViewmodel>(builder: (contactVM) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                      textStyle: fontMedium.copyWith(
                          color: midnightBlue, fontSize: fontSize14),
                      maxLength: 10,
                      inputType: TextInputType.number,
                      controller: contactVM.contactNum1Controller,
                      hintText: "number_1".tr,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20)),
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    maxLength: 10,
                    inputType: TextInputType.number,
                    controller: contactVM.contactNum2Controller,
                    hintText: "number_2".tr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    inputType: TextInputType.emailAddress,
                    controller: contactVM.emailController,
                    hintText: "email".tr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonTextFormField(
                    textStyle: fontMedium.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    inputType: TextInputType.url,
                    controller: contactVM.websiteController,
                    hintText: "website".tr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                  SizedBox(height: paddingSize25),
                  CommonButton(
                    buttonText: "confirm".tr,
                    bgColor: midnightBlue,
                    textColor: periwinkle,
                    onPressed: () async {
                      await collectDataAndSaveProfile(contactVM);
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> collectDataAndSaveProfile(ContactViewmodel contactVM) async {
    if (contactVM.contactNum1Controller.text.isEmpty) {
      showSnackBar("valid_number".tr);
    } else if (contactVM.contactNum2Controller.text.isEmpty) {
      showSnackBar("valid_number".tr);
    } else if (contactVM.emailController.text.isEmpty) {
      showSnackBar("valid_email".tr);
    } else if (contactVM.websiteController.text.isEmpty) {
      showSnackBar("valid_web".tr);
    } else {
      UpdateProfileRequestModel userProfileRequestModel =
          new UpdateProfileRequestModel(
        firstName: widget.currentUserData.firstName ?? "",
        lastName: widget.currentUserData.lastName ?? "",
        dob: widget.currentUserData.dob ?? "",
        countryCode: widget.currentUserData.countryCode ?? "",
        mobileNo: contactVM.contactNum1Controller.text ??
            widget?.currentUserData?.mobileNo ??
            "",
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
        residentAddress: widget.currentUserData.permanentAddress ?? "",
        permanentAddress: widget.currentUserData.permanentAddress ?? "",
        maritalStatus: widget.currentUserData.maritalStatus ?? "",
        previousTypesOfJobs: widget.currentUserData.previousTypesOfJobs ?? "",
        partner: widget.currentUserData.partner ?? "",
        businessDetailsResponse: CompanyDetailsRequest(
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
            companyEmail: contactVM.emailController.text ??
                widget.currentUserData?.currentUserOrganization?.companyEmail ??
                "",
            companyWebsite: contactVM.websiteController.text ??
                widget.currentUserData?.currentUserOrganization?.companyWebsite ??
                "",
            designation: widget.currentUserData?.currentUserOrganization?.designation ?? "",
            companyContact: contactVM.contactNum2Controller.text ?? widget.currentUserData?.currentUserOrganization?.companyContact ?? "",
            businessCategory: widget.currentUserData?.currentUserOrganization?.businessCategory ?? "",
            businessDescription: widget.currentUserData?.currentUserOrganization?.businessDescription ?? "",
            yearlyProfit: widget.currentUserData?.currentUserOrganization?.yearlyProfit ?? 0.0,
            gstNumber: widget.currentUserData?.currentUserOrganization?.gstNumber ?? "",
            uploadGst: widget.currentUserData?.currentUserOrganization?.uploadGst ?? "",
            panNumber: widget.currentUserData?.currentUserOrganization?.panNumber ?? "",
            uploadPan: widget.currentUserData?.currentUserOrganization?.uploadPan ?? ""),
        addressRequest: AddressRequest(
          city: widget.currentUserData.currentUserAddress?.city ?? "",
          state: widget.currentUserData.currentUserAddress?.state ?? "",
          pinCode: widget.currentUserData.currentUserAddress?.pinCode ?? "",
        ),
      );
      bool resp = await contactVM.updateProfile(userProfileRequestModel);
      if (resp) {
        Get.back(result: true, canPop: true, closeOverlays: true);
        showSnackBar("profile_updated".tr, isError: false);
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }
}
