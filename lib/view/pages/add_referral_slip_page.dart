import 'package:dhiyodha/model/response_model/members_list_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:dhiyodha/view/widgets/common_text_label.dart';
import 'package:dhiyodha/view/widgets/searchable_dropdown.dart';
import 'package:dhiyodha/viewModel/referral_slip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';

class AddReferralSlipPage extends StatefulWidget {
  AddReferralSlipPageState createState() => AddReferralSlipPageState();
}

class AddReferralSlipPageState extends State<AddReferralSlipPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    await Get.find<ReferralSlipViewModel>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text("referral_slip".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color)),
        ),
        body: GetBuilder<ReferralSlipViewModel>(
          builder: (addReferralsVM) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: paddingSize20),
                    // Meeting Selection Dropdown
                    SearchableDropdown(
                      value: addReferralsVM.selectedMeetingName,
                      items: addReferralsVM.meetingsList
                          .map((meeting) => meeting['title']!)
                          .toList(),
                      hintText: 'Select Meeting',
                      icon: Image.asset(
                        dropDownArrow,
                        width: 18.0,
                        height: 18.0,
                      ),
                      onChanged: (val) async {
                        // Find selected meeting
                        var selectedMeeting =
                            addReferralsVM.meetingsList.firstWhere(
                          (meeting) => meeting['title'] == val,
                          orElse: () => {"uuid": "", "title": ""},
                        );

                        addReferralsVM.selectedMeetingId =
                            selectedMeeting['uuid'] ?? "";
                        addReferralsVM.selectedMeetingName =
                            selectedMeeting['title'] ?? "";

                        // Clear existing user selection
                        addReferralsVM.toController.clear();
                        addReferralsVM.selectedMemberId = "";
                        addReferralsVM.telephoneController.clear();
                        addReferralsVM.emailController.clear();
                        addReferralsVM.addressController.clear();

                        // Fetch meeting users if meeting is selected
                        referralTypeInsideOrOutside(addReferralsVM, addReferralsVM.selectedMeetingId.isNotEmpty == true);

                        setState(() {});
                      },
                    ),
                    SizedBox(height: paddingSize25),
                    // User Selection Field
                    Visibility(
                      visible: addReferralsVM.selectedMeetingId.isEmpty,
                      child: InkWell(
                        onTap: () async {
                          MembersChildData childData = await Get.toNamed(
                              Routes.getMembersPageRoute("true"));
                          addReferralsVM.selectedMemberId =
                              childData.uuid ?? "";
                          addReferralsVM.toController.text =
                              '${childData.firstName} ${childData.lastName}';
                          addReferralsVM.telephoneController.text =
                              childData.mobileNo.toString();
                          addReferralsVM.emailController.text =
                              childData.email.toString();
                          addReferralsVM.addressController.text =
                              childData.address.toString() + " " +childData.address!.city!.toString();
                        },
                        child: CommonTextFormField(
                            isEnabled: false,
                            controller: addReferralsVM.toController,
                            hintText: "to".tr,
                            hintColor: midnightBlue,
                            suffixIcon: Image.asset(
                              search,
                              color: bluishPurple,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingSize20,
                                vertical: paddingSize20)),
                      ),
                    ),
                    Visibility(
                      visible: addReferralsVM.selectedMeetingId.isNotEmpty,
                      child: SearchableDropdown(
                        value: addReferralsVM.toController.text,
                        items: addReferralsVM.getMeetingWiseUsersName(
                            addReferralsVM.selectedMeetingId),
                        hintText: 'Select Meeting User',
                        icon: Image.asset(
                          dropDownArrow,
                          width: 18.0,
                          height: 18.0,
                        ),
                        onChanged: (val) async {
                          var teamUser =
                              addReferralsVM.getMeetingWiseSelectedUsers(
                                  addReferralsVM.selectedMeetingId, val ?? "");
                          addReferralsVM.selectedMemberId = teamUser.uuid ?? "";
                          addReferralsVM.toController.text =
                              '${teamUser.firstName} ${teamUser.lastName}';
                          addReferralsVM.telephoneController.text = teamUser.mobileNo.toString();
                          addReferralsVM.emailController.text = teamUser.email.toString();
                          addReferralsVM.addressController.text = teamUser.address.toString() + " " + teamUser.address!.city!.toString();

                          setState(() {});
                          // Find selected meeting
                          /*var selectedMeeting = addReferralsVM.meetingsList
                              .firstWhere(
                                (meeting) => meeting['title'] == val,
                            orElse: () => {"uuid": "", "title": ""},
                          );

                          addReferralsVM.selectedMeetingId = selectedMeeting['uuid'] ?? "";
                          addReferralsVM.selectedMeetingName = selectedMeeting['title'] ?? "";

                          // Clear existing user selection
                          addReferralsVM.toController.clear();
                          addReferralsVM.selectedMemberId = "";
                          addReferralsVM.telephoneController.clear();
                          addReferralsVM.emailController.clear();
                          addReferralsVM.addressController.clear();

                          // Fetch meeting users if meeting is selected
                          if (addReferralsVM.selectedMeetingId.isNotEmpty) {
                            await addReferralsVM.getMeetingWiseUsers(
                                addReferralsVM.selectedMeetingId);
                          }

                          setState(() {});*/
                        },
                      ),
                    ),
                    SizedBox(height: paddingSize25),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: "referral_type".tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(
                          child: Divider(
                            height: 1.0,
                            color: divider,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: paddingSize15),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CommonCard(
                              elevation: 2.0,
                              bgColor: addReferralsVM.referralTypeInside.value
                                  ? bluishPurple
                                  : lavenderMist,
                              onTap: () {
                                // referralTypeInsideOrOutside(addReferralsVM, true);
                              },
                              cardChild: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: paddingSize15,
                                    vertical: paddingSize10),
                                child: Center(
                                  child: Text(
                                    "inside".tr,
                                    style: fontRegular.copyWith(
                                        color: addReferralsVM
                                                .referralTypeInside.value
                                            ? white
                                            : midnightBlue,
                                        fontSize: fontSize14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: CommonCard(
                              elevation: 2.0,
                              bgColor: addReferralsVM.referralTypeOutside.value
                                  ? bluishPurple
                                  : lavenderMist,
                              onTap: () {
                                // referralTypeInsideOrOutside(addReferralsVM, false);
                              },
                              cardChild: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: paddingSize15,
                                    vertical: paddingSize10),
                                child: Center(
                                  child: Text(
                                    "outside".tr,
                                    style: fontRegular.copyWith(
                                        color: addReferralsVM
                                                .referralTypeOutside.value
                                            ? white
                                            : midnightBlue,
                                        fontSize: fontSize14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: paddingSize25),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                            labelText: "referral_status".tr,
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingSize25,
                                vertical: paddingSize8)),
                        Expanded(
                          child: Divider(
                            height: 1.0,
                            color: divider,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: paddingSize15),
                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: ghostWhite,
                                activeBgColor: ghostWhite,
                                activeIcon: Icon(
                                  Icons.check,
                                  size: iconSize18,
                                  color: bluishPurple,
                                ),
                                size: iconSize20,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value:
                                    addReferralsVM.referralStatusByCall.value,
                                onChanged: (bool? value) {
                                  addReferralsVM.referralStatusByCall.value =
                                      !addReferralsVM
                                          .referralStatusByCall.value;
                                },
                              ),
                              Text(
                                "told_them_call".tr,
                                style: fontRegular.copyWith(
                                    color: midnightBlue, fontSize: fontSize14),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: ghostWhite,
                                activeBgColor: ghostWhite,
                                activeIcon: Icon(
                                  Icons.check,
                                  size: iconSize18,
                                  color: bluishPurple,
                                ),
                                size: iconSize20,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value:
                                    addReferralsVM.referralStatusByCards.value,
                                onChanged: (bool? value) {
                                  addReferralsVM.referralStatusByCards.value =
                                      !addReferralsVM
                                          .referralStatusByCards.value;
                                },
                              ),
                              Text(
                                "given_your_card".tr,
                                style: fontRegular.copyWith(
                                    color: midnightBlue, fontSize: fontSize14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      controller: addReferralsVM.referralsController,
                      hintText: "referrals".tr,
                      hintColor: midnightBlue,
                      suffixIcon: Image.asset(referralsBlue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      inputType: TextInputType.number,
                      controller: addReferralsVM.telephoneController,
                      hintText: "telephone".tr,
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      controller: addReferralsVM.emailController,
                      hintText: "email".tr,
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      controller: addReferralsVM.addressController,
                      hintText: "address".tr,
                      hintColor: midnightBlue,
                      maxLines: 4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      controller: addReferralsVM.commentController,
                      hintText: "comments".tr,
                      maxLines: 4,
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    SizedBox(height: paddingSize25),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                            labelText: "referral_rate".tr,
                            padding: const EdgeInsets.symmetric(
                                horizontal: paddingSize25,
                                vertical: paddingSize8)),
                        Expanded(
                          child: Divider(
                            height: 1.0,
                            color: divider,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: paddingSize25),
                    Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: ghostWhite,
                                activeBgColor: ghostWhite,
                                activeIcon: Icon(
                                  Icons.check,
                                  size: iconSize18,
                                  color: bluishPurple,
                                ),
                                size: iconSize20,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value: addReferralsVM
                                    .referralStatusByHotness1.value,
                                onChanged: (bool? value) {
                                  addReferralsVM
                                          .referralStatusByHotness1.value =
                                      !addReferralsVM
                                          .referralStatusByHotness1.value;
                                  addReferralsVM.referralHotnessRate.value = 1;
                                  addReferralsVM
                                      .referralStatusByHotness2.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness3.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness4.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness5.value = false;
                                },
                              ),
                              Container(
                                height: 20.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFB800),
                                    borderRadius: BorderRadius.circular(4.0)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: ghostWhite,
                                activeBgColor: ghostWhite,
                                activeIcon: Icon(
                                  Icons.check,
                                  size: iconSize18,
                                  color: bluishPurple,
                                ),
                                size: iconSize20,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value: addReferralsVM
                                    .referralStatusByHotness2.value,
                                onChanged: (bool? value) {
                                  addReferralsVM
                                          .referralStatusByHotness2.value =
                                      !addReferralsVM
                                          .referralStatusByHotness2.value;
                                  addReferralsVM.referralHotnessRate.value = 2;
                                  addReferralsVM
                                      .referralStatusByHotness1.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness3.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness4.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness5.value = false;
                                },
                              ),
                              Container(
                                height: 20.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF8300),
                                    borderRadius: BorderRadius.circular(4.0)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: ghostWhite,
                                activeBgColor: ghostWhite,
                                activeIcon: Icon(
                                  Icons.check,
                                  size: iconSize18,
                                  color: bluishPurple,
                                ),
                                size: iconSize20,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value: addReferralsVM
                                    .referralStatusByHotness3.value,
                                onChanged: (bool? value) {
                                  addReferralsVM
                                          .referralStatusByHotness3.value =
                                      !addReferralsVM
                                          .referralStatusByHotness3.value;
                                  addReferralsVM.referralHotnessRate.value = 3;
                                  addReferralsVM
                                      .referralStatusByHotness1.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness2.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness4.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness5.value = false;
                                },
                              ),
                              Container(
                                height: 20.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF5C00),
                                    borderRadius: BorderRadius.circular(4.0)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: ghostWhite,
                                activeBgColor: ghostWhite,
                                activeIcon: Icon(
                                  Icons.check,
                                  size: iconSize18,
                                  color: bluishPurple,
                                ),
                                size: iconSize20,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value: addReferralsVM
                                    .referralStatusByHotness4.value,
                                onChanged: (bool? value) {
                                  addReferralsVM
                                          .referralStatusByHotness4.value =
                                      !addReferralsVM
                                          .referralStatusByHotness4.value;
                                  addReferralsVM.referralHotnessRate.value = 4;
                                  addReferralsVM
                                      .referralStatusByHotness1.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness2.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness3.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness5.value = false;
                                },
                              ),
                              Container(
                                height: 20.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF3400),
                                    borderRadius: BorderRadius.circular(4.0)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GFCheckbox(
                                inactiveBgColor: ghostWhite,
                                activeBgColor: ghostWhite,
                                activeIcon: Icon(
                                  Icons.check,
                                  size: iconSize18,
                                  color: bluishPurple,
                                ),
                                size: iconSize20,
                                inactiveBorderColor: bluishPurple,
                                activeBorderColor: bluishPurple,
                                value: addReferralsVM
                                    .referralStatusByHotness5.value,
                                onChanged: (bool? value) {
                                  addReferralsVM
                                          .referralStatusByHotness5.value =
                                      !addReferralsVM
                                          .referralStatusByHotness5.value;
                                  addReferralsVM.referralHotnessRate.value = 5;
                                  addReferralsVM
                                      .referralStatusByHotness1.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness2.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness3.value = false;
                                  addReferralsVM
                                      .referralStatusByHotness4.value = false;
                                },
                              ),
                              Container(
                                height: 20.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF0000),
                                    borderRadius: BorderRadius.circular(4.0)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: paddingSize25),
                    CommonButton(
                      buttonText: "confirm".tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        await _collectDataAndAddReferrals(addReferralsVM);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  void referralTypeInsideOrOutside(ReferralSlipViewModel addReferralsVM, bool isInsideClick) {
    addReferralsVM.referralTypeInside.value = isInsideClick;
    addReferralsVM.referralTypeOutside.value = !isInsideClick;
  }

  Future<void> _collectDataAndAddReferrals(
      ReferralSlipViewModel addReferralsVM) async {
    if (addReferralsVM.toController.text.isEmpty) {
      showSnackBar("select_referral_user".tr);
    } else if (addReferralsVM.referralsController.text.isEmpty) {
      showSnackBar("select_referral".tr);
    } else if (addReferralsVM.telephoneController.text.isEmpty) {
      showSnackBar("enter_telephone".tr);
    } else if (addReferralsVM.emailController.text.isEmpty) {
      showSnackBar("enter_email".tr);
    } else if (addReferralsVM.addressController.text.isEmpty) {
      showSnackBar("enter_address".tr);
    } else if (addReferralsVM.commentController.text.isEmpty) {
      showSnackBar("enter_comment".tr);
    } else if (!addReferralsVM.referralStatusByCall.value &&
        !addReferralsVM.referralStatusByCall.value) {
      showSnackBar("select_referral_status".tr);
    } else if (addReferralsVM.referralHotnessRate.value == 0) {
      showSnackBar("select_referral_rate".tr);
    } else {
      String type =
          addReferralsVM.referralTypeOutside.value ? "OUTSIDE" : "INSIDE";
      List<String> selectedStatus = [];
      if (addReferralsVM.referralStatusByCall.value) {
        selectedStatus.add("TOLD_THEM_YOU_WOULD_CALL");
      }
      if (addReferralsVM.referralStatusByCards.value) {
        selectedStatus.add("GIVEN_YOUR_CARD");
      }
      bool isSuccess = await addReferralsVM.addReferralsData(
          addReferralsVM.selectedMemberId.toString(),
          addReferralsVM.selectedMeetingId.isEmpty
              ? null
              : addReferralsVM.selectedMeetingId.toString(),
          type,
          selectedStatus,
          addReferralsVM.referralsController.text.toString(),
          addReferralsVM.telephoneController.text.toString(),
          addReferralsVM.emailController.text.toString(),
          addReferralsVM.addressController.text.toString(),
          addReferralsVM.commentController.text.toString(),
          addReferralsVM.referralHotnessRate.value);
      if (isSuccess) {
        Get.back();
        showSnackBar("referral_added".tr, isError: false);
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }

  // Show dialog to select user from meeting attendees
  Future<MembersChildData?> _showMeetingUsersDialog(
      BuildContext context, List<MembersChildData> users) async {
    return await showDialog<MembersChildData>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius10),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Select Meeting Attendee',
                  style: fontBold.copyWith(
                    fontSize: fontSize18,
                    color: midnightBlue,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: users.isEmpty
                      ? Center(
                          child: Text(
                            'No attendees found',
                            style: fontMedium.copyWith(
                              color: midnightBlue,
                              fontSize: fontSize14,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: bluishPurple,
                                child: Text(
                                  '${user.firstName?[0] ?? ''}${user.lastName?[0] ?? ''}',
                                  style: fontBold.copyWith(
                                    color: white,
                                    fontSize: fontSize14,
                                  ),
                                ),
                              ),
                              title: Text(
                                '${user.firstName ?? ''} ${user.lastName ?? ''}',
                                style: fontMedium.copyWith(
                                  color: midnightBlue,
                                  fontSize: fontSize14,
                                ),
                              ),
                              subtitle: Text(
                                user.email ?? '',
                                style: fontRegular.copyWith(
                                  color: midnightBlue.withValues(alpha: 0.7),
                                  fontSize: fontSize12,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop(user);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
