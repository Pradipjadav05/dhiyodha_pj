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
                SizedBox(height: paddingSize25),
                SearchableDropdown(
                  value: vvm.selectedCountry,
                  items: vvm.countryList,
                  hintText: 'Select Country',
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  onChanged: (val) async {
                    vvm.selectedCountry = val ?? "";
                    if (vvm.selectedCountry != vvm.countryList[0]) {
                      await vvm.getStates(vvm.selectedCountry);
                    }
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                SearchableDropdown(
                  value: vvm.selectedState,
                  items: vvm.stateList,
                  hintText: 'Select State',
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  onChanged: (val) async {
                    vvm.selectedState = val ?? "";
                    if (vvm.selectedState != vvm.stateList[0]) {
                      await vvm.getCities(vvm.selectedState);
                    }
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                SearchableDropdown(
                  value: vvm.selectedCity,
                  items: vvm.cityList,
                  hintText: 'Select City',
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  onChanged: (val) {
                    vvm.selectedCity = val ?? "";
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                SearchableDropdown(
                  value: vvm.selectedChapter,
                  items: vvm.chapterList,
                  hintText: 'Select Chapter',
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  onChanged: (val) {
                    vvm.selectedChapter = val ?? "";
                    vvm.teamWiseFillMeeting(vvm.selectedChapter);
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                SearchableDropdown(
                  value: vvm.selectedMeeting,
                  items: vvm.teamWiseMeetingList,
                  hintText: 'Select Meeting',
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  onChanged: (val) {
                    vvm.selectedMeeting = val ?? "";
                    vvm.autoFillSelectedMeetingDate(vvm.selectedMeeting);
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize45),
                InkWell(
                  onTap: () async {
                    // await vvm.selectDate(context);
                  },
                  child: CommonTextFormField(
                    isEnabled: false,
                    controller: vvm.dateController,
                    hintText: "select_date".tr,
                    hintColor: midnightBlue,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    suffixIcon: Image.asset(calendar),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                ),
                SizedBox(height: paddingSize25),
                SearchableDropdown(
                  value: vvm.selectedBusinessCategory,
                  items: vvm.businessCatList,
                  hintText: 'Select Business Category',
                  icon: Image.asset(
                    dropDownArrow,
                    width: 18.0,
                    height: 18.0,
                  ),
                  onChanged: (val) {
                    vvm.selectedBusinessCategory = val ?? "";
                    widget.onStateChanged();
                  },
                ),
                SizedBox(height: paddingSize25),
                CommonTextFormField(
                  controller: vvm.nameController,
                  hintText: "enter_name".tr,
                  hintColor: midnightBlue,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize20),
                ),
                SizedBox(height: paddingSize25),
                CommonTextFormField(
                  controller: vvm.emailController,
                  hintText: "enter_email".tr,
                  hintColor: midnightBlue,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize20),
                ),
                SizedBox(height: paddingSize25),
                CommonTextFormField(
                  maxLength: 10,
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
                    hintColor: midnightBlue,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    suffixIcon: Image.asset(uploadCard),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                ),
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
                SizedBox(height: paddingSize25),
                InkWell(
                  onTap: () async {
                    vvm.imageUploadType = ImageUploadType.frontVisitingCard;
                    await _showImageSelectionDialog();
                  },
                  child: CommonTextFormField(
                    isEnabled: false,
                    hintText: "upload_visiting_card".tr + " Front",
                    hintColor: midnightBlue,
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    suffixIcon: Image.asset(uploadCard),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                ),
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
                    textStyle: fontRegular.copyWith(
                        color: midnightBlue, fontSize: fontSize14),
                    suffixIcon: Image.asset(uploadCard),
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingSize20, vertical: paddingSize20),
                  ),
                ),
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
                    Text(
                      "confirm_visitor".tr,
                      style: fontRegular.copyWith(
                          color: midnightBlue, fontSize: fontSize12),
                    ),
                  ],
                ),
                SizedBox(height: paddingSize25),
                CommonButton(
                  buttonText: "confirm".tr,
                  bgColor: midnightBlue,
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
                                  color: midnightBlue, fontSize: fontSize16)),
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
                                  color: midnightBlue, fontSize: fontSize16)),
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
}
