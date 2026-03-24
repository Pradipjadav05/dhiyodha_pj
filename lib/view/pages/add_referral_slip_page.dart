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
  const AddReferralSlipPage({Key? key}) : super(key: key);

  @override
  AddReferralSlipPageState createState() => AddReferralSlipPageState();
}

class AddReferralSlipPageState extends State<AddReferralSlipPage> {
  @override
  void initState() {
    super.initState();
    // ────────────────────────────────────────────────────────
    // FIX: "setState() called during build"
    //
    // Root cause: initData() → getMeetingsList() → update() was
    // called synchronously inside initState(), while Flutter was
    // still in the middle of mounting this widget's element tree.
    // update() calls setState() on GetBuilder, which is not
    // allowed during a build phase.
    //
    // Fix: defer initData() to run AFTER the first frame is fully
    // built using addPostFrameCallback. This guarantees the widget
    // tree is mounted before any setState/update() is called.
    // ────────────────────────────────────────────────────────
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }

  Future<void> _initData() async {
    await Get.find<ReferralSlipViewModel>().initData();
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
            'referral_slip'.tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
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
                    const SizedBox(height: paddingSize20),

                    // ── Meeting Selection Dropdown ──
                    SearchableDropdown(
                      value: addReferralsVM.selectedMeetingName,
                      items: addReferralsVM.meetingsList
                          .map((meeting) => meeting['title']!)
                          .toList(),
                      hintText: 'Select Meeting',
                      icon:
                          Image.asset(dropDownArrow, width: 18.0, height: 18.0),
                      onChanged: (val) async {
                        final selectedMeeting =
                            addReferralsVM.meetingsList.firstWhere(
                          (meeting) => meeting['title'] == val,
                          orElse: () => {'uuid': '', 'title': ''},
                        );

                        addReferralsVM.selectedMeetingId =
                            selectedMeeting['uuid'] ?? '';
                        addReferralsVM.selectedMeetingName =
                            selectedMeeting['title'] ?? '';

                        // Clear existing user selection
                        addReferralsVM.toController.clear();
                        addReferralsVM.selectedMemberId = '';
                        addReferralsVM.telephoneController.clear();
                        addReferralsVM.emailController.clear();
                        addReferralsVM.addressController.clear();

                        referralTypeInsideOrOutside(addReferralsVM,
                            addReferralsVM.selectedMeetingId.isNotEmpty);
                        setState(() {});
                      },
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── User Selection: outside meeting → search, inside meeting → dropdown ──
                    Visibility(
                      visible: addReferralsVM.selectedMeetingId.isEmpty,
                      child: InkWell(
                        onTap: () async {
                          final MembersChildData childData = await Get.toNamed(
                              Routes.getMembersPageRoute('true'));
                          addReferralsVM.selectedMemberId =
                              childData.uuid ?? '';
                          addReferralsVM.toController.text =
                              '${childData.firstName} ${childData.lastName}';
                          addReferralsVM.telephoneController.text =
                              childData.mobileNo.toString();
                          addReferralsVM.emailController.text =
                              childData.email.toString();
                          addReferralsVM.addressController.text =
                              '${childData.address} ${childData.address?.city ?? ''}';
                        },
                        child: CommonTextFormField(
                          isEnabled: false,
                          controller: addReferralsVM.toController,
                          hintText: 'to'.tr,
                          hintColor: midnightBlue,
                          suffixIcon: Image.asset(search, color: bluishPurple),
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize20,
                              vertical: paddingSize20),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: addReferralsVM.selectedMeetingId.isNotEmpty,
                      child: SearchableDropdown(
                        value: addReferralsVM.toController.text,
                        items: addReferralsVM.getMeetingWiseUsersName(
                            addReferralsVM.selectedMeetingId),
                        hintText: 'Select Meeting User',
                        icon: Image.asset(dropDownArrow,
                            width: 18.0, height: 18.0),
                        onChanged: (val) {
                          final teamUser =
                              addReferralsVM.getMeetingWiseSelectedUsers(
                                  addReferralsVM.selectedMeetingId, val ?? '');
                          addReferralsVM.selectedMemberId = teamUser.uuid ?? '';
                          addReferralsVM.toController.text =
                              '${teamUser.firstName} ${teamUser.lastName}';
                          addReferralsVM.telephoneController.text =
                              teamUser.mobileNo.toString();
                          addReferralsVM.emailController.text =
                              teamUser.email.toString();
                          addReferralsVM.addressController.text =
                              '${teamUser.address} ${teamUser.address?.city ?? ''}';
                          setState(() {});
                        },
                      ),
                    ),

                    const SizedBox(height: paddingSize25),

                    // ── Referral Type ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'referral_type'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize15),

                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CommonCard(
                                elevation: 2.0,
                                bgColor: addReferralsVM.referralTypeInside.value
                                    ? bluishPurple
                                    : lavenderMist,
                                onTap: () {},
                                cardChild: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: paddingSize15,
                                      vertical: paddingSize10),
                                  child: Center(
                                    child: Text(
                                      'inside'.tr,
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
                                bgColor:
                                    addReferralsVM.referralTypeOutside.value
                                        ? bluishPurple
                                        : lavenderMist,
                                onTap: () {},
                                cardChild: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: paddingSize15,
                                      vertical: paddingSize10),
                                  child: Center(
                                    child: Text(
                                      'outside'.tr,
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
                        )),

                    const SizedBox(height: paddingSize25),

                    // ── Referral Status ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'referral_status'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize15),

                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _statusCheckbox(
                              label: 'told_them_call'.tr,
                              value: addReferralsVM.referralStatusByCall.value,
                              onChanged: (_) {
                                addReferralsVM.referralStatusByCall.value =
                                    !addReferralsVM.referralStatusByCall.value;
                              },
                            ),
                            _statusCheckbox(
                              label: 'given_your_card'.tr,
                              value: addReferralsVM.referralStatusByCards.value,
                              onChanged: (_) {
                                addReferralsVM.referralStatusByCards.value =
                                    !addReferralsVM.referralStatusByCards.value;
                              },
                            ),
                          ],
                        )),

                    const SizedBox(height: paddingSize25),

                    // ── Fields ──
                    CommonTextFormField(
                      controller: addReferralsVM.referralsController,
                      hintText: 'referrals'.tr,
                      hintColor: midnightBlue,
                      suffixIcon: Image.asset(referralsBlue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    const SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      inputType: TextInputType.number,
                      controller: addReferralsVM.telephoneController,
                      hintText: 'telephone'.tr,
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    const SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      controller: addReferralsVM.emailController,
                      hintText: 'email'.tr,
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    const SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      controller: addReferralsVM.addressController,
                      hintText: 'address'.tr,
                      hintColor: midnightBlue,
                      maxLines: 4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    const SizedBox(height: paddingSize25),
                    CommonTextFormField(
                      controller: addReferralsVM.commentController,
                      hintText: 'comments'.tr,
                      maxLines: 4,
                      hintColor: midnightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: paddingSize20, vertical: paddingSize20),
                    ),
                    const SizedBox(height: paddingSize25),

                    // ── Referral Rate ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonTextLabel(
                          labelText: 'referral_rate'.tr,
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingSize25,
                              vertical: paddingSize8),
                        ),
                        Expanded(child: Divider(height: 1.0, color: divider)),
                      ],
                    ),
                    const SizedBox(height: paddingSize25),

                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _hotnessRow(
                              vm: addReferralsVM,
                              value:
                                  addReferralsVM.referralStatusByHotness1.value,
                              rate: 1,
                              barWidth: 40.0,
                              barColor: const Color(0xFFFFB800),
                              onChanged: () =>
                                  _selectHotness(addReferralsVM, 1),
                            ),
                            _hotnessRow(
                              vm: addReferralsVM,
                              value:
                                  addReferralsVM.referralStatusByHotness2.value,
                              rate: 2,
                              barWidth: 80.0,
                              barColor: const Color(0xFFFF8300),
                              onChanged: () =>
                                  _selectHotness(addReferralsVM, 2),
                            ),
                            _hotnessRow(
                              vm: addReferralsVM,
                              value:
                                  addReferralsVM.referralStatusByHotness3.value,
                              rate: 3,
                              barWidth: 120.0,
                              barColor: const Color(0xFFFF5C00),
                              onChanged: () =>
                                  _selectHotness(addReferralsVM, 3),
                            ),
                            _hotnessRow(
                              vm: addReferralsVM,
                              value:
                                  addReferralsVM.referralStatusByHotness4.value,
                              rate: 4,
                              barWidth: 160.0,
                              barColor: const Color(0xFFFF3400),
                              onChanged: () =>
                                  _selectHotness(addReferralsVM, 4),
                            ),
                            _hotnessRow(
                              vm: addReferralsVM,
                              value:
                                  addReferralsVM.referralStatusByHotness5.value,
                              rate: 5,
                              barWidth: 200.0,
                              barColor: const Color(0xFFFF0000),
                              onChanged: () =>
                                  _selectHotness(addReferralsVM, 5),
                            ),
                          ],
                        )),

                    const SizedBox(height: paddingSize25),

                    CommonButton(
                      buttonText: 'confirm'.tr,
                      bgColor: midnightBlue,
                      textColor: periwinkle,
                      onPressed: () async {
                        await _collectDataAndAddReferrals(addReferralsVM);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Status checkbox row ──
  Widget _statusCheckbox({
    required String label,
    required bool value,
    required void Function(bool?) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GFCheckbox(
          inactiveBgColor: ghostWhite,
          activeBgColor: ghostWhite,
          activeIcon: Icon(Icons.check, size: iconSize18, color: bluishPurple),
          size: iconSize20,
          inactiveBorderColor: bluishPurple,
          activeBorderColor: bluishPurple,
          value: value,
          onChanged: onChanged,
        ),
        Text(label,
            style: fontRegular.copyWith(
                color: midnightBlue, fontSize: fontSize14)),
      ],
    );
  }

  // ── Hotness bar row ──
  Widget _hotnessRow({
    required ReferralSlipViewModel vm,
    required bool value,
    required int rate,
    required double barWidth,
    required Color barColor,
    required VoidCallback onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GFCheckbox(
          inactiveBgColor: ghostWhite,
          activeBgColor: ghostWhite,
          activeIcon: Icon(Icons.check, size: iconSize18, color: bluishPurple),
          size: iconSize20,
          inactiveBorderColor: bluishPurple,
          activeBorderColor: bluishPurple,
          value: value,
          onChanged: (_) => onChanged(),
        ),
        Container(
          height: 20.0,
          width: barWidth,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ],
    );
  }

  // ── Select hotness (radio-like — only one at a time) ──
  void _selectHotness(ReferralSlipViewModel vm, int rate) {
    vm.referralHotnessRate.value = rate;
    vm.referralStatusByHotness1.value = rate == 1;
    vm.referralStatusByHotness2.value = rate == 2;
    vm.referralStatusByHotness3.value = rate == 3;
    vm.referralStatusByHotness4.value = rate == 4;
    vm.referralStatusByHotness5.value = rate == 5;
  }

  void referralTypeInsideOrOutside(ReferralSlipViewModel vm, bool isInside) {
    vm.referralTypeInside.value = isInside;
    vm.referralTypeOutside.value = !isInside;
  }

  Future<void> _collectDataAndAddReferrals(
      ReferralSlipViewModel addReferralsVM) async {
    if (addReferralsVM.toController.text.isEmpty) {
      showSnackBar('select_referral_user'.tr);
    } else if (addReferralsVM.referralsController.text.isEmpty) {
      showSnackBar('select_referral'.tr);
    } else if (addReferralsVM.telephoneController.text.isEmpty) {
      showSnackBar('enter_telephone'.tr);
    } else if (addReferralsVM.emailController.text.isEmpty) {
      showSnackBar('enter_email'.tr);
    } else if (addReferralsVM.addressController.text.isEmpty) {
      showSnackBar('enter_address'.tr);
    } else if (addReferralsVM.commentController.text.isEmpty) {
      showSnackBar('enter_comment'.tr);
    } else if (!addReferralsVM.referralStatusByCall.value &&
        !addReferralsVM.referralStatusByCards.value) {
      showSnackBar('select_referral_status'.tr);
    } else if (addReferralsVM.referralHotnessRate.value == 0) {
      showSnackBar('select_referral_rate'.tr);
    } else {
      final String type =
          addReferralsVM.referralTypeOutside.value ? 'OUTSIDE' : 'INSIDE';
      final List<String> selectedStatus = [];
      if (addReferralsVM.referralStatusByCall.value) {
        selectedStatus.add('TOLD_THEM_YOU_WOULD_CALL');
      }
      if (addReferralsVM.referralStatusByCards.value) {
        selectedStatus.add('GIVEN_YOUR_CARD');
      }

      final bool isSuccess = await addReferralsVM.addReferralsData(
        addReferralsVM.selectedMemberId,
        addReferralsVM.selectedMeetingId.isEmpty
            ? null
            : addReferralsVM.selectedMeetingId,
        type,
        selectedStatus,
        addReferralsVM.referralsController.text,
        addReferralsVM.telephoneController.text,
        addReferralsVM.emailController.text,
        addReferralsVM.addressController.text,
        addReferralsVM.commentController.text,
        addReferralsVM.referralHotnessRate.value,
      );

      if (isSuccess) {
        showSnackBar('referral_added'.tr, isError: false);
        Get.back();
      } else {
        showSnackBar('errorMessage'.tr);
      }
    }
  }
}
