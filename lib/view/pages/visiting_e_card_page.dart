import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/visiting_card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class VisitingECardPage extends StatefulWidget {
  final CurrentUserData? currentUserData;
  final VisitorChildData? visitorChildData;

  const VisitingECardPage({
    Key? key,
    this.currentUserData,
    this.visitorChildData,
  }) : super(key: key);

  @override
  VisitingECardPageState createState() => VisitingECardPageState();
}

class VisitingECardPageState extends State<VisitingECardPage> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final vvm = Get.find<VisitingCardViewModel>();

    await vvm.initData();

    bool hasCurrentUserData =
        widget.currentUserData != null &&
            (widget.currentUserData!.firstName?.isNotEmpty == true ||
                widget.currentUserData!.mobileNo?.isNotEmpty == true);

    if (hasCurrentUserData) {
      vvm.currentUserData = widget.currentUserData!;
    } else if (widget.visitorChildData != null) {
      vvm.visitorData = widget.visitorChildData!;
    }

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
            'v_card'.tr,
            style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          menuWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Get.toNamed(Routes.getWebViewPageRoute(queryWebUrl)),
              child: Image.asset(query, width: 24.0),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<VisitingCardViewModel>(
            builder: (vvm) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Profile header ──
                        _buildProfileHeader(vvm),
                        const SizedBox(height: paddingSize20),

                        // ── Details card ──
                        _buildDetailsCard(vvm),
                        const SizedBox(height: paddingSize25),

                        // ── Share + Edit ──
                        Visibility(
                          visible: !vvm.isVisitorData.value,
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonButton(
                                  icon: share,
                                  buttonText: 'share'.tr,
                                  bgColor: midnightBlue,
                                  iconColor: white,
                                  textColor: white,
                                  onPressed: () async {
                                    final String data =
                                        '${vvm.currentUserData.firstName ?? ''} ${vvm.currentUserData.lastName ?? ''}'
                                        '\n${vvm.contactController.text}'
                                        '\n${vvm.companyNameController.text}'
                                        '\n${vvm.businessCategoryController.text}';
                                    final String shareString =
                                        '${'checkout_profile'.tr} \n\n$data \n\nDownload Now : $playStoreUrl';
                                    await Share.share(shareString);
                                  },
                                ),
                              ),
                              const SizedBox(width: paddingSize15),
                              Expanded(
                                child: CommonButton(
                                  icon: edit,
                                  buttonText: 'edit'.tr,
                                  iconColor: bluishPurple,
                                  bgColor: lavenderMist,
                                  textColor: bluishPurple,
                                  onPressed: () {
                                    vvm.isEditData.value = true;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: paddingSize15),

                        // ── Submit ──
                        Visibility(
                          visible: vvm.isEditData.value,
                          child: vvm.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CommonButton(
                                  buttonText: 'submit'.tr,
                                  bgColor: bluishPurple,
                                  textColor: lavenderMist,
                                  onPressed: () async {
                                    await _updateUserProfile(vvm);
                                  },
                                ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }

  // ── Profile header banner ──
  Widget _buildProfileHeader(VisitingCardViewModel vvm) {
    final bool isVisitor = vvm.isVisitorData.value;

    final String fullName = isVisitor
        ? (vvm.visitorData.name ?? '')
        : '${vvm.currentUserData.firstName ?? ''} ${vvm.currentUserData.lastName ?? ''}';

    final String? imageUrl = isVisitor
        ? vvm.visitorData.profileUrl
        : vvm.currentUserData.profileUrl;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius15),
        image: DecorationImage(
          image: AssetImage(profileBg),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: paddingSize20, vertical: paddingSize20),
      child: Row(
        children: [
          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: white.withOpacity(0.6), width: 2.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => _placeholderAvatar(),
              )
                  : _placeholderAvatar(),
            ),
          ),
          const SizedBox(width: paddingSize15),
          Expanded(
            child: Text(
              fullName.trim(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: fontBold.copyWith(fontSize: fontSize22, color: white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderAvatar() {
    return Container(
      height: 68.0,
      width: 68.0,
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

  // ── Details card ──
  Widget _buildDetailsCard(VisitingCardViewModel vvm) {
    final bool isVisitor = vvm.isVisitorData.value;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: lavenderMist,
        borderRadius: BorderRadius.circular(radius15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(isVisitor)
            ...[
              _infoRow(
                assetIcon: meeting,
                label: 'Meeting Chapter Name',
                controller: vvm.meetingChapterNameController,
                isEnabled: vvm.isEditData.value,
              ),
              _divider(),
            ],
          // Contact
          _infoRow(
            assetIcon: contact,
            label: 'contact_number'.tr,
            controller: vvm.contactController,
            isEnabled: vvm.isEditData.value,
            inputType: TextInputType.number,
            maxLength: 10,
          ),
          _divider(),

          // Company
          _infoRow(
            assetIcon: company,
            label: 'company_name'.tr,
            controller: vvm.companyNameController,
            isEnabled: vvm.isEditData.value,
          ),
          _divider(),

          // // Designation
          // _infoRow(
          //   assetIcon: businessCat,
          //   label: 'designation'.tr,
          //   controller: vvm.designationController,
          //   isEnabled: vvm.isEditData.value,
          // ),
          // _divider(),

          // Business Category
          _infoRow(
            assetIcon: businessCat,
            label: 'business_category'.tr,
            controller: vvm.businessCategoryController,
            isEnabled: vvm.isEditData.value,
          ),
          _divider(),

          // ── Location section header ──
          Padding(
            padding: const EdgeInsets.only(
                left: paddingSize20,
                right: paddingSize20,
                top: paddingSize15,
                bottom: paddingSize5),
            child: Row(
              children: [
                Image.asset(location, height: iconSize18, width: iconSize18),
                const SizedBox(width: paddingSize5),
                Text(
                  'location'.tr,
                  style: fontRegular.copyWith(
                      fontSize: fontSize12,
                      color: midnightBlue.withOpacity(0.6)),
                ),
              ],
            ),
          ),

          // ── 4 address sub-fields ──
          _addressSubFields(vvm),

          const SizedBox(height: paddingSize10),
        ],
      ),
    );
  }

  // ── Address sub-fields: PinCode + City in a row, State + Country in a row ──
  Widget _addressSubFields(VisitingCardViewModel vvm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingSize20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: PinCode | City
          Row(
            children: [
              if(!vvm.isVisitorData.value)
                ...[
                  Expanded(
                    child: _addressField(
                      label: 'pin code',
                      controller: vvm.pinCodeController,
                      isEnabled: vvm.isEditData.value,
                      inputType: TextInputType.number,
                      maxLength: 6,
                    ),
                  ),
                  const SizedBox(width: paddingSize14),
                ],
              Expanded(
                child: _addressField(
                  label: 'city',
                  controller: vvm.cityController,
                  isEnabled: vvm.isEditData.value,
                ),
              ),
            ],
          ),
          const SizedBox(height: paddingSize8),

          // Row 2: State | Country
          Row(
            children: [
              Expanded(
                child: _addressField(
                  label: 'state'.tr,
                  controller: vvm.stateController,
                  isEnabled: vvm.isEditData.value,
                ),
              ),
              const SizedBox(width: paddingSize14),
              Expanded(
                child: _addressField(
                  label: 'country'.tr,
                  controller: vvm.countryController,
                  isEnabled: vvm.isEditData.value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Single address sub-field ──
  Widget _addressField({
    required String label,
    required TextEditingController controller,
    required bool isEnabled,
    TextInputType inputType = TextInputType.text,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: fontRegular.copyWith(
              fontSize: fontSize12, color: midnightBlue.withOpacity(0.5)),
        ),
        const SizedBox(height: 2),
        isEnabled
            ? CommonTextFormField(
                isEnabled: true,
                inputType: inputType,
                maxLength: maxLength,
                maxLines: 1,
                controller: controller,
                bgColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 4),
                textStyle: fontMedium.copyWith(
                    fontSize: fontSize14, color: midnightBlue),
              )
            : Text(
                controller.text.isNotEmpty ? controller.text : '—',
                style: fontMedium.copyWith(
                    fontSize: fontSize14, color: midnightBlue),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        const Divider(height: 1),
      ],
    );
  }

  // ── Generic info row ──
  Widget _infoRow({
    required String assetIcon,
    required String label,
    required TextEditingController controller,
    required bool isEnabled,
    TextInputType inputType = TextInputType.text,
    int? maxLength,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: paddingSize20, vertical: paddingSize15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(assetIcon, height: iconSize18, width: iconSize18, color: bluishPurple,),
              const SizedBox(width: paddingSize5),
              Text(
                label,
                style: fontRegular.copyWith(
                    fontSize: fontSize12, color: midnightBlue.withOpacity(0.6)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          isEnabled
              ? CommonTextFormField(
                  isEnabled: true,
                  inputType: inputType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  controller: controller,
                  bgColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  textStyle: fontMedium.copyWith(
                      fontSize: fontSize14, color: midnightBlue),
                )
              : Text(
                  controller.text.isNotEmpty ? controller.text : '—',
                  style: fontMedium.copyWith(
                      fontSize: fontSize16, color: midnightBlue),
                  maxLines: maxLines,
                  overflow: TextOverflow.visible,
                ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: midnightBlue.withOpacity(0.1),
      indent: paddingSize20,
      endIndent: paddingSize20,
    );
  }

  // ────────────────────────────────────────────────────────────
  // _updateUserProfile — each address field sent separately
  // ────────────────────────────────────────────────────────────
  Future<void> _updateUserProfile(VisitingCardViewModel vvm) async {
    if (vvm.contactController.text.isEmpty ||
        vvm.contactController.text.length < 10) {
      showSnackBar('valid_number'.tr);
      return;
    }
    if (vvm.companyNameController.text.isEmpty) {
      showSnackBar('enter_cmp_name'.tr);
      return;
    }
    if (vvm.designationController.text.isEmpty) {
      showSnackBar('enter_designation'.tr);
      return;
    }
    if (vvm.businessCategoryController.text.isEmpty) {
      showSnackBar('enter_business_category'.tr);
      return;
    }
    if (vvm.cityController.text.isEmpty) {
      showSnackBar('enter_location'.tr);
      return;
    }

    final UpdateProfileRequestModel request = UpdateProfileRequestModel(
      firstName: vvm.currentUserData.firstName ?? '',
      lastName: vvm.currentUserData.lastName ?? '',
      dob: vvm.currentUserData.dob ?? '',
      countryCode: vvm.currentUserData.countryCode ?? '',
      mobileNo: vvm.contactController.text.isNotEmpty
          ? vvm.contactController.text
          : vvm.currentUserData.mobileNo ?? '',
      uploadDocumentId: vvm.currentUserData.uploadDocumentId ??
          'ce6b8b8f-b252-4834-97c2-8d9927e4f5a2',
      education: vvm.currentUserData.education ?? '',
      children: vvm.currentUserData.children ?? 0,
      pet: vvm.currentUserData.pet ?? '',
      hobbiesAndInterest: vvm.currentUserData.hobbiesAndInterest ?? '',
      cityResidingYears: vvm.currentUserData.cityResidingYears ?? 0,
      burningDesire: vvm.currentUserData.burningDesire ?? '',
      somethingNoOneKnowsAboutMe:
          vvm.currentUserData.somethingNoOneKnowsAboutMe ?? '',
      keyToSuccess: vvm.currentUserData.keyToSuccess ?? '',
      residentAddress: vvm.currentUserData.permanentAddress ?? '',
      permanentAddress: vvm.currentUserData.permanentAddress ?? '',
      maritalStatus: vvm.currentUserData.maritalStatus ?? '',
      previousTypesOfJobs: vvm.currentUserData.previousTypesOfJobs ?? '',
      partner: vvm.currentUserData.partner ?? '',
      businessDetailsResponse: CompanyDetailsRequest(
        uuid: vvm.currentUserData.uuid ?? '',
        companyName: vvm.companyNameController.text.isNotEmpty
            ? vvm.companyNameController.text
            : vvm.currentUserData.currentUserOrganization?.companyName ?? '',
        companyEstablishment:
            vvm.currentUserData.currentUserOrganization?.companyEstablishment ??
                '',
        companyAddress:
            vvm.currentUserData.currentUserOrganization?.companyAddress ?? '',
        registeredType:
            widget.currentUserData?.currentUserOrganization?.registeredType ??
                '',
        numberOfEmployees:
            vvm.currentUserData.currentUserOrganization?.numberOfEmployees,
        yearlyTurnover:
            vvm.currentUserData.currentUserOrganization?.yearlyTurnover ?? '',
        companyEmail:
            widget.currentUserData?.currentUserOrganization?.companyEmail ?? '',
        companyWebsite:
            widget.currentUserData?.currentUserOrganization?.companyWebsite ??
                '',
        designation: vvm.designationController.text.isNotEmpty
            ? vvm.designationController.text
            : widget.currentUserData?.currentUserOrganization?.designation ??
                '',
        companyContact:
            vvm.currentUserData.currentUserOrganization?.companyContact ?? '',
        businessCategory: vvm.businessCategoryController.text.isNotEmpty
            ? vvm.businessCategoryController.text
            : vvm.currentUserData.currentUserOrganization?.businessCategory ??
                '',
        businessDescription:
            vvm.currentUserData.currentUserOrganization?.businessDescription ??
                '',
        yearlyProfit:
            vvm.currentUserData.currentUserOrganization?.yearlyProfit ?? 0.0,
        gstNumber: vvm.currentUserData.currentUserOrganization?.gstNumber ?? '',
        uploadGst: vvm.currentUserData.currentUserOrganization?.uploadGst ?? '',
        panNumber: vvm.currentUserData.currentUserOrganization?.panNumber ?? '',
        uploadPan: vvm.currentUserData.currentUserOrganization?.uploadPan ?? '',
      ),

      // ── Each address field sent individually — no more duplication ──
      addressRequest: AddressRequest(
        pinCode: vvm.pinCodeController.text.isNotEmpty
            ? vvm.pinCodeController.text
            : vvm.currentUserData.currentUserAddress?.pinCode ?? '',
        city: vvm.cityController.text.isNotEmpty
            ? vvm.cityController.text
            : vvm.currentUserData.currentUserAddress?.city ?? '',
        state: vvm.stateController.text.isNotEmpty
            ? vvm.stateController.text
            : vvm.currentUserData.currentUserAddress?.state ?? '',
        country: vvm.countryController.text.isNotEmpty
            ? vvm.countryController.text
            : vvm.currentUserData.currentUserAddress?.country ?? '',
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
