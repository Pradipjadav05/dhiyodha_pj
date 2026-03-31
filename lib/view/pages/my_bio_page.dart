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
  final CurrentUserData currentUserData;

  const MyBioPage({Key? key, required this.currentUserData}) : super(key: key);

  @override
  MyBioPagePageState createState() => MyBioPagePageState();
}

class MyBioPagePageState extends State<MyBioPage> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final VisitingCardViewModel vvm = Get.find<VisitingCardViewModel>();
    await vvm.initData();

    // ── Set currentUserData — triggers _refreshControllers() internally ──
    vvm.currentUserData = widget.currentUserData;

    // ── Bio-specific fields not covered by _refreshControllers ──
    vvm.yearOfBusinessController.text =
        widget.currentUserData.currentUserOrganization?.yearOfBusiness.toString() ?? '';
    vvm.previousTypesOfJobsController.text =
        widget.currentUserData.previousTypesOfJobs ?? '';
    vvm.partnerController.text =
        widget.currentUserData.partner ?? '';
    vvm.childrenController.text =
        (widget.currentUserData.children ?? 0).toString();
    vvm.petsController.text =
        widget.currentUserData.pet ?? '';
    vvm.hobbiesController.text =
        widget.currentUserData.hobbiesAndInterest ?? '';
    vvm.cityResidenceController.text =
        widget.currentUserData.currentUserAddress?.city ?? '';
    vvm.yearInTheCityController.text =
        (widget.currentUserData.cityResidingYears ?? 0).toString();
    vvm.burningDesireController.text =
        widget.currentUserData.burningDesire ?? '';
    vvm.knowAboutMeController.text =
        widget.currentUserData.somethingNoOneKnowsAboutMe ?? '';
    vvm.keyToSuccessController.text =
        widget.currentUserData.keyToSuccess ?? '';

    setState(() {});
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
            'my_bio'.tr,
            style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    const SizedBox(height: paddingSize15),

                    _buildField(
                      label: 'year_of_business'.tr,
                      controller: vvm.yearOfBusinessController,
                      hintText: 'year_of_business'.tr,
                    ),
                    _buildField(
                      label: 'prev_jobs'.tr,
                      controller: vvm.previousTypesOfJobsController,
                      hintText: 'prev_jobs'.tr,
                    ),
                    _buildField(
                      label: 'partner'.tr,
                      controller: vvm.partnerController,
                      hintText: 'partner'.tr,
                    ),
                    _buildField(
                      label: 'child'.tr,
                      controller: vvm.childrenController,
                      hintText: 'child'.tr,
                      inputType: TextInputType.number,
                    ),
                    _buildField(
                      label: 'pets'.tr,
                      controller: vvm.petsController,
                      hintText: 'pets'.tr,
                    ),
                    _buildField(
                      label: 'hobby'.tr,
                      controller: vvm.hobbiesController,
                      hintText: 'hobby'.tr,
                    ),
                    _buildField(
                      label: 'city_residence'.tr,
                      controller: vvm.cityResidenceController,
                      hintText: 'city_residence'.tr,
                    ),
                    _buildField(
                      label: 'year_in_city'.tr,
                      controller: vvm.yearInTheCityController,
                      hintText: 'year_in_city'.tr,
                      inputType: TextInputType.number,
                    ),
                    _buildField(
                      label: 'burning_desire'.tr,
                      controller: vvm.burningDesireController,
                      hintText: 'burning_desire'.tr,
                      maxLines: 3,
                    ),
                    _buildField(
                      label: 'know_about_me'.tr,
                      controller: vvm.knowAboutMeController,
                      hintText: 'know_about_me'.tr,
                      maxLines: 4,
                    ),
                    _buildField(
                      label: 'success_key'.tr,
                      controller: vvm.keyToSuccessController,
                      hintText: 'success_key'.tr,
                      maxLines: 4,
                    ),

                    const SizedBox(height: paddingSize25),

                    vvm.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CommonButton(
                      buttonText: 'confirm'.tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        await _collectDataAndSaveProfile(vvm);
                      },
                    ),

                    const SizedBox(height: paddingSize20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ── Reusable labeled field ──
  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: fontMedium.copyWith(fontSize: fontSize14, color: bluishPurple),
        ),
        const SizedBox(height: paddingSize8),
        CommonTextFormField(
          controller: controller,
          bgColor: lavenderMist,
          inputType: inputType,
          maxLines: maxLines,
          padding: const EdgeInsets.symmetric(
              vertical: paddingSize15, horizontal: paddingSize15),
          textStyle:
          fontMedium.copyWith(color: midnightBlue, fontSize: fontSize14),
          hintText: hintText,
        ),
        const SizedBox(height: paddingSize20),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────
  // _collectDataAndSaveProfile
  //
  // Fixes from original:
  //   1. int.parse() crashes if field is empty — wrapped in
  //      int.tryParse() with fallback to 0
  //   2. locationController no longer exists — address fields
  //      (pinCode, city, state, country) now come from separate
  //      controllers in VisitingCardViewModel
  //   3. cityResidenceController used for AddressRequest.city
  //      (same as before — user edits city here in bio page)
  //   4. Removed all unnecessary ?? after non-nullable .text
  // ────────────────────────────────────────────────────────────
  Future<void> _collectDataAndSaveProfile(VisitingCardViewModel vvm) async {
    final UpdateProfileRequestModel request = UpdateProfileRequestModel(
      firstName: widget.currentUserData.firstName ?? '',
      lastName: widget.currentUserData.lastName ?? '',
      dob: widget.currentUserData.dob ?? '',
      countryCode: widget.currentUserData.countryCode ?? '',
      mobileNo: widget.currentUserData.mobileNo ?? '',
      uploadDocumentId: widget.currentUserData.uploadDocumentId ?? '',
      education: widget.currentUserData.education ?? '',

      // ── FIX: int.tryParse avoids crash on empty field ──
      children: int.tryParse(vvm.childrenController.text) ??
          widget.currentUserData.children ??
          0,
      pet: vvm.petsController.text.isNotEmpty
          ? vvm.petsController.text
          : widget.currentUserData.pet ?? '',
      hobbiesAndInterest: vvm.hobbiesController.text.isNotEmpty
          ? vvm.hobbiesController.text
          : widget.currentUserData.hobbiesAndInterest ?? '',

      // ── FIX: int.tryParse avoids crash on empty field ──
      cityResidingYears: int.tryParse(vvm.yearInTheCityController.text) ?? 0,

      burningDesire: vvm.burningDesireController.text.isNotEmpty
          ? vvm.burningDesireController.text
          : widget.currentUserData.burningDesire ?? '',
      somethingNoOneKnowsAboutMe: vvm.knowAboutMeController.text.isNotEmpty
          ? vvm.knowAboutMeController.text
          : widget.currentUserData.somethingNoOneKnowsAboutMe ?? '',
      keyToSuccess: vvm.keyToSuccessController.text.isNotEmpty
          ? vvm.keyToSuccessController.text
          : widget.currentUserData.keyToSuccess ?? '',
      residentAddress: widget.currentUserData.permanentAddress ?? '',
      permanentAddress: widget.currentUserData.permanentAddress ?? '',
      maritalStatus: widget.currentUserData.maritalStatus ?? '',
      previousTypesOfJobs: vvm.previousTypesOfJobsController.text.isNotEmpty
          ? vvm.previousTypesOfJobsController.text
          : widget.currentUserData.previousTypesOfJobs ?? '',
      partner: vvm.partnerController.text.isNotEmpty
          ? vvm.partnerController.text
          : widget.currentUserData.partner ?? '',

      businessDetailsResponse: CompanyDetailsRequest(
        uuid: widget.currentUserData.uuid ?? '',
        companyName:
            widget.currentUserData.currentUserOrganization?.companyName ?? '',
        companyEstablishment: widget.currentUserData.currentUserOrganization
                ?.companyEstablishment ??
            '',
        yearOfBusiness: vvm.yearOfBusinessController.text.isNotEmpty
            ? vvm.yearOfBusinessController.text
            : widget.currentUserData.currentUserOrganization?.yearOfBusiness.toString() ?? '',
        companyAddress:
        widget.currentUserData.currentUserOrganization?.companyAddress ?? '',
        registeredType:
        widget.currentUserData.currentUserOrganization?.registeredType ?? '',
        numberOfEmployees:
        widget.currentUserData.currentUserOrganization?.numberOfEmployees,
        yearlyTurnover:
        widget.currentUserData.currentUserOrganization?.yearlyTurnover ?? '',
        companyEmail:
        widget.currentUserData.currentUserOrganization?.companyEmail ?? '',
        companyWebsite:
        widget.currentUserData.currentUserOrganization?.companyWebsite ?? '',
        designation:
        widget.currentUserData.currentUserOrganization?.designation ?? '',
        companyContact:
        widget.currentUserData.currentUserOrganization?.companyContact ?? '',
        businessCategory:
        widget.currentUserData.currentUserOrganization?.businessCategory ?? '',
        businessDescription:
        widget.currentUserData.currentUserOrganization?.businessDescription ?? '',
        yearlyProfit:
        widget.currentUserData.currentUserOrganization?.yearlyProfit ?? 0.0,
        gstNumber:
        widget.currentUserData.currentUserOrganization?.gstNumber ?? '',
        uploadGst:
        widget.currentUserData.currentUserOrganization?.uploadGst ?? '',
        panNumber:
        widget.currentUserData.currentUserOrganization?.panNumber ?? '',
        uploadPan:
        widget.currentUserData.currentUserOrganization?.uploadPan ?? '',
      ),

      // ── FIX: use separate address controllers (locationController removed) ──
      addressRequest: AddressRequest(
        city: vvm.cityResidenceController.text.isNotEmpty
            ? vvm.cityResidenceController.text
            : widget.currentUserData.currentUserAddress?.city ?? '',
        state: vvm.stateController.text.isNotEmpty
            ? vvm.stateController.text
            : widget.currentUserData.currentUserAddress?.state ?? '',
        country: vvm.countryController.text.isNotEmpty
            ? vvm.countryController.text
            : widget.currentUserData.currentUserAddress?.country ?? '',
        pinCode: vvm.pinCodeController.text.isNotEmpty
            ? vvm.pinCodeController.text
            : widget.currentUserData.currentUserAddress?.pinCode ?? '',
      ),
    );

    final bool resp = await vvm.updateProfile(request);
    if (resp) {
      Get.back(result: true, canPop: true, closeOverlays: true);
    } else {
      showSnackBar('errorMessage'.tr);
    }
  }
}