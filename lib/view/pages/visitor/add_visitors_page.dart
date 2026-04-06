import 'dart:io';

import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/viewModel/visitors_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

import '../../../utils/resource/app_constants.dart';
import '../../widgets/searchable_dropdown.dart';

class AddVisitorFormWidget extends StatefulWidget {
  final VisitorsViewModel visitorsViewModel;
  final VoidCallback onStateChanged;

  const AddVisitorFormWidget({
    Key? key,
    required this.visitorsViewModel,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<AddVisitorFormWidget> createState() => _AddVisitorFormWidgetState();
}

class _AddVisitorFormWidgetState extends State<AddVisitorFormWidget> {
  VisitorsViewModel get vvm => widget.visitorsViewModel;
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _chapterController = TextEditingController();
  final TextEditingController _teamWiseMeetingController =
      TextEditingController();
  final TextEditingController _businessCatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: vvm.isLoading,
                  child: LinearProgressIndicator(
                    color: midnightBlue,
                    backgroundColor: lavenderMist,
                    borderRadius: BorderRadius.circular(radius20),
                  ),
                ),
                _autocompleteField(
                  label: 'select_country'.tr,
                  icon: Icons.public_outlined,
                  controller: _countryController,
                  options: vvm.countryList
                      .where((c) => c != 'Select Country')
                      .toList(),
                  onSelected: (val) async {
                    vvm.selectedCountry = val ?? "";
                    if (vvm.selectedCountry != vvm.countryList[0]) {
                      await vvm.getStates(vvm.selectedCountry);
                    }
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                _autocompleteField(
                  label: 'select_state'.tr,
                  icon: Icons.map_outlined,
                  controller: _stateController,
                  options:
                      vvm.stateList.where((s) => s != 'Select State').toList(),
                  onSelected: (val) async {
                    vvm.selectedState = val ?? "";
                    if (vvm.selectedState != vvm.stateList[0]) {
                      await vvm.getCities(vvm.selectedState);
                    }
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                _autocompleteField(
                  label: 'select_city'.tr,
                  icon: Icons.location_city_outlined,
                  controller: _cityController,
                  options:
                      vvm.cityList.where((c) => c != 'Select City').toList(),
                  onSelected: (val) {
                    vvm.selectedCity = val ?? "";
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                _autocompleteField(
                  label: 'select_chapter'.tr,
                  icon: Icons.groups_outlined,
                  controller: _chapterController,
                  options: vvm.chapterList
                      .where((c) => c != 'Select Chapter')
                      .toList(),
                  onSelected: (val) {
                    vvm.selectedChapter = val ?? "";
                    vvm.teamWiseFillMeeting(vvm.selectedChapter);
                    widget.onStateChanged();
                  },
                ),

                SizedBox(height: paddingSize25),
                _autocompleteField(
                  label: 'Select Meeting'.tr,
                  icon: Icons.groups_outlined,
                  controller: _teamWiseMeetingController,
                  options: vvm.teamWiseMeetingList
                      .where((c) => c != 'Select Meeting')
                      .toList(),
                  onSelected: (val) {
                    vvm.selectedMeeting = val ?? "";
                    vvm.autoFillSelectedMeetingDate(vvm.selectedMeeting);
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),

                // SearchableDropdown(
                //   value: vvm.selectedMeeting,
                //   items: vvm.teamWiseMeetingList,
                //   hintText: 'Select Meeting',
                //   icon: Image.asset(
                //     dropDownArrow,
                //     width: 18.0,
                //     height: 18.0,
                //   ),
                //   onChanged: (val) {
                //     vvm.selectedMeeting = val ?? "";
                //     vvm.autoFillSelectedMeetingDate(vvm.selectedMeeting);
                //     widget.onStateChanged();
                //   },
                // ),
                CommonTextFormField(
                  // isEnabled: false,
                  controller: vvm.dateController,
                  hintText: "select_date".tr,
                  hintColor: midnightBlue,
                  bgColor: white,
                  textStyle: fontRegular.copyWith(
                      color: bluishPurple, fontSize: fontSize14),
                  suffixIcon: Image.asset(calendar),
                  onTap: () async {
                    await vvm.selectDate(context);
                  },
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize20),
                ),
                SizedBox(height: paddingSize25),
                _autocompleteField(
                  label: 'select_business_category'.tr,
                  icon: Icons.business_center_outlined,
                  controller: _businessCatController,
                  options: vvm.businessCatList
                      .where((b) => b != vvm.businessCatList[0])
                      .toList(),
                  onSelected: (val) {
                    vvm.selectedBusinessCategory = val ?? "";
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                CommonTextFormField(
                  bgColor: white,
                  controller: vvm.nameController,
                  hintText: "enter_name".tr,
                  hintColor: white,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize20),
                ),
                SizedBox(height: paddingSize25),
                CommonTextFormField(
                  controller: vvm.emailController,
                  hintText: "enter_email".tr,
                  bgColor: white,
                  hintColor: midnightBlue,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize20),
                ),
                SizedBox(height: paddingSize25),
                CommonTextFormField(
                  maxLength: 10,
                  bgColor: white,
                  inputType: TextInputType.number,
                  controller: vvm.contactNumberController,
                  hintText: "contact_number".tr,
                  hintColor: midnightBlue,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize20),
                ),
                SizedBox(height: paddingSize25),
                CommonTextFormField(
                  controller: vvm.companyNameController,
                  hintText: "company_name".tr,
                  bgColor: white,
                  hintColor: midnightBlue,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize20),
                ),
                SizedBox(height: paddingSize25),
                InkWell(
                  onTap: () async {
                    vvm.imageUploadType = ImageUploadType.profileImage;
                    await _showImageSelectionDialog();
                  },
                  child: CommonTextFormField(
                    isEnabled: false,
                    hintText: "profile_upload".tr,
                    bgColor: white,
                    hintColor: midnightBlue,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    suffixIcon: Image.asset(uploadCard),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                ),
                if (!(vvm.uploadedProfilePictureFile == null &&
                    vvm.isImageUploadSuccess.isFalse)) ...[
                  SizedBox(height: paddingSize25),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(radius10)),
                    child: vvm.uploadedProfilePictureFile == null &&
                            vvm.isImageUploadSuccess.isFalse
                        ? Container()
                        : Image.file(
                            height: 200.0,
                            width: double.infinity,
                            File(vvm.uploadedProfilePictureFile!.path),
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                ],

                SizedBox(height: paddingSize25),
                InkWell(
                  onTap: () async {
                    vvm.imageUploadType = ImageUploadType.frontVisitingCard;
                    await _showImageSelectionDialog();
                  },
                  child: CommonTextFormField(
                    isEnabled: false,
                    hintText: "upload_visiting_card".tr + " Front",
                    bgColor: white,
                    hintColor: bluishPurple,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    suffixIcon: Image.asset(uploadCard),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                ),
                if (!(vvm.uploadedVCardFrontFile == null &&
                    vvm.isVCardFrontSuccess.isFalse)) ...[
                  SizedBox(height: paddingSize25),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(radius10)),
                    child: vvm.uploadedVCardFrontFile == null &&
                            vvm.isVCardFrontSuccess.isFalse
                        ? Container()
                        : Image.file(
                            height: 200.0,
                            width: double.infinity,
                            File(vvm.uploadedVCardFrontFile!.path),
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                ],

                SizedBox(height: paddingSize25),
                InkWell(
                  onTap: () async {
                    vvm.imageUploadType = ImageUploadType.backVisitingCard;
                    await _showImageSelectionDialog();
                  },
                  child: CommonTextFormField(
                    isEnabled: false,
                    hintText: "upload_visiting_card".tr + " Back",
                    hintColor: midnightBlue,
                    bgColor: white,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    suffixIcon: Image.asset(uploadCard),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                ),
                if (!(vvm.uploadedVCardBackFile == null &&
                    vvm.isVCardBackSuccess.isFalse)) ...[
                  SizedBox(height: paddingSize25),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(radius10)),
                    child: vvm.uploadedVCardBackFile == null &&
                            vvm.isVCardBackSuccess.isFalse
                        ? Container()
                        : Image.file(
                            height: 200.0,
                            width: double.infinity,
                            File(vvm.uploadedVCardBackFile!.path),
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                ],

                SizedBox(height: paddingSize25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GFCheckbox(
                      activeBgColor: ghostWhite,
                      activeIcon: Icon(
                        Icons.check,
                        size: iconSize18,
                        color: bluishPurple,
                      ),
                      size: iconSize20,
                      inactiveBgColor: lavenderMist,
                      inactiveBorderColor: lavenderMist,
                      activeBorderColor: bluishPurple,
                      value: vvm.isAgreeTerms.value,
                      onChanged: (value) {
                        vvm.isAgreeTerms.value = value;
                      },
                    ),
                    Expanded(
                      child: Text(
                        "confirm_visitor".tr,
                        style: fontRegular.copyWith(
                            color: bluishPurple, fontSize: fontSize12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingSize25),
                CommonButton(
                  buttonText: "confirm".tr,
                  bgColor: bluishPurple,
                  textColor: periwinkle,
                  onPressed: () async {
                    await _collectDataAndAddVisitors();
                  },
                )
              ],
            ),
          )),
    );
  }

  Future<void> _showImageSelectionDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius10)),
            elevation: 0,
            child: Container(
              height: 180.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "select_image_source".tr,
                      style: fontMedium.copyWith(
                          color: black, fontSize: fontSize16),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          Image.asset(
                            postUpload,
                            width: iconSize24,
                            height: iconSize24,
                          ),
                          SizedBox(
                            width: paddingSize10,
                          ),
                          Text("gallery".tr,
                              style: fontBold.copyWith(
                                  color: bluishPurple, fontSize: fontSize16)),
                        ],
                      ),
                      onTap: () async {
                        Get.back();
                        await vvm.pickImage("SOCIAL_IMAGE");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          Image.asset(
                            camera,
                            color: bluishPurple,
                            height: iconSize24,
                            width: iconSize24,
                          ),
                          SizedBox(
                            width: paddingSize10,
                          ),
                          Text("camera".tr,
                              style: fontBold.copyWith(
                                  color: bluishPurple, fontSize: fontSize16)),
                        ],
                      ),
                      onTap: () async {
                        Get.back();
                        await vvm.clickCameraImage("SOCIAL_IMAGE");
                      },
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  Future<void> _collectDataAndAddVisitors() async {
    if (vvm.selectedCountry.isEmpty ||
        vvm.selectedCountry == vvm.countryList[0]) {
      showSnackBar("select_country".tr);
    } else if (vvm.selectedState.isEmpty ||
        vvm.selectedState == vvm.stateList[0]) {
      showSnackBar("select_state".tr);
    } else if (vvm.selectedCity.isEmpty ||
        vvm.selectedCity == vvm.cityList[0]) {
      showSnackBar("select_city".tr);
    } else if (vvm.selectedChapter.isEmpty ||
        vvm.selectedChapter == vvm.chapterList[0]) {
      showSnackBar("select_chapter".tr);
    } else if (vvm.selectedMeeting.isEmpty) {
      showSnackBar("select_meeting".tr);
    } else if (vvm.dateController.text.isEmpty) {
      showSnackBar("enter_date".tr);
    } else if (vvm.selectedBusinessCategory.isEmpty ||
        vvm.selectedBusinessCategory == vvm.chapterList[0]) {
      showSnackBar("select_business_category".tr);
    } else if (vvm.nameController.text.isEmpty) {
      showSnackBar("enter_name".tr);
    } else if (vvm.emailController.text.isEmpty) {
      showSnackBar("enter_email".tr);
    } else if (vvm.contactNumberController.text.isEmpty) {
      showSnackBar("enter_contact_no".tr);
    } else if (vvm.companyNameController.text.isEmpty) {
      showSnackBar("enter_cmp_name".tr);
    } else if (!vvm.isAgreeTerms.value) {
      showSnackBar("agree_terms".tr);
    } else if (!vvm.isImageUploadSuccess.value) {
      showSnackBar("upload_photo".tr);
    } else {
      bool isSuccess = await vvm.addVisitors(
          vvm.selectedCountry.toString(),
          vvm.selectedState.toString(),
          vvm.selectedCity.toString(),
          vvm.selectedChapter.toString(),
          vvm.selectedMeetingCode.toString(),
          vvm.selectedMeeting.toString(),
          vvm.dateController.text.toString(),
          vvm.selectedBusinessCategory.toString(),
          vvm.nameController.text.toString(),
          vvm.emailController.text.toString(),
          vvm.contactNumberController.text.toString(),
          vvm.companyNameController.text.toString(),
          globalCurrentUserData.uuid,
          vvm.profileUrl.toString(),
          vvm.uploadFrontVisitingCard.toString(),
          vvm.uploadBackVisitingCard.toString());
      if (isSuccess) {
        Get.back(closeOverlays: true, canPop: true);
        showSnackBar("visitor_added".tr, isError: false);
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }

  // ── Autocomplete field ──
  Widget _autocompleteField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required List<String> options,
    required void Function(String) onSelected,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) return options;
        return options.where((o) =>
            o.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (String option) => option,
      onSelected: (String selection) {
        controller.text = selection;
        onSelected(selection);
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        if (controller.text.isEmpty && fieldController.text.isNotEmpty) {
          fieldController.clear();
        }
        return Focus(
          onFocusChange: (hasFocus) => setState(() {}),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    focusNode.hasFocus ? bluishPurple : const Color(0xFFE3E8F4),
                width: focusNode.hasFocus ? 1.8 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: focusNode.hasFocus
                      ? bluishPurple.withOpacity(0.1)
                      : const Color(0xFF1E3A5F).withOpacity(0.05),
                  blurRadius: focusNode.hasFocus ? 12 : 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Icon(icon,
                    color: focusNode.hasFocus
                        ? bluishPurple
                        : bluishPurple.withOpacity(0.45),
                    size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: fieldController,
                    focusNode: focusNode,
                    style: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: fontRegular.copyWith(
                          color: midnightBlue.withOpacity(0.4),
                          fontSize: fontSize14),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: AnimatedRotation(
                    turns: focusNode.hasFocus ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: bluishPurple.withOpacity(0.6),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(14),
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE3E8F4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: bluishPurple.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: const Color(0xFFEAEEF8),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return InkWell(
                      onTap: () => onSelected(option),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: fontRegular.copyWith(
                                    color: bluishPurple, fontSize: fontSize14),
                              ),
                            ),
                            Icon(Icons.check_rounded,
                                size: 16, color: bluishPurple.withOpacity(0.3)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
